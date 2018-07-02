#!/usr/bin/env bash

##
# @file  cibot_rest_api.sh
# @brief API collection to send webhook messages to a github server

##
# @brief API to write comment to new pull request with curl
# @param
# arg1: token key
# arg2: message
# arg3: commit address
function cibot_comment(){
    # check if input argument is correct.
    if [[ $1 == "" || $2 == "" || $3 == "" ]]; then
        printf "[DEBUG] ERROR: Please, input correct arguments to run cibot_comment function.\n"
        exit 1
    fi

    # argeuments
    TOKEN="$1"
    MESSAGE="$2"
    COMMIT_ADDRESS="$3"
    
    echo -e "[DEBUG] Running the curl-based commenting procedure."
    echo -e "[DEBUG] TOKEN: $TOKEN"
    echo -e "[DEBUG] MESSAGE: $MESSAGE"
    echo -e "[DEBUG] COMMIT_ADDRESS: $COMMIT_ADDRESS"
    
    # let's do PR report
    /usr/bin/curl -H "Content-Type: application/json" \
     -H "Authorization: token "$TOKEN"  " \
     --data "{\"body\":\"$MESSAGE\"}" \
    $COMMIT_ADDRESS

    echo -e "[DEBUG] Return value of the curl webhook command is '$?'. If the value is 0, it means that webhook operation is normal."
    echo -e "[DEBUG] Note: If webhook server replies \"message\": \"Not Found\", add a privileged user id at 'Setting - Collaborators'."
    echo -e "[DEBUG] Note: The privileged user id has to be appended by \"Write\" permission."
    echo -e "[DEBUG] Note: If webhook server replies \"message\": \"Bad credentials\", try do it again with a correct token key."

}

##
# @brief API to change a status of the pull request with curl
# @param
# arg1: token number
# arg2: state
# arg3: context
# arg4: description
# arg5: target_url
# arg5: commit address
function cibot_pr_report(){
    # check if input argument is correct.
    if [[ $1 == "" || $2 == ""  || $3 == ""  || $4 == ""  || $5 == "" || $6 == "" ]]; then
        printf "[DEBUG] ERROR: Please, input correct arguments to run cibot_pr_report function.\n"
        exit 1
    fi
    # argeuments
    TOKEN="$1"
    STATE="$2"
    CONTEXT="$3"
    DESCRIPTION="$4"
    TARGET_URL="$5"
    COMMIT_ADDRESS="$6"
    
    echo -e "[DEBUG] Running the curl-based PR status change procedure."
    
    # let's do PR report
    /usr/bin/curl -H "Content-Type: application/json" \
    -H "Authorization: token "$TOKEN"  " \
    --data "{\"state\":\"$STATE\",\"context\":\"$CONTEXT\",\"description\":\"$DESCRIPTION\",\"target_url\":\"$TARGET_URL\"}" \
    $COMMIT_ADDRESS

    echo -e "[DEBUG] Return value of the curl webhook command is '$?'. If the value is 0, it means that webhook operation is normal."
    echo -e "[DEBUG] Note: If webhook server replies \"message\": \"Not Found\", add a privileged user id at 'Setting - Collaborators'."
    echo -e "[DEBUG] Note: The privileged user id has to be appended by \"Write\" permission."
    echo -e "[DEBUG] Note: If webhook server replies \"message\": \"Bad credentials\", try do it again with a correct token key."
}