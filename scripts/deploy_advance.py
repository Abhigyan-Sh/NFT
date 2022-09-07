from web3 import Web3
from brownie import advancedCollectible, Contract, LinkToken
from scripts.helpful_scripts import get_account, opensea

sample_token_uri = "https://ipfs.io/ipfs/Qmd9MCGtdVz2miNumBHDbvj8bigSgTwnr4SbyH6DNnpWdt?filename=0-PUG.json"

def fund_withLink(_to, amount):
    link_contract= Contract.from_abi(
        LinkToken._name, "0x01BE23585060835E02B77ef475b0Cc51aA1e0709", LinkToken.abi
    )
    txn= link_contract.transfer(_to, amount, {"from": get_account()})
    txn.wait(1)

def deployer():
    erc721Contract= advancedCollectible.deploy(
        "0x6168499c0cFfCaCD319c818142124B7A15E857ab",
        "0x01BE23585060835E02B77ef475b0Cc51aA1e0709",
        "0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc",
        100000000000000000,
        {"from":get_account()}
        )
    fund_withLink(erc721Contract.address, Web3.toWei(0.5, "ether"))
    txn= erc721Contract.createMyCollectible({"from":get_account()})
    txn.wait(1)
    print(f"your nft has been created {opensea.format(erc721Contract.address, erc721Contract.tokenCounter() - 1)}")

def main():
    deployer()