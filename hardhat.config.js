require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.18",
  networks: {
    sepolia: {
      url: process.env.INFURA_RINKEBY_ENDPOINT,
      accounts: [process.env.PRIVATE_KEY],
    }
  }
};
