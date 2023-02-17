#!/usr/bin/env bash

menu_env() {
    printf "%b" "${line}\n"\
    "${bpur}Select environment:${rst}\n"\
    "${line}\n"\
    "${bylw}1${rst}) ${wht}Dev${rst}\n"\
    "${bylw}2${rst}) ${wht}Prod${rst}\n"\
    "${line}\n"\
    "${bylw}Q${rst}) ${red}Exit${rst}\n"
    while :; do
        echo
        read -rsN1 -p"${ylw}Your choice?${rst} " y
        case $y in
            1)
                echo "${wht}Dev environment${rst}"
                deploy dev
                break
            ;;
            2)
                echo "${wht}Prod environment${rst}"
                deploy prod
                break
            ;;
            q|Q)
                echo "${wht}Quiting...${rst}"
                exit 0
            ;;
            *)
                echo "${red}Wrong! Try again?${rst}"
            ;;
        esac
    done
}