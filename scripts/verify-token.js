const hre = require('hardhat');
require('dotenv').config();

const TOKEN_DEPLOYER_ADDRESS = process.env.TOKEN_DEPLOYER_ADDRESS;
const TOKEN_CONTRACT_ADDRESS = process.env.TOKEN_CONTRACT_ADDRESS;
const TOKEN_TOTAL_SUPPLY = process.env.TOKEN_TOTAL_SUPPLY;

async function main() {
    
    await hre.run('verify:verify', {
        address: TOKEN_CONTRACT_ADDRESS,
        contract: 'contracts/token/DorToken.sol:DorToken',
        constructorArguments:[
            TOKEN_DEPLOYER_ADDRESS,
            TOKEN_TOTAL_SUPPLY
        ]
    });
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
