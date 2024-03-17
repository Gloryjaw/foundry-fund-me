## What it is?

It is a smart contract in which users can fund native tokens to the owner of contract. It also keeps track of the funders and
how much they have donated. Owner can then withdraw the money whenever he/she want. This project is made with foundry, which
is the framework to create, test and deploy smart contract and it's blazingly fast!!

## Pre - requisite
- [Git](https://git-scm.com/)
- [Foundry](https://book.getfoundry.sh/)

## Quick Start

```shell
$ git clone https://github.com/Gloryjaw/foundry-fund-me.git
$ cd foundry-fund-me
$ make install
$ forge build

```

## Deploy contract

This is how you deploy the contract (assuming you have encrypted your key with cast)
 ```shell
forge script script/DeployFundMe.s.sol --rpc-url <endpoint url> --account <keyname> --sender <account address> --broadcast
```

## Interact with contract
### Funding
The following command will send 0.1 ether to the contract. ( You can change the amount from the script file, minimum 5 dollars are required).
Since this will use scripts, this will also deploy a contract of its own.

```shell
forge script script/Interactions.s.sol:FundFundMe --rpc-url <endpoint url> --account <keyname> --sender <account address> --broadcast
```

If you don't want to deploy it's own contract, you can use cast

```shell
cast send <contract address> "fund()" --value "0.01ether" --rpc-url <endpoint url> --account <keyname> --sender <account address>
```

### Withdraw
The following command will withdraw all the money from contract. (Only the address which has deployed the contract can withdraw i.e owner)
Since this will use scripts, this will also deploy a contract of its own.
```shell
forge script script/Interactions.s.sol:WithdrawFundMe --rpc-url <endpoint url> --account <keyname> --sender <account address> --broadcast
```

If you don't want to deploy it's own contract, you can use cast

```shell
cast send <contract address> "withdraw()" --rpc-url <endpoint url> --account <keyname> --sender <account address>
```

## Thank you
Thanks to [Cyfrin](updraft.cyfrin.io) and [Patrick Collins](https://github.com/PatrickAlphaC) for this amazing project. Love you guys!!!!!


