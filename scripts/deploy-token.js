// File: scripts/deploy.js

require('dotenv').config();

const TOKEN_DEPLOYER_ADDRESS = process.env.TOKEN_DEPLOYER_ADDRESS;
const TOKEN_TOTAL_SUPPLY = process.env.TOKEN_TOTAL_SUPPLY;

async function main() {
   // We get the contract to deploy
   const DorToken = await ethers.getContractFactory('DorToken');
   console.log(`[DOR] Deploying at wallet: ${TOKEN_DEPLOYER_ADDRESS}, totalSupply: ${TOKEN_TOTAL_SUPPLY}`);   

   // Instantiating a new DorToken smart contract
   const dorToken = await DorToken.deploy(TOKEN_DEPLOYER_ADDRESS, TOKEN_TOTAL_SUPPLY);

   // Waiting for the deployment to resolve
   await dorToken.deployed();
   console.log('[DOR] deployed to:', dorToken.address);
}

main()
   .then(() => process.exit(0))
   .catch((error) => {
      console.error(error);
      process.exit(1);
   });