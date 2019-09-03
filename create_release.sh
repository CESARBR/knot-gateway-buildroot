#!/bin/bash
TMP_PATH=tmp

CLONE_METHOD=git@github.com:

KNOT_ORG=CESARBR
KNOT_REPOS=(knot-cloud-source knot-gateway-webui \
knot-hal-source \
knot-protocol-source \
knot-service-source \
knot-fog-connector \
knot-network-nrf24 \
knot-gateway-netsetup \
knot-gateway-control \
knot-cloud \
zephyr-knot-sdk \
zephyr \
knot-thing-source)

# Default branch for zephyr-knot-sdk is ot-setup
SDK=ot-setup

function continueIfYes() {
    echo "Do you want to continue? [y|N]"
    read resp
    if [ "$resp" != "y" ];
    then
        if [ "$resp" != "Y" ];
        then
            exit 1
        fi
    fi
}

function deleteRemoteTags() {
    echo "Do you want to remove $TAG from ALL remotes?"
    continueIfYes
    cd ..
    for repo in ${KNOT_REPOS[@]}; do
        git push origin --delete "$TAG"
    done
    exit 1
}

function showHelp() {
    echo "Tool helps the creation of KNoT release."
    echo " Usage: create_release [--org org] [--no-clean] [--https] [--push] \
[--protocol hash] [--service hash] [--hal hash] [--nrf24 hash] \
[--fog hash] [--connector hash] [--web hash] [--cloud hash] \
[--sdk hash] [--zephyr hash] [--thing hash]"
    echo "-h, -?, --help Show this menu."
    echo "--org Changes base path to repositories. Default is CESARBR."
    echo "--https Clone using https. Default is ssh."
    echo "--no-clean Do NOT remove tmp folder created."
    echo "--push Pushes created commit into knot-gateway-buildroot."
    echo "--protocol Applies tag into knot-protocol-source at specified hash, tag or branch."
    echo "--service Applies tag into knot-service-source at specified hash, tag or branch."
    echo "--hal Applies tag into knot-hal-source at specified hash, tag or branch."
    echo "--nrf24 Applies tag into knot-network-nrf24 at specified hash, tag or branch."
    echo "--fog Applies tag into knot-cloud-source at specified hash, tag or branch."
    echo "--connector Applies tag into knot-fog-connector at specified hash, tag or branch."
    echo "--web Applies tag into knot-gateway-webui at specified hash, tag or branch."
    echo "--cloud Applies tag into knot-cloud at specified hash, tag or branch."
    echo "--sdk Applies tag into zephyr-knot-sdk at specified hash, tag or branch."
    echo "--zephyr Applies tag into zephyr-knot-sdk at specified hash, tag or branch."
    echo "--thing Applies tag into zephyr-knot-sdk at specified hash, tag or branch."
    echo "--netsetup Applies tag into knot-gateway-netsetup at specified hash, tag or branch."
    echo "--control Applies tag into knot-gateway-control at specified hash, tag or branch."
    echo "--docs Applies tag into knot-documentation at specified hash, tag or branch. Not supported yet."
}

function changeTagBase() {
    case "$1" in
        knot-cloud-source)
        if [ ! -z "$FOG" ]; then
            echo "Using $FOG on knot-cloud-source"
            git checkout "$FOG"
        fi
        ;;
        knot-gateway-webui)
        if [ ! -z "$WEB" ]; then
            echo "Using $WEB on knot-gateway-webui"
            git checkout "$WEB"
        fi
        ;;
        knot-hal-source)
        if [ ! -z "$HAL" ]; then
            echo "Using $HAL on knot-hal-source"
            git checkout "$HAL"
        fi
        ;;
        knot-protocol-source)
        if [ ! -z "$PROTO" ]; then
            echo "Using $PROTO on knot-protocol-source"
            git checkout "$PROTO"
        fi
        ;;
        knot-service-source)
        if [ ! -z "$SVC" ]; then
            echo "Using $SVC on knot-service-source"
            git checkout "$SVC"
        fi
        ;;
        knot-fog-connector)
        if [ ! -z "$CONN" ]; then
            echo "Using $CONN on knot-fog-connector"
            git checkout "$CONN"
        fi
        ;;
        knot-network-nrf24)
        if [ ! -z "$NRF" ]; then
            echo "Using $NRF on knot-network-nrf24"
            git checkout "$NRF"
        fi
        ;;
        knot-cloud)
        if [ ! -z "$CLOUD" ]; then
            echo "Using $CLOUD on knot-cloud"
            git checkout "$CLOUD"
        fi
        ;;
        zephyr-knot-sdk)
        if [ ! -z "$SDK" ]; then
            echo "Using $SDK on zephyr-knot-sdk"
            git checkout "$SDK"
        fi
        ;;
        zephyr)
        if [ ! -z "$ZEPHYR" ]; then
            echo "Using $ZEPHYR on zephyr"
            git checkout "$ZEPHYR"
        fi
        ;;
        knot-thing-source)
        if [ ! -z "$THING" ]; then
            echo "Using $THING on knot-thing-source"
            git checkout "$THING"
        fi
        ;;
	knot-gateway-netsetup)
        if [ ! -z "$NETSETUP" ]; then
            echo "Using $NETSETUP on knot-gateway-netsetup"
            git checkout "$NETSETUP"
        fi
        ;;
	knot-gateway-control)
        if [ ! -z "$CONTROL" ]; then
            echo "Using $CONTROL on knot-gateway-control"
            git checkout "$CONTROL"
        fi
        ;;
    esac
    if [ ! $? -eq 0 ]; then
        echo "An error occured on checkout."
        deleteRemoteTags
    fi
}

while (( "$#" )); do
    [[ $1 == --*=* ]] && set -- "${1%%=*}" "${1#*=}" "${@:2}"
    case "$1" in
        -h|-?|--help)
        showHelp
        exit 0
        ;;
        --org)
        KNOT_ORG=$2
        shift 2
        ;;
        --https)
        CLONE_METHOD=https://github.com/
        shift 1
        ;;
        --no-clean)
        NO_CLEAN=1
        shift 1
        ;;
        --push)
        PUSH=1
        shift 1
        ;;
        --protocol)
        PROTO=$2
        shift 2
        ;;
        --service)
        SVC=$2
        shift 2
        ;;
        --hal)
        HAL=$2
        shift 2
        ;;
        --nrf24)
        NRF=$2
        shift 2
        ;;
        --fog)
        FOG=$2
        shift 2
        ;;
        --connector)
        CONN=$2
        shift 2
        ;;
        --web)
        WEB=$2
        shift 2
        ;;
        --cloud)
        CLOUD=$2
        shift 2
        ;;
        --sdk)
        SDK=$2
        shift 2
        ;;
        --zephyr)
        ZEPHYR=$2
        shift 2
        ;;
        --thing)
        THING=$2
        shift 2
        ;;
        --netsetup)
        NETSETUP=$2
        shift 2
        ;;
        --control)
        CONTROL=$2
        shift 2
        ;;
        --) # end argument parsing
        shift
        break
        ;;
        -*|--*|*) # unsupported flags
        echo "Error: Unsupported flag $1" >&2
        exit 1
        ;;
    esac
done

if [ -d "$TMP_PATH" ]
then
    echo "A directory named $TMP_PATH already exists."
    echo "If you continue this will erase the existing directory."
    continueIfYes
    rm -rf "$TMP_PATH"
fi

mkdir -p "$TMP_PATH" && cd "$TMP_PATH"
read -p "Tag to apply: " TAG

for repo in ${KNOT_REPOS[@]}; do
    git clone "${CLONE_METHOD}${KNOT_ORG}/${repo}"
    if [ ! $? -eq 0 ]; then
        exit 1
    fi

    cd "$repo"
    changeTagBase "$repo"
    git tag "$TAG" && git push origin "$TAG"
    if [ ! $? -eq 0 ]; then
        echo "An error occured while tagging remote."
        deleteRemoteTags
    fi

    cd ..
done

cd ..
if [ -z "$NO_CLEAN" ]; then
    echo "Removing $TMP_PATH"
    rm -rf "$TMP_PATH"
fi

# TODO
# Change KNOT_*_SITE in knot-*.mk files if --org is passed
sed -i "/KNOT_FOG_VERSION/ s/=.*/= $TAG/g" ./package/knot-fog/knot-fog.mk
sed -i "/KNOT_FOG_CONNECTOR_VERSION/ s/=.*/= $TAG/g" ./package/knot-fog-connector/knot-fog-connector.mk
sed -i "/KNOT_WEB_VERSION/ s/=.*/= $TAG/g" ./package/knot-web/knot-web.mk
sed -i "/KNOT_HAL_DRIVER_VERSION/ s/=.*/= $TAG/g" ./package/knot-hal-driver/knot-hal-driver.mk
sed -i "/KNOT_NETWORK_NRF24_VERSION/ s/=.*/= $TAG/g" ./package/knot-network-nrf24/knot-network-nrf24.mk
sed -i "/KNOT_PROTOCOL_LIB_VERSION/ s/=.*/= $TAG/g" ./package/knot-protocol-lib/knot-protocol-lib.mk
sed -i "/KNOT_SERVICE_APP_VERSION/ s/=.*/= $TAG/g" ./package/knot-service-app/knot-service-app.mk
sed -i "/KNOT_NETSETUP_VERSION/ s/=.*/= $TAG/g" ./package/knot-netsetup/knot-netsetup.mk
sed -i "/KNOT_CONTROL_VERSION/ s/=.*/= $TAG/g" ./package/knot-control/knot-control.mk
git add package/knot-fog/knot-fog.mk package/knot-web/knot-web.mk \
package/knot-hal-driver/knot-hal-driver.mk \
package/knot-protocol-lib/knot-protocol-lib.mk \
package/knot-service-app/knot-service-app.mk \
package/knot-fog-connector/knot-fog-connector.mk \
package/knot-netsetup/knot-netsetup.mk \
package/knot-control/knot-control.mk \
package/knot-network-nrf24/knot-network-nrf24.mk
git commit
git tag "$TAG"

if [ ! -z "$PUSH" ]; then
    echo "Pushing to knot-gateway-buildroot"
fi
