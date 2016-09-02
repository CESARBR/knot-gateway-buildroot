################################################################################
#
# knot-fog
#
################################################################################

KNOT_FOG_VERSION = afc145ce8fdc66b820801db6e1fafbe0aff4a765
KNOT_FOG_SITE = $https://github.com/CESARBR/knot-cloud-source.git
KNOT_FOG_DEPENDENCIES = nodejs

define KNOT_FOG_INSTALL_TARGET_CMDS
        cd $(@D) && $(NPM) install -g
endef

$(eval $(generic-package))
