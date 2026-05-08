import { network } from "hardhat";

const { ethers } = await network.create();

const todoList = await ethers.deployContract("TodoList");
await todoList.waitForDeployment();

console.log("TodoList deployed to:", await todoList.getAddress());
