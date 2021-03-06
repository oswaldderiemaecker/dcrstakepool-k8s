# **Experimental - Under Development - Use at your own risk**

# Decred Wallet

[DcrWallet](https://github.com/decred/dcrwallet) is the secure Decred wallet daemon written in Go (golang).

## Building the docker images

```bash
cd ./docker/dcrwallet/
docker build -t oswald/dcrwallet .
docker push oswald/dcrwallet:latest
```

## Starting the Decred Wallet
```bash
kubectl create namespace cold-wallet
kubectl create configmap testnet-config --from-literal=testnet=--testnet -n cold-wallet
kubectl create secret -n cold-wallet generic rpc-user --from-literal=user=YOUR_USER
kubectl create secret -n cold-wallet generic rpc-pass --from-literal=password=YOUR_PASSWORD
kubectl get secrets -n cold-wallet
kubectl create -f cold-wallet-deployment.yaml --save-config
kubectl get pods -n cold-wallet --watch
```

Wait till the READY state is 1/1 STATUS Running. Then press CTRL-C.

## Creating the Decred wallet

```bash
kubectl exec -ti cold-wallet-0 -n cold-wallet -- sh -c '/home/decred/go/bin/dcrwallet --create $TESTNET'
```

## Starting the Decred wallets

```bash
kubectl exec -ti cold-wallet-0 -n cold-wallet -- /bin/bash
dcrwallet -u $RPC_USER -P $RPC_PASS $TESTNET
```

## Getting Decred coins

Connect to the Decred Wallet Pod.

```bash
kubectl exec -ti cold-wallet-0 -n cold-wallet -- /bin/bash
```

Create a Decred Address.

```bash
dcrctl --wallet -u $RPC_USER -P $RPC_PASS $TESTNET getaccountaddress "default"
```

```bash
dcrctl --wallet -u $RPC_USER -P $RPC_PASS $TESTNET getbalance
```

Goto the [Decred Faucet](https://faucet.decred.org/) site, paste in your account address.

## Submit the Address to the Decred Stakepool

```bash
dcrctl -u $RPC_USER -P $RPC_PASS $TESTNET --wallet validateaddress YOUR_ACCOUNT_ADDRESS
```

Get the public key address (pubkeyaddr) and paste it in the Address / Submit Address page of the Decred Stakepool.

Verify that your public key address belongs to your wallet.

```bash
dcrctl -u $RPC_USER -P $RPC_PASS $TESTNET --wallet validateaddress YOUR_PUBLIC_KEY_ADDRESS
```

In the result, you will see fields such as "ismine" and "account" if the address is present.

## Ticket Setting

On the Ticket page.

Your multisignature script for delegating votes has been generated.

Import it locally into your wallet using dcrctl for safe keeping, so you can recover your funds and vote in the unlikely event of a pool failure:

```bash
dcrctl -u $RPC_USER -P $RPC_PASS $TESTNET --wallet importscript YOUR_MULTISIGNATURE
```

You can now Manual purchasing Tickets (see step 3/B).

```
dcrctl -u $RPC_USER -P $RPC_PASS $TESTNET --wallet purchaseticket "default" 100 1 YOUR_TICKET_ADDRESS 1 THE_POOL_ADDRESS 7.5
```

You may have to unlock your wallet:

```bash
promptsecret | dcrctl -u $RPC_USER -P $RPC_PASS $TESTNET --wallet walletpassphrase - 0
```
