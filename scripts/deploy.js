const hre = require("hardhat");

async function main(){
  const Gemyto = await hre.ethers.getContractFactory("Gemyto");

  const gemyto = await Gemyto.deploy();
  await gemyto.waitForDeployment();

  const address = await gemyto.getAddress();
  console.log(`Contract Address: ${address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
})