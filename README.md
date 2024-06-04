<!-- markdownlint-disable -->
<p align="center">
    <a href="https://github.com/DevelopersToolbox/">
        <img src="https://cdn.wolfsoftware.com/assets/images/github/organisations/developerstoolbox/black-and-white-circle-256.png" alt="DevelopersToolbox logo" />
    </a>
    <br />
    <a href="https://github.com/DevelopersToolbox/validate-json/actions/workflows/cicd.yml">
        <img src="https://img.shields.io/github/actions/workflow/status/DevelopersToolbox/validate-json/cicd.yml?branch=master&label=build%20status&style=for-the-badge" alt="Github Build Status" />
    </a>
    <a href="https://github.com/DevelopersToolbox/validate-json/blob/master/LICENSE.md">
        <img src="https://img.shields.io/github/license/DevelopersToolbox/validate-json?color=blue&label=License&style=for-the-badge" alt="License">
    </a>
    <a href="https://github.com/DevelopersToolbox/validate-json">
        <img src="https://img.shields.io/github/created-at/DevelopersToolbox/validate-json?color=blue&label=Created&style=for-the-badge" alt="Created">
    </a>
    <br />
    <a href="https://github.com/DevelopersToolbox/validate-json/releases/latest">
        <img src="https://img.shields.io/github/v/release/DevelopersToolbox/validate-json?color=blue&label=Latest%20Release&style=for-the-badge" alt="Release">
    </a>
    <a href="https://github.com/DevelopersToolbox/validate-json/releases/latest">
        <img src="https://img.shields.io/github/release-date/DevelopersToolbox/validate-json?color=blue&label=Released&style=for-the-badge" alt="Released">
    </a>
    <a href="https://github.com/DevelopersToolbox/validate-json/releases/latest">
        <img src="https://img.shields.io/github/commits-since/DevelopersToolbox/validate-json/latest.svg?color=blue&style=for-the-badge" alt="Commits since release">
    </a>
    <br />
    <a href="https://github.com/DevelopersToolbox/validate-json/blob/master/.github/CODE_OF_CONDUCT.md">
        <img src="https://img.shields.io/badge/Code%20of%20Conduct-blue?style=for-the-badge" />
    </a>
    <a href="https://github.com/DevelopersToolbox/validate-json/blob/master/.github/CONTRIBUTING.md">
        <img src="https://img.shields.io/badge/Contributing-blue?style=for-the-badge" />
    </a>
    <a href="https://github.com/DevelopersToolbox/validate-json/blob/master/.github/SECURITY.md">
        <img src="https://img.shields.io/badge/Report%20Security%20Concern-blue?style=for-the-badge" />
    </a>
    <a href="https://github.com/DevelopersToolbox/validate-json/issues">
        <img src="https://img.shields.io/badge/Get%20Support-blue?style=for-the-badge" />
    </a>
</p>

## Overview

This is a very simple tool for validating a JSON string. It utilises [jq](https://stedolan.github.io/jq/) for this purpose and wraps the output into something more consumable within other scripts.

> Also see: [json-lint](https://github.com/CICDToolbox/json-lint) for out travis plugin that performs a similar function.

## Usage

There are 4 different options when it comes to using the validation tool.

1. You can validate a raw json string
2. You can validate the contents of a file
3. You can just make use of error / return codes
4. You can be given error messages as well as return codes

The first 2 options are handled by 2 different exposed functions.

### Raw string

```shell
source validate-json.sh

validate_json "<raw json string>"
```

### From file

```shell
source validate-json.sh

validate_json_from_file "<filename>"
```

> This function will load the file contents into a string and then execute validate_json, so the final validation method is exactly the same to ensure identical results.

In additional to the two different wants to pass the data to the validator there are also 2 different ways to get data out of the validator.

### Verbose Mode (default)

Verbose mode will display messages relating to the validity of the string, either everything was ok, or the specific error message returned by jq. It will also use return codes for success (0) and failure (1).

```shell
source validate-json.sh

validate_json_from_file "<filename>"
```

### Silent Mode

This mode will suppress all output to the screen and will only use return codes.

```shell
silence_messages=true

source validate-json.sh

validate_json_from_file "<filename>"
```

> This is particularly useful if you want to embed the validation into another script and take different actions depending on the result.

#### Embedding Silent Mode

```shell
silence_messages=true

source validate-json.sh

if validate_json_from_file "<filename>"; then
    go_perform_some_action_on_data
else
    do_something_else_like_raise_an_error
fi
```

<br />
<p align="right"><a href="https://wolfsoftware.com/"><img src="https://img.shields.io/badge/Created%20by%20Wolf%20on%20behalf%20of%20Wolf%20Software-blue?style=for-the-badge" /></a></p>
