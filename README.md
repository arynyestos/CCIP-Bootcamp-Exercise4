# CCIP Bootcamp Exercise 4: Sending USDC Cross-Chain

On this exercise, we deployed a contract on Avalanche Fuji that allowed us to transfer USDC to an EOA on Sepolia! You can find the official walkthrough using Remix IDE [here](https://cll-devrel.gitbook.io/ccip-bootcamp/day-3/exercise-4-sending-usdc-cross-chain). For a Foundry walkthrough, keep reading!

## Walkthrough

1. [Deploy](https://testnet.snowtrace.io/tx/0x5efacee2e2376d78edf5bbe673b018bc9a5f4805b5c1e1ecd00338a2854bab23?chainid=43113) the TransferUSDC.sol [contract](https://testnet.snowtrace.io/address/0x75fCB650669797B6273C84b4059946c4C7e94011/contract/43113/code) on Fuji. In this exercise we used a [Makefile](https://github.com/arynyestos/CCIP-Bootcamp-Exercise4/blob/main/Makefile):

  ```bash
    make deploy
  ```

  Verification on SnowTrace failed, so we had to use cast when making calls to the `TransferUSDC` contract.

2. [Call](https://testnet.snowtrace.io/tx/0xd4432ba89ea5a96744aea4f08170e0776a1876d4b9188e06c36c61fdd36f686c) `allowlistDestinationChain` to make Sepolia an allowlisted chain:

  ```bash
    cast send 0x75fCB650669797B6273C84b4059946c4C7e94011 "allowlistDestinationChain(uint64,bool)" 16015286601757825753 true --rpc-url $FUJI_RPC_URL --private-key $PRIVATE_KEY
  ```

3. [Fund](https://testnet.snowtrace.io/tx/0x1e7885f73e4f1bf3ce6340945b0e6e34adae1e1b4c508e0277ae7fdc54aae8bf) the `TransferUSDC` contract with 3 LINK to pay for CCIP fees.

4. Go to the USDC contract on [SnowTrace](https://testnet.snowtrace.io/address/0x5425890298aed601595a70AB815c96711a31Bc65/contract/43113/writeProxyContract?chainid=43113) to approve the `TransferUSDC` contract to transfer 1 USDC from our EOA (bear in mind that USDC is a 6 decimal ERC20).

   ![image](https://github.com/user-attachments/assets/a6695dcc-4242-4374-9dcb-d074c5d7c0a9)

5. [Call](https://testnet.snowtrace.io/tx/0x448b3562ce4f27fd48642e1544ea1a49d8a6ddbe5a98d147b5199fdc575996b9) `transferUsdc()`

  ```bash
    cast send 0x75fCB650669797B6273C84b4059946c4C7e94011 "transferUsdc(uint64,address,uint256,uint64)" 16015286601757825753 0x31e0FacEa072EE621f22971DF5bAE3a1317E41A4 1000000 0 --rpc-url $FUJI_RPC_URL --private-key $PRIVATE_KEY
  ```

  Note: gas limit was set to 0 because we're sending the token to an EOA, so no _ccipReceive function gets called.
