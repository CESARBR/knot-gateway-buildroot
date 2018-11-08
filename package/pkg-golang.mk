################################################################################
# Golang package infrastructure
#
# This file implements an infrastructure that eases development of package .mk
# files for Go packages. It should be used for all packages that are written in
# go.
#
# See the Buildroot documentation for details on the usage of this
# infrastructure
#
#
# In terms of implementation, this golang infrastructure requires the .mk file
# to only specify metadata information about the package: name, version,
# download URL, etc.
#
# We still allow the package .mk file to override what the different steps are
# doing, if needed. For example, if <PKG>_BUILD_CMDS is already defined, it is
# used as the list of commands to perform to build the package, instead of the
# default golang behavior. The package can also define some post operation
# hooks.
#
################################################################################

GO_BIN = $(HOST_DIR)/bin/go
GLIDE_BIN = $(HOST_DIR)/bin/glide
DEP_BIN = $(HOST_DIR)/bin/dep

# We pass an empty GOBIN, otherwise "go install: cannot install
# cross-compiled binaries when GOBIN is set"
GO_TARGET_ENV = \
	$(HOST_GO_TARGET_ENV) \
	PATH=$(BR_PATH) \
	GOBIN= \
	CGO_ENABLED=$(HOST_GO_CGO_ENABLED)

GO_HOST_ENV = \
	GOROOT="$(HOST_GO_ROOT)" \
	CC="$(HOSTCC_NOCCACHE)" \
	CXX="$(HOSTCXX_NOCCACHE)" \
	GOTOOLDIR="$(HOST_GO_TOOLDIR)" \
	PATH=$(BR_PATH) \
	GOBIN= \
	CGO_ENABLED=$(HOST_GO_CGO_ENABLED)

################################################################################
# inner-golang-package -- defines how the configuration, compilation and
# installation of a Go package should be done, implements a few hooks to tune
# the build process for Go specificities and calls the generic package
# infrastructure to generate the necessary make targets
#
#  argument 1 is the lowercase package name
#  argument 2 is the uppercase package name, including a HOST_ prefix for host
#             packages
#  argument 3 is the uppercase package name, without the HOST_ prefix for host
#             packages
#  argument 4 is the type (target or host)
################################################################################

define inner-golang-package

$(2)_WORKSPACE ?= _gopath

ifeq ($(BR2_STATIC_LIBS),y)
$(2)_LDFLAGS += -extldflags '-static'
endif

$(2)_BUILD_OPTS += -ldflags "$$($(2)_LDFLAGS)"
$(2)_BUILD_OPTS += -tags "$$($(2)_TAGS)"

# Target packages need the Go compiler on the host.
$(2)_DEPENDENCIES += host-go

$(2)_GO_GET ?= NO
$(2)_GO_GLIDE ?= NO
$(2)_GO_DEP ?= NO

ifeq ($($(2)_GO_GLIDE),YES)
$(2)_DEPENDENCIES += host-go-glide
endif

ifeq ($($(2)_GO_DEP),YES)
$(2)_DEPENDENCIES += host-go-dep
endif

$(2)_BUILD_TARGETS ?= .

# If the build target is just ".", then we assume the binary to be
# produced is named after the package. If however, a build target has
# been specified, we assume that the binaries to be produced are named
# after each build target building them (below in <pkg>_BUILD_CMDS).
ifeq ($$($(2)_BUILD_TARGETS),.)
$(2)_BIN_NAME ?= $(1)
endif

$(2)_INSTALL_BINS ?= $(1)

# Source files in Go should be extracted in a precise folder in the hierarchy
# of GOPATH. It usually resolves around domain/vendor/software. By default, we
# derive domain/vendor/software from the upstream URL of the project, but we
# allow $(2)_SRC_SUBDIR to be overridden if needed.
$(2)_SRC_DOMAIN = $$(call domain,$$($(2)_SITE))
$(2)_SRC_VENDOR = $$(word 1,$$(subst /, ,$$(call notdomain,$$($(2)_SITE))))
$(2)_SRC_SOFTWARE = $$(word 2,$$(subst /, ,$$(call notdomain,$$($(2)_SITE))))

$(2)_SRC_SUBDIR ?= $$($(2)_SRC_DOMAIN)/$$($(2)_SRC_VENDOR)/$$($(2)_SRC_SOFTWARE)
$(2)_SRC_PATH = $$(@D)/$$($(2)_WORKSPACE)/src/$$($(2)_SRC_SUBDIR)

# Configure step. Only define it if not already defined by the package .mk
# file.
ifndef $(2)_CONFIGURE_CMDS
define $(2)_CONFIGURE_CMDS
	mkdir -p $$(dir $$($(2)_SRC_PATH))
	ln -sf $$(@D) $$($(2)_SRC_PATH)
endef
endif

# Build step. Only define it if not already defined by the package .mk
# file.
ifndef $(2)_BUILD_CMDS
define $(2)_BUILD_CMDS
	echo $$($(2)_DEPENDENCIES)
	$$(foreach d,$$($(2)_BUILD_TARGETS),\
		cd $$($(2)_SRC_PATH); \
		export $(if $(findstring $(4),target),$$(GO_TARGET_ENV),$$(GO_HOST_ENV)) \
			GOPATH="$$(@D)/$$($(2)_WORKSPACE)" \
			$$($(2)_GO_ENV) && \
			$(if $(findstring $($(2)_GO_GLIDE),YES),$$(GLIDE_BIN) install &&) \
			$(if $(findstring $($(2)_GO_DEP),YES),$$(DEP_BIN) ensure -v &&) \
			$(if $(findstring $($(2)_GO_GET),YES),$$(GO_BIN) get -d &&) \
			$$(GO_BIN) build -v $$($(2)_BUILD_OPTS) \
			-o $$(@D)/bin/$$(or $$($(2)_BIN_NAME),$$(notdir $$(d))) \
			./$$(d)
	)
endef
endif

# Target installation step. Only define it if not already defined by the
# package .mk file.
ifndef $(2)_INSTALL_TARGET_CMDS
define $(2)_INSTALL_TARGET_CMDS
	$$(foreach d,$$($(2)_INSTALL_BINS),\
		$(INSTALL) -D -m 0755 $$(@D)/bin/$$(d) $(TARGET_DIR)/usr/bin/$$(d)
	)
endef
endif

ifndef $(2)_INSTALL_CMDS
define $(2)_INSTALL_CMDS
	$$(foreach d,$$($(2)_INSTALL_BINS),\
		$(INSTALL) -D -m 0755 $$(@D)/bin/$$(d) $(HOST_DIR)/usr/bin/$$(d)
	)
endef
endif

# Call the generic package infrastructure to generate the necessary make
# targets
$(call inner-generic-package,$(1),$(2),$(3),$(4))

endef # inner-golang-package

################################################################################
# golang-package -- the target generator macro for Go packages
################################################################################

golang-package = $(call inner-golang-package,$(pkgname),$(call UPPERCASE,$(pkgname)),$(call UPPERCASE,$(pkgname)),target)
host-golang-package = $(call inner-golang-package,host-$(pkgname),$(call UPPERCASE,host-$(pkgname)),$(call UPPERCASE,$(pkgname)),host)
