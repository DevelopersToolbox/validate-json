#!/usr/bin/env bash

# -------------------------------------------------------------------------------- #
# Description                                                                      #
# -------------------------------------------------------------------------------- #
# A simple JSON string / file validator.                                           #
# -------------------------------------------------------------------------------- #

# -------------------------------------------------------------------------------- #
# Global Variables                                                                 #
# -------------------------------------------------------------------------------- #
# Global variables which can be set by the calling script, but need to be declared #
# here also to ensure the script is clean and error free.                          #
#                                                                                  #
# silence_messages - should be silence all output and only use return codes?       #
# -------------------------------------------------------------------------------- #

declare silence_messages

# -------------------------------------------------------------------------------- #
# Local Variables                                                                  #
# -------------------------------------------------------------------------------- #
# The local variables which can be overridden by the global variables above.       #
#                                                                                  #
# local_silence_messages - should be silence all output and only use return codes? #
# -------------------------------------------------------------------------------- #

local_silence_messages=false

# -------------------------------------------------------------------------------- #
# Check Prerequisites                                                              #
# -------------------------------------------------------------------------------- #
# Check to ensure that the prerequisite commmands exist.                           #
# -------------------------------------------------------------------------------- #

function check_prereqs
{
    if ! command -v "jq" > /dev/null 2>&1; then
        echo "jq is not installed - unable to continue - aborting"
        exit 1
    fi
}

# -------------------------------------------------------------------------------- #
# Set Global Variables                                                             #
# -------------------------------------------------------------------------------- #
# Check to see if the global overrides are set and if so, override the defaults.   #
#                                                                                  #
# Error checking is in place to ensure that the override contains a valid value of #
# true or false, anything else is ignored.                                         #
# -------------------------------------------------------------------------------- #

function setup_global_variables
{
    if [[ -n "${silence_messages}" ]] && [[ "${silence_messages}" = false || "${silence_messages}" = true ]]; then
         local_silence_messages=${silence_messages}
    fi
}

# -------------------------------------------------------------------------------- #
# My Echo                                                                          #
# -------------------------------------------------------------------------------- #
# A wrapper for echo to honor the silence_messages option.                         #
# -------------------------------------------------------------------------------- #

function my_echo()
{
    message=${1:-}

    if [[ "${local_silence_messages}" = true ]]; then
        return
    fi

    if [[ -n "${message}" ]]; then
        echo "${message}"
    fi
}

# -------------------------------------------------------------------------------- #
# Validate JSON                                                                    #
# -------------------------------------------------------------------------------- #
# Use jq to check if a given string represents a valid JSON string.                #
# -------------------------------------------------------------------------------- #

function validate_json()
{
    json_string=$1

    if errors=$(jq . 2>&1 <<<"${json_string}"); then
        return 0
    fi
    my_echo "${errors}"
    return 1
}

# -------------------------------------------------------------------------------- #
# Validate JSON from file                                                          #
# -------------------------------------------------------------------------------- #
# A wrapper allowing the user to load a json string from a file and pass it to the #
# validate_json function.                                                          #
# -------------------------------------------------------------------------------- #

function validate_json_from_file()
{
    filename=${1:-}


    if [[ ! -r "${filename}" ]]; then
        my_echo "Cannot read file: ${filename}"
        return 0
    fi

    raw_json=$(<"${filename}")

    if errors=$(validate_json "${raw_json}"); then
        my_echo "JSON appears to be valid"
        return 0
    fi

    my_echo "${errors}"
    return 1
}

# -------------------------------------------------------------------------------- #
# Main()                                                                           #
# -------------------------------------------------------------------------------- #
# This is the actual 'script' and the functions/sub routines are called in order.  #
# -------------------------------------------------------------------------------- #

check_prereqs
setup_global_variables

# -------------------------------------------------------------------------------- #
# End of Script                                                                    #
# -------------------------------------------------------------------------------- #
# This is the end - nothing more to see here.                                      #
# -------------------------------------------------------------------------------- #
