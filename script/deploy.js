const { ethers } = require("hardhat");

async function main() {
  const Todo = await ethers.getContractFactory("Todo");
  const todo = await Todo.deploy();

  await todo.waitForDeployment();

  console.log("Deployed to:", await todo.getAddress());
}

main();