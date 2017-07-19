#!/bin/bash
read -p "Tag to apply: " TAG
sed -i "/KNOT_FOG_VERSION/ s/=.*/= $TAG/g" ./package/knot-fog/knot-fog.mk
sed -i "/KNOT_WEB_VERSION/ s/=.*/= $TAG/g" ./package/knot-web/knot-web.mk
sed -i "/KNOT_HAL_DRIVER_VERSION/ s/=.*/= $TAG/g" ./package/knot-hal-driver/knot-hal-driver.mk
sed -i "/KNOT_PROTOCOL_LIB_VERSION/ s/=.*/= $TAG/g" ./package/knot-protocol-lib/knot-protocol-lib.mk
sed -i "/KNOT_SERVICE_APP_VERSION/ s/=.*/= $TAG/g" ./package/knot-service-app/knot-service-app.mk
sed -i "/KNOT_SERVICE_APP_CONF_ENV/ s/\(KNOT-\)[^ /]*/$TAG/g" package/knot-service-app/knot-service-app.mk
git add package/knot-fog/knot-fog.mk package/knot-web/knot-web.mk package/knot-hal-driver/knot-hal-driver.mk package/knot-protocol-lib/knot-protocol-lib.mk package/knot-service-app/knot-service-app.mk
git commit
git tag "$TAG"
