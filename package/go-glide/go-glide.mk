################################################################################
#
# glide
#
################################################################################

GO_GLIDE_VERSION = v0.13.2
GO_GLIDE_SITE = $(call github,Masterminds,glide,$(GO_GLIDE_VERSION))
GO_GLIDE_LICENSE = Glide
GO_GLIDE_LICENSE_FILES = LICENSE
HOST_GO_GLIDE_BIN_NAME = glide
HOST_GO_GLIDE_INSTALL_BINS = glide

$(eval $(host-golang-package))
