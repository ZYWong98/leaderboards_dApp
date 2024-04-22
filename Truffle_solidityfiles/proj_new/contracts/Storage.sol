// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;
import "./ownable.sol";
import "../@openzeppelin/contracts/utils/math/SafeMath.sol";

//import "../@openzeppelin/contracts/token/ERC20/ERC20.sol";
//import "../@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
//import "../@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Storage is Ownable {
    /**
    Constructor to initialize contract, add 1 dummy profile & 1 dummy event
     */
    Profile[] private Profiles;
    Event[] private activeEvents;
    struct Profile {
        address id;
        string name;
        //uint hostRep;
        uint256 participationRep;
        //bytes32 key;
    }
    struct Event {
        uint256 id;
        string title;
        address hostId;
        uint40 capacity;
        address[] profilesIds;
    }

    constructor() //ERC20("Reputation", "REP")
    {
        //_mint(address(this), 100000000000000);
        //store('Profile not found','12345');
        newEvent("Not an event", 0);
        //store();
        //address myAddress=0x3530e7D1fEBE03333fc8C68Dd3EDF57e64a091F9;
        Profiles.push(Profile(msg.sender, "project", 0));

        //emit address(this);
    }

    /*
    id is self creating from how many people are in the app.
    its also only 40 because we have 8 billion people in world so it gets us everyone    
    */

    event NewProfile(address id, string name);
    event NewEvent(string title, uint40 capacity);
    event PlayerJoined(address playerId, uint256 eventId);
    //event ListEvent(uint id, string title, uint40 capacity);

    //struct Profile {
    //  uint40 id;
    //string name;
    //uint hostRep;
    // uint256 participationRep;
    //bytes32 key;
    //}
    mapping(address => address) public ownerToProfile;

    //struct Event {
    //  uint id;
    //string title;
    //uint40 hostId;
    //uint40 capacity;
    //uint40[] profilesIds;
    //}

    /**
    Stores the user profile onto the the profiles array and tells everyone about it
     */

    function store() public {
        address id = msg.sender;
        Profiles.push(Profile(id, " ", 0));
        ownerToProfile[msg.sender] = msg.sender;
        emit NewProfile(id, " ");
    }

    /**
    Gets the user profile for the UI
     */
    function getProfile(uint256 eventRoomId)
        public
        view
        returns (Profile memory)
    {
        for (uint256 i = 0; i < activeEvents.length; i++) {
            if (activeEvents[i].id == eventRoomId) {
                for (uint256 j = 0; j < Profiles.length; j++) {
                    if (activeEvents[i].hostId == Profiles[j].id) {
                        return Profiles[j];
                    }
                }
            }
        }
        return Profiles[0];
    }

    /**
    Login
     */

    function login() public returns (bool) {
        for (uint256 i = 0; i < Profiles.length; i++) {
            if (Profiles[i].id == msg.sender) {
                ownerToProfile[msg.sender] = Profiles[i].id;
                return true;
            }
        }

        return false;
    }

    /**
    Distribute tokens to each participant
     */

    function distributeToken(address userId) public {
        for (uint256 j = 0; j < Profiles.length; j++) {
            if (Profiles[j].id == userId) {
                Profiles[j].participationRep++;
            }
        }
    }

    /**
    Room Stuff. room is made, room is closed, list all open rooms.
     */

    function newEvent(string memory title, uint40 capacity) public {
        // require(isOwner(), "Only owner can make new events");
        uint256 id = uint256(activeEvents.length + 1);
        address[] memory profileIds = new address[](0);
        activeEvents.push(Event(id, title, msg.sender, capacity, profileIds));
        emit NewEvent(title, capacity);
    }

    function joinEvent(uint256 index) external {
        // bool eventExists = false;
        // for(uint i=0;i<activeEvents.length;i++){
        //     if(activeEvents[i].id==index){
        //         eventExists=true;
        //     }
        // }
        // require(eventExists==true, "Room not Found");
        if (activeEvents.length != 0) {
            activeEvents[index].profilesIds.push(msg.sender);
            emit PlayerJoined(msg.sender, activeEvents[index].id);
        }
    }

    function closeEvent(uint256 eventRoomId) external {
        Event storage currentEvent = activeEvents[0];
        for(uint k=0; k< activeEvents.length;k++){
            if(activeEvents[k].id == eventRoomId){
                currentEvent = activeEvents[k];
            }
        }
        // for(uint j=0;j<Profiles.length;j++){
        //         if(Profiles[j].id==eventRoomId)
        //         {
        //             distributeToken(Profiles[j].id);
        //         }
        //     }
        for(uint i=0; i<currentEvent.profilesIds.length;i++){
            for(uint j=0;j<Profiles.length;j++){
                if(Profiles[j].id==currentEvent.profilesIds[i])
                {
                    distributeToken(Profiles[j].id);
                }
            }
        }
        for(uint j=0;j<activeEvents.length;j++){
                if(activeEvents[j].id==currentEvent.id)
                {
                    delete activeEvents[j];
                    

                }
            }
        
    }

    /**
    List all profiles. Owner only
     */
    function currentProfiles() public view returns (Profile[] memory) {
        return Profiles;
    }

    function currentEvents() public view returns (Event[] memory) {
        return activeEvents;
    }

    // function returnMyEvents() public view returns (Event[] memory) {
    //     Event[] memory array1 = new Event[](activeEvents.length);
    //     uint count=0;
    //     for (uint256 i = 0; i < activeEvents.length; i++) {
    //         if (activeEvents[i].hostId == msg.sender) {
    //             array1[count] = activeEvents[i];
    //             count=count+1;
    //         }
    //     }
    //     return array1;
    // }
    /**

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Pausable)
    {
        super._update(from, to, value);
    }
*/
}
