#!/bin/bash

mkdir -p /home/decred/certs/dcrwallet /home/decred/certs/stakepoold

cd /home/decred/go/src/github.com/decred/dcrstakepool

unset $DCRSTAKE_POOL_DCR_RPC_USER
unset $DCRSTAKE_POOL_DCR_RPC_PASS

echo "Processing wallet hosts: $WALLET_HOSTS"
echo "Set DCR_RPC_USER and DCR_RPC_PASS"

for host in $(echo $WALLET_HOSTS | sed "s/,/ /g")
do
    echo "$host"
    if [ -z "$DCRSTAKE_POOL_DCR_RPC_USER" ]
    then
      export DCRSTAKE_POOL_DCR_RPC_USER=$DCR_RPC_USER
    else
      export DCRSTAKE_POOL_DCR_RPC_USER=$DCRSTAKE_POOL_DCR_RPC_USER,$DCR_RPC_USER
    fi

    if [ -z "$DCRSTAKE_POOL_DCR_RPC_PASS" ]
    then
      export DCRSTAKE_POOL_DCR_RPC_PASS=$DCR_RPC_PASS
    else
      export DCRSTAKE_POOL_DCR_RPC_PASS=$DCRSTAKE_POOL_DCR_RPC_PASS,$DCR_RPC_PASS
    fi
done

# Fix the hidden chars
export VOTING_WALLET_EXT_PUB=$(echo $VOTING_EXT_PUB | sed $'s/[^[:print:]\t]//g')

# debug
#echo "DCR_RPC_USER: $DCRSTAKE_POOL_DCR_RPC_USER"
#echo "DCR_RPC_PASS; $DCRSTAKE_POOL_DCR_RPC_PASS"
#echo "VOTING WALLET EXT PUB: $VOTING_WALLET_EXT_PUB"

# Wait while Wallet created
while [ ! -f /home/decred/certs/stakepoold/*.cert ]
do
  echo "$(date) - Please upload the Certificates with: ./dcrstart.sh --upload-cert"
  sleep 10
done

sleep 30

# Set Readiness Probe Test
touch /home/decred/alive

dcrstakepool --coldwalletextpub=$COLD_WALLET_EXT_PUB --apisecret=$API_SECRET --cookiesecret=$COOKIE_SECRET --dbpassword=$STAKEPOOL_MYSQL_DB_PASSWORD --dbhost=dcrstakepool-mysql --adminips=$ADMIN_IPS --adminuserids=$ADMIN_IDS --votingwalletextpub=$VOTING_WALLET_EXT_PUB --wallethosts=$WALLET_HOSTS --walletcerts=$WALLET_CERTS --walletusers=$DCRSTAKE_POOL_DCR_RPC_USER --walletpasswords=$DCRSTAKE_POOL_DCR_RPC_PASS --maxvotedage=8640 --poolfees=7.5 --stakepooldhosts=$WALLET_HOSTS --stakepooldcerts=$STAKEPOOL_CERTS --poolemail=$POOL_EMAIL --poollink=$POOL_LINK --smtpfrom=$SMTP_FROM --smtphost=$SMTP_HOST --smtpusername=$SMTP_USERNAME --smtppassword=$SMTP_PASSWORD $TESTNET
