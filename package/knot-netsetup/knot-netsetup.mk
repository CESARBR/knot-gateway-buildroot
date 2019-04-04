################################################################################
#
# knot-netsetup
#
################################################################################

KNOT_NETSETUP_VERSION = 38d747f445377f45e4a858d9d252282f631372a0
KNOT_NETSETUP_SITE = https://github.com/CESARBR/knot-gateway-netsetup.git
KNOT_NETSETUP_SITE_METHOD = git
KNOT_NETSETUP_SETUP_TYPE = setuptools

$(eval $(python-package))
