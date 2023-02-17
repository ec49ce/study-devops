#!/usr/bin/env bash
T1=$(date +%s)
K8SENV="./env"
K8SDP="./kubernetes"
CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

source ./vars.sh
source ./func/func.sh
source ./func/menu.sh

export RELEASE_VER=$(cat .ver 2>/dev/null)
alias kubectl='kubectl --insecure-skip-tls-verify'


deploy() {
    # Check ENV
    if [[ $1 != @($DEP_ENV) ]]; then
        echo -e $line"\n${red}ERROR: Unknown deployment type!${rst}"
    exit 1
    fi

    # Start new log
    LOGFILE="${CWD}/${DEPLOYDATE}-deploy-${1}.log"
    echo "--- Start LOG" > "${LOGFILE}"

    printf "${spacer}" "Importing: ${1}-env.sh ${dots}"
    source $K8SENV/$1-env.sh &>/dev/null && echo $ok || (
        echo -e $fail"\n"$line"\n${red}ERROR: Environments file not found in ${K8SENV}/${1}-env.sh${rst}"
        exit 1
    ) || exit

    # Deployment data head output
    echo "--- ${DEPLOYDATE} :: Begin deployment. (NS: ${NAMESPACE}, TAG: ${RELEASE_VER}) ---" >>"${LOGFILE}"
    echo "---[ ${bpur}Begin deployment${rst} ]---"
    echo "Namespace:  ${bgrn}${NAMESPACE^^}${rst}"
    echo "Version:    ${bgrn}${RELEASE_VER}${rst}"

    for APP in "${DEPLOY_APPS[@]}"; do
        kube_deploy $NAMESPACE $APP $K8SDP/$APP.yaml
    done

    # Final running time
    echo $line
    T2=$(date +%s)
    let "TSUM1 = T2 - T1"
    echo "The script has been running for ${bpur}${TSUM1}${rst} second."
    echo "${bgrn}Deploy complete!${rst}"
}

# Start script
if [[ -z $RELEASE_VER ]]; then
  echo "${red}ERROR: Release version file .ver not found!${rst}"
  exit 1
fi
clear
echo $deploy
menu_env