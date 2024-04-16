    (async () => {
        try {
            const abi = [
	{
		"inputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "id",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "title",
						"type": "string"
					},
					{
						"internalType": "uint40",
						"name": "hostId",
						"type": "uint40"
					},
					{
						"internalType": "uint40",
						"name": "capacity",
						"type": "uint40"
					},
					{
						"internalType": "uint40[]",
						"name": "profilesIds",
						"type": "uint40[]"
					}
				],
				"internalType": "struct Storage.Event",
				"name": "eventRoom",
				"type": "tuple"
			}
		],
		"name": "closeEvent",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"components": [
					{
						"internalType": "uint40",
						"name": "id",
						"type": "uint40"
					},
					{
						"internalType": "string",
						"name": "name",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "participationRep",
						"type": "uint256"
					},
					{
						"internalType": "bytes32",
						"name": "key",
						"type": "bytes32"
					}
				],
				"internalType": "struct Storage.Profile",
				"name": "user",
				"type": "tuple"
			}
		],
		"name": "distributeToken",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "index",
				"type": "uint256"
			}
		],
		"name": "joinEvent",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "title",
				"type": "string"
			},
			{
				"internalType": "uint40",
				"name": "capacity",
				"type": "uint40"
			}
		],
		"name": "newEvent",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "id",
				"type": "uint256"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "title",
				"type": "string"
			}
		],
		"name": "NewEvent",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint40",
				"name": "id",
				"type": "uint40"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "name",
				"type": "string"
			}
		],
		"name": "NewProfile",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "previousOwner",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "OwnershipTransferred",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "uint40",
				"name": "playerId",
				"type": "uint40"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "eventId",
				"type": "uint256"
			}
		],
		"name": "PlayerJoined",
		"type": "event"
	},
	{
		"inputs": [],
		"name": "renounceOwnership",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "newOwner",
				"type": "address"
			}
		],
		"name": "transferOwnership",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "currentEvents",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "id",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "title",
						"type": "string"
					},
					{
						"internalType": "uint40",
						"name": "hostId",
						"type": "uint40"
					},
					{
						"internalType": "uint40",
						"name": "capacity",
						"type": "uint40"
					},
					{
						"internalType": "uint40[]",
						"name": "profilesIds",
						"type": "uint40[]"
					}
				],
				"internalType": "struct Storage.Event[]",
				"name": "",
				"type": "tuple[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "currentProfiles",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint40",
						"name": "id",
						"type": "uint40"
					},
					{
						"internalType": "string",
						"name": "name",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "participationRep",
						"type": "uint256"
					},
					{
						"internalType": "bytes32",
						"name": "key",
						"type": "bytes32"
					}
				],
				"internalType": "struct Storage.Profile[]",
				"name": "",
				"type": "tuple[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "id",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "title",
						"type": "string"
					},
					{
						"internalType": "uint40",
						"name": "hostId",
						"type": "uint40"
					},
					{
						"internalType": "uint40",
						"name": "capacity",
						"type": "uint40"
					},
					{
						"internalType": "uint40[]",
						"name": "profilesIds",
						"type": "uint40[]"
					}
				],
				"internalType": "struct Storage.Event",
				"name": "eventRoom",
				"type": "tuple"
			}
		],
		"name": "getProfile",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint40",
						"name": "id",
						"type": "uint40"
					},
					{
						"internalType": "string",
						"name": "name",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "participationRep",
						"type": "uint256"
					},
					{
						"internalType": "bytes32",
						"name": "key",
						"type": "bytes32"
					}
				],
				"internalType": "struct Storage.Profile",
				"name": "",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "isOwner",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "owner",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"name": "ownerToProfile",
		"outputs": [
			{
				"internalType": "uint40",
				"name": "",
				"type": "uint40"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]
            const contractAddress = '0x4421c47026D8A6eA6048C5388b0BE1447131Eae8'

            // instantiate a new web3 Contract object
            let contract = new web3.eth.Contract(abi, contractAddress)

            // call the autogenerated function to return the value of a public state variable
            let name = await contract.methods.name().call()
        
            // log it to the remix console
            console.log(name)
        
        } catch (e) {
            console.log(e.message)
        }  

    })()