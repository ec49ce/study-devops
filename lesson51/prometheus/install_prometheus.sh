#! /bin/env bash

red="$( echo -e '\033[0;31m' )" # Red
grn="$( echo -e '\033[0;32m' )" # Green
rst="$( echo -e '\033[0m' )"    # Reset Color format

err="${red}ERROR:${rst}"
help="Usage: ./install_prometheus.sh [-u] [-f value_file_path] [-r release_name] [-n namespace]"

# set defaults args
VALUE_FILE="prometheus.yaml"
RELEASE="prometheus"
NAMESPACE="monitoring"
COMMAND="install"
ACTION="Installing"

# get args
while [ -n "$1" ]; do
  case "$1" in
    -u)
      COMMAND="upgrade"
      ACTION="Updating";;
    -f)
      if [ -z "$2" ]; then
        echo -e $err" value file not specified\n"$help; exit 1
      else 
        VALUE_FILE="$2"
      fi
      shift ;;
    -r)
      if [ -z "$2" ]; then
        echo -e $err" release name not specified\n"$help; exit 1
      else 
        RELEASE="$2"
      fi
      shift ;;
    -n)
      if [ -z "$2" ]; then
        echo -e $err" release name not specified\n"$help; exit 1
      else 
        NAMESPACE="$2"
      fi
      shift ;;
    -h)
      echo $help
      shift ;;
    *)
      echo -e $err" $1 is not an option\n"$help; exit 1
  esac
  shift
done

kubectl --insecure-skip-tls-verify get ns ${NAMESPACE} &>>/dev/null || kubectl --insecure-skip-tls-verify create ns ${NAMESPACE}
echo -e $grn"${ACTION} Helm Chart kube-prometheus-stack to namespace ${NAMESPACE}..."$rst
helm --kube-insecure-skip-tls-verify ${COMMAND} -n ${NAMESPACE} -f ${VALUE_FILE} ${RELEASE} prometheus-community/kube-prometheus-stack
