#!/bin/bash
set -e

WORKING_DIR="/home/alpha/alpha-node/ping-management"
LATEST_FILE=$WORKING_DIR"/latest.txt"
LOG_FILE=$WORKING_DIR"/ping_log.log"

if [[ ! -f $LATEST_FILE ]]
then
    touch $LATEST_FILE
    echo "ALPHA STARTED AT: "$(date -u) >> $LATEST_FILE
    echo "LAST PING EPOCH:" >> $LATEST_FILE
fi

if [[ ! -f $LOG_FILE ]]
then
    touch $LOG_FILE
    echo "ALPHA STARTED AT: "$(date -u) >> $LOG_FILE
fi

if [[ "${1}" != "" ]]; then
    NETWORK=$1
    NEAR_ENV=$NETWORK
    RPC_URL="http://127.0.0.1:3030/status"

    if [[ "${NETWORK}" == "mainnet" ]]; then
        RPC_URL="https://rpc.mainnet.near.org"
    fi
else
        echo "Follow this pattern: "
        echo "ping-script.sh testnet"
fi

CURRENT_EPOCH=$(curl -s http://127.0.0.1:3030/status | jq .sync_info.epoch_start_height)
LAST_UPDATE_EPOCH=$(tail -n 1 $LATEST_FILE)

if [[ "$CURRENT_EPOCH" != "$LAST_UPDATE_EPOCH" ]]
then
    echo $CURRENT_EPOCH >> $LATEST_FILE
    echo "["$(date -u)"]: ---------------" >> $LOG_FILE
    near call alpha-centauri.factory.shardnet.near '{}' --accountId alpha-centauri.shardnet.near --gas=300000000000000 >> $LOG_FILE
    echo "-----------------------------------" >> $LOG_FILE
fi
