################################################################################
#
# knot-service-app
#
################################################################################

KNOT_SERVICE_APP_VERSION = app_proto
KNOT_SERVICE_APP_SITE = https://gitlab.cesar.org.br/cesar-iot/knot-service-source.git
KNOT_SERVICE_APP_SITE_METHOD = git
KNOT_SERVICE_APP_INSTALL_STAGING = NO
KNOT_SERVICE_APP_INSTALL_TARGET = YES
KNOT_SERVICE_APP_DEPENDENCIES = libglib2 json-c libcurl knot-protocol-lib
KNOT_SERVICE_APP_AUTORECONF = YES

$(eval $(autotools-package))
