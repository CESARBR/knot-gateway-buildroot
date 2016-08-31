################################################################################
#
# knot-service-app
#
################################################################################

KNOT_SERVICE_APP_VERSION = f7fb18ae041df643340ff3dd346345fd878ba1dd
KNOT_SERVICE_APP_SITE = https://github.com/CESARBR/knot-service-source.git
KNOT_SERVICE_APP_SITE_METHOD = git
KNOT_SERVICE_APP_INSTALL_STAGING = NO
KNOT_SERVICE_APP_INSTALL_TARGET = YES
KNOT_SERVICE_APP_DEPENDENCIES = libglib2 json-c libcurl knot-protocol-lib
KNOT_SERVICE_APP_AUTORECONF = YES

$(eval $(autotools-package))
