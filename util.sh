#!/bin/bash

util-append-unique-text-to-file() {
	TEXT=$(echo "${1}"| tr -d '\n')
	FILE_PATH="${2}"

	if [ ! -z "$(tail -c 1 "$FILE_PATH")" ]; then
        echo -e "" >> "${FILE_PATH}"
    fi

	if [[ -f "${FILE_PATH}" ]]; then
		! grep -Fq "${TEXT}" "${FILE_PATH}" && echo -e "${TEXT}" >> "${FILE_PATH}" || true
	else
		util-print-header "ERROR: File does note exist ${FILE_PATH}"
		exit 1
	fi
}

util-print-header() {
	echo
	echo "==========================================="
	echo $1
	echo "==========================================="
	echo
}