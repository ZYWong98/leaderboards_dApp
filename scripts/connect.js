// Import the Web3 library
const Web3 = require('web3');

// Connect to the blockchain network
const web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'));

// Get the contract ABI (Application Binary Interface)
const contractABI = [
  {
    constant: false,
    inputs: [
      {
        name: '_message',
        type: 'string',
      },
    ],
    name: 'setMessage',
    outputs: [],
    payable: false,
    stateMutability: 'nonpayable',
    type: 'function',
  },
  {
    constant: true,
    inputs: [],
    name: 'getMessage',
    outputs: [
      {
        name: '',
        type: 'string',
      },
    ],
    payable: false,
    stateMutability: 'view',
    type: 'function',
  },
];

// Get the contract address
const contractAddress = '0x9c740b64571fd42494F754718ce7dc50924928e9';

// Create an instance of the contract
const contract = new web3.eth.Contract(contractABI, contractAddress);

// Call the getMessage function
contract.methods.getMessage().call((error, result) => {
  console.log(result);
});

// Call the setMessage function
contract.methods.setMessage('Hello, world!').send({ from: '0x9c740b64571fd42494F754718ce7dc50924928e9' }, (error, transactionHash) => {
  console.log(transactionHash);
});