#!/bin/bash
TMP_PATH=tmp

GITHUB_SSH=git@github.com:

KNOT_ORG=CESARBR
KNOT_REPOS=(knot-cloud-source knot-gateway-webui \
knot-hal-source \
knot-protocol-source \
knot-service-source \
knot-fog-connector \
knot-network-nrf24 \
knot-cloud)

function continueIfYes() {
    echo "Do you want to continue? [y|N]"
    read resp
    if [ "$resp" != "y" ];
    then
        if [ "$resp" != "Y" ];
        then
            exit 0
        fi
    fi
}

if [ -d "$TMP_PATH" ]
then
    echo "A directory named $TMP_PATH already exists."
    echo "If you continue this will erase the existing directory."
    continueIfYes
    rm -rf "$TMP_PATH"
fi

mkdir -p "$TMP_PATH" && cd "$TMP_PATH"

for repo in ${KNOT_REPOS[@]}; do
    git clone "${GITHUB_SSH}${KNOT_ORG}/${repo}"
    if [ ! $? -eq 0 ]; then
        exit 1
    fi
done

read -p "Tag to apply: " TAG
sed -i "/KNOT_FOG_VERSION/ s/=.*/= $TAG/g" ./package/knot-fog/knot-fog.mk
sed -i "/KNOT_FOG_CONNECTOR_VERSION/ s/=.*/= $TAG/g" ./package/knot-fog-connector/knot-fog-connector.mk
sed -i "/KNOT_WEB_VERSION/ s/=.*/= $TAG/g" ./package/knot-web/knot-web.mk
sed -i "/KNOT_HAL_DRIVER_VERSION/ s/=.*/= $TAG/g" ./package/knot-hal-driver/knot-hal-driver.mk
sed -i "/KNOT_NETWORK_NRF24_VERSION/ s/=.*/= $TAG/g" ./package/knot-network-nrf24/knot-network-nrf24.mk
sed -i "/KNOT_PROTOCOL_LIB_VERSION/ s/=.*/= $TAG/g" ./package/knot-protocol-lib/knot-protocol-lib.mk
sed -i "/KNOT_SERVICE_APP_VERSION/ s/=.*/= $TAG/g" ./package/knot-service-app/knot-service-app.mk
git add package/knot-fog/knot-fog.mk package/knot-web/knot-web.mk \
package/knot-hal-driver/knot-hal-driver.mk \
package/knot-protocol-lib/knot-protocol-lib.mk \
package/knot-service-app/knot-service-app.mk \
package/knot-fog-connector/knot-fog-connector.mk \
package/knot-network-nrf24/knot-network-nrf24.mk
git commit
git tag "$TAG"
