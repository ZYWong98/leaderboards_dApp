const { ethers } = require("ethers");

async function connect(){
    if (typeof window.ethereum !== "undefined") {
       
       await ethereum.request({method:"eth_requestAccounts"});
       }
        else{ alert('Please download Metamask');}
      }

      async function execute(){
//address
//contract ABI
//function
//node connection (metamask)
const abi=fetch("./contractABI.json");
const contractAddress="0x0CDA7a73Ae4dDaD7E970D8FECe5A78294759a49d";
const provider =new ethers.providers.Web3Provider(window.ethereum);
const signer = provider.getSigner(); 
const contract =new ethers.Contract(contractAddress,abi,signer);   
 if(await contract.login()){
alert("logged in");
 }
 else{await contract.store();
alert("welcome new user");
}
}

      module.exports={
        connect,
        execute,
      };