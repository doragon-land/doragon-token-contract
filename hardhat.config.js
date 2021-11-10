// ethers plugin required to interact with the contract
require('@nomiclabs/hardhat-ethers');
require("@nomiclabs/hardhat-etherscan");
require('dotenv').config();

const PRIVATE_KEY = process.env.PRIVATE_KEY;
const BSC_SCAN_KEY = process.env.BSC_SCAN_KEY;
const GETBLOCK_API_KEY = process.env.GETBLOCK_API_KEY;

module.exports = {
  solidity: "0.8.2",
  networks: {
    testnet: {
      url: `https://bsc.getblock.io/testnet/?api_key=${GETBLOCK_API_KEY}`,
      chainId: 97,
      gasPrice: 20000000000,
      accounts: [PRIVATE_KEY]
    },
    mainnet: {
      url: `https://bsc.getblock.io/mainnet/?api_key=${GETBLOCK_API_KEY}`,
      chainId: 56,
      gasPrice: 20000000000,
      accounts: [PRIVATE_KEY]
    },
  },
  etherscan: {
    apiKey: BSC_SCAN_KEY,
  },
};
