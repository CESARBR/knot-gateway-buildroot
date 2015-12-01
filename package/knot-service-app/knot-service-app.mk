################################################################################
#
# knot-service-app
#
################################################################################

KNOT_SERVICE_APP_VERSION = ca3a9dde8ffca51b5c65e511ff1e5232cd97bf3a
KNOT_SERVICE_APP_SITE = https://gitlab.cesar.org.br/cesar-iot/knot-service-source.git
KNOT_SERVICE_APP_SITE_METHOD = git
KNOT_SERVICE_APP_INSTALL_STAGING = YES
KNOT_SERVICE_APP_INSTALL_TARGET = NO
KNOT_SERVICE_APP_DEPENDENCIES = libglib2 json-c libcurl knot-protocol-lib
KNOT_SERVICE_APP_AUTORECONF = YES

$(eval $(autotools-package))
