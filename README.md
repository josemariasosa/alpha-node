# Managing Alpha Centauri ⭐️ Node

## NEARd

sudo journalctl -n 100 -f -u neard

sudo systemctl status neard

## Staking Pool

```sh
near call pool.f863973.m0 create_staking_pool '{"staking_pool_id": "alpha-centauri", "owner_id": "alpha-centauri.testnet", "stake_public_key": "ed25519:5JQJzUAPqehSkMjTp3p58cc4Dr4TgnPGqQ9poZ99rHUr", "reward_fee_fraction": {"numerator": 5, "denominator": 100}}' --accountId="alpha-centauri.testnet" --amount=30 --gas=300000000000000
```

To change the pool parameters, such as changing the amount of commission charged to 1% in the example below, use this command:

```sh
near call alpha-centauri.pool.f863973.m0 update_reward_fee_fraction '{"reward_fee_fraction": {"numerator": 1, "denominator": 100}}' --accountId alpha-centauri.testnet --gas=300000000000000
```

Commands:

```sh
near call alpha-centauri.pool.f863973.m0 new '{"owner_id": "alpha-centauri.testnet", "stake_public_key": "ed25519:5JQJzUAPqehSkMjTp3p58cc4Dr4TgnPGqQ9poZ99rHUr", "reward_fee_fraction": {"numerator": 5, "denominator": 100}}' --accountId alpha-centauri.testnet

near view alpha-centauri.pool.f863973.m0 get_owner_id '{}'

near view alpha-centauri.pool.f863973.m0 get_staking_key '{}'

near call alpha-centauri.pool.f863973.m1 update_staking_key '{"stake_public_key": "<public key>"}' --accountId <accountId>
```

More commands in the staking-pool contract

https://github.com/near/core-contracts/tree/master/staking-pool

curl -s -d '{"jsonrpc": "2.0", "method": "validators", "id": "dontcare", "params": [null]}' -H 'Content-Type: application/json' http://localhost:3030/ | jq

curl -s http://127.0.0.1:3030/status | jq

curl -s -d '{"jsonrpc": "2.0", "method": "validators", "id": "dontcare", "params": [null]}' -H 'Content-Type: application/json' http://localhost:3030/ | jq -c '.result.current_validators[] | select(.account_id | contains ("alpha-centauri.pool.f863973.m0"))'


curl -s -d '{"jsonrpc": "2.0", "method": "EXPERIMENTAL_protocol_config", "id": "dontcare", "params": {"finality": "final"}}' -H 'Content-Type: application/json' https://rpc.testnet.near.org | jq .result.epoch_length


CURRENT VALIDATOR:
curl -s -d '{"jsonrpc": "2.0", "method": "validators", "id": "dontcare", "params": [null]}' -H 'Content-Type: application/json' http://localhost:3030/ | jq -c '.result.current_validators[] | select(.account_id | contains ("alpha-centauri.factory.shardnet.near"))' | jq

NODE STATUS:

curl -s http://127.0.0.1:3030/status

## Common Commands:

```
sudo apt install curl jq
```

**Check your node version:**

Command:
```
curl -s http://127.0.0.1:3030/status | jq .version
```

**Check Delegators and Stake:**

Command:
```
near view alpha-centauri.factory.shardnet.near get_accounts '{"from_index": 0, "limit": 10}' --accountId alpha-centauri.shardnet.near
```

**Check Reason Validator Kicked:**

Command:
```
curl -s -d '{"jsonrpc": "2.0", "method": "validators", "id": "dontcare", "params": [null]}' -H 'Content-Type: application/json' 127.0.0.1:3030 | jq -c '.result.prev_epoch_kickout[] | select(.account_id | contains ("alpha-centauri.factory.shardnet.near"))' | jq .reason
```

**Check Blocks Produced / Expected:**

Command:
```
curl -s -d '{"jsonrpc": "2.0", "method": "validators", "id": "dontcare", "params": [null]}' -H 'Content-Type: application/json' 127.0.0.1:3030 | jq -c '.result.current_validators[] | select(.account_id | contains ("alpha-centauri.factory.shardnet.near"))'
```

## Ping Management

```sh
crontab -u alpha -l
crontab -u alpha -e

0 * * * * /home/alpha/alpha-node/ping-management/ping-script.sh
```