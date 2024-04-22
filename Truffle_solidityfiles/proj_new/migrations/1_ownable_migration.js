const ownable = artifacts.require("./ownable.sol");

 module.exports = function(deployer) {
  deployer.deploy(ownable);
};