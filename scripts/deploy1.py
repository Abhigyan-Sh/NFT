from brownie import creatingCollectible
from scripts.helpful_scripts import get_account, opensea

sample_token_uri = "https://ipfs.io/ipfs/Qmd9MCGtdVz2miNumBHDbvj8bigSgTwnr4SbyH6DNnpWdt?filename=0-PUG.json"

def deployer():
    erc721Contract= creatingCollectible.deploy({"from":get_account()})
    txn= erc721Contract.creating_collectible(sample_token_uri, {"from":get_account()})
    txn.wait(1)
    print(f"your nft has been created {opensea.format(erc721Contract.address, erc721Contract.tokenCounter() - 1)}")

def main():
    deployer()