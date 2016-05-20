################################################################################
#
# knot-service-app
#
################################################################################

KNOT_SERVICE_APP_VERSION = 8fddd8066ebe80aa5a68d58c18edff4642a0a8b7
KNOT_SERVICE_APP_SITE = https://gitlab.cesar.org.br/cesar-iot/knot-service-source.git
KNOT_SERVICE_APP_SITE_METHOD = git
KNOT_SERVICE_APP_INSTALL_STAGING = NO
KNOT_SERVICE_APP_INSTALL_TARGET = YES
KNOT_SERVICE_APP_DEPENDENCIES = libglib2 json-c libcurl knot-protocol-lib
KNOT_SERVICE_APP_AUTORECONF = YES

$(eval $(autotools-package))
