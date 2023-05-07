#!/bin/sh

CHANNEL_NAME="default"
PROJPATH=$(pwd)
CLIPATH=$PROJPATH/cli/peers
# set FABRIC_CFG_PATH to configtx.yaml directory that contains the profiles
export FABRIC_CFG_PATH=$PROJPATH
echo
echo "##########################################################"
echo "#########  Generating Orderer Genesis block ##############"
echo "PROJPATH   $PROJPATH"
echo "FABRIC_CFG_PATH   $FABRIC_CFG_PATH"
echo "#################################################################"
echo "Generating orderer genesis block"
configtxgen -profile FourOrgsGenesis -outputBlock $CLIPATH/genesis.block -channelID $CHANNEL_NAME

echo
echo "#################################################################"
echo "### Generating channel configuration transaction 'channel.tx' ###"
echo "#################################################################"
configtxgen -profile FourOrgsChannel -outputCreateChannelTx $CLIPATH/channel.tx -channelID $CHANNEL_NAME
echo "Created file cli/peers/channel.tx"
cp $CLIPATH/channel.tx $PROJPATH/web
echo
echo "#################################################################"
echo "####### Generating anchor peer update for InsuranceOrg ##########"
echo "#################################################################"
configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate $CLIPATH/InsuranceOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg InsuranceOrgMSP

echo
echo "#################################################################"
echo "#######    Generating anchor peer update for ShopOrg   ##########"
echo "#################################################################"
configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate $CLIPATH/ShopOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg ShopOrgMSP

echo
echo "##################################################################"
echo "####### Generating anchor peer update for RepairShopOrg ##########"
echo "##################################################################"
configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate $CLIPATH/RepairShopOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg RepairShopOrgMSP

echo
echo "##################################################################"
echo "#######   Generating anchor peer update for PoliceOrg   ##########"
echo "##################################################################"
configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate $CLIPATH/PoliceOrgMSPAnchors.tx -channelID $CHANNEL_NAME -asOrg PoliceOrgMSP


echo
echo "#################################################################"
echo "### ######################################################### ###"
echo "#################################################################"
