#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# This is a very simple (almost trivial) example of how to make use of the         #
# os-detect script and embed os detection into your scripts.                       #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Global Overrides                                                                 #
# -------------------------------------------------------------------------------- #
# These variables allow us to override the parse script defaults.                  #
#                                                                                  #
# silence_messages - should be silence all output and only use return codes?       #
#                                                                                  #
# You can uncomment the value below to override the default value of false.        #
# -------------------------------------------------------------------------------- #

# shellcheck disable=SC2034
silence_messages=true

# -------------------------------------------------------------------------------- #
# Use the source                                                                   #
# -------------------------------------------------------------------------------- #
# Source the validate-json script to make the functions available.                 #
# -------------------------------------------------------------------------------- #

# shellcheck disable=SC2312
SCRIPTPATH="$( dirname "$( cd "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )" )"

# shellcheck disable=SC1090,SC1091
source "${SCRIPTPATH}"/src/validate-json.sh

filename=${1:-}

if [[ -z "${filename}" ]]; then
    echo "Specify a filename"
    exit 1
fi

validate_json_from_file "${filename}"

# -------------------------------------------------------------------------------- #
# End of Script                                                                    #
# -------------------------------------------------------------------------------- #
# This is the end - nothing more to see here.                                      #
