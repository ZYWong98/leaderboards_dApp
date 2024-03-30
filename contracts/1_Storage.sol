// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;
import "./ownable.sol";

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Storage is Ownable {
    /*
    id is self creating from how many people are in the app.
    its also only 40 because we have 8 billion people in world so it gets us everyone    
    */

    event NewProfile(uint40 id, string name);
    event NewEvent(uint id, string title);
    event PlayerJoined(uint40 playerId, uint eventId);

    struct Profile {
        uint40 id;
        string name;
        uint hostRep;
        uint participationRep;
        bytes32 key;
    }
    mapping (address => uint40) public ownerToProfile;

    struct Event {
        uint id;
        string title;
        uint40 hostId;
        uint40 capacity;
        uint40[] profilesIds;
    }

    Profile[] private Profiles;
    Event[] private activeEvents;

    /**
    Stores the user profile onto the the profiles array and tells everyone about it
     */

    function store(string memory name, string memory password) private{
        uint40 id = uint40(Profiles.length+1);
        Profiles.push(Profile(id, name, 0, 0, keccak256(abi.encodePacked(password))));
        ownerToProfile[msg.sender] = id;
        emit NewProfile(id, name);
    }

    /**
    Login
     */

    function login(string storage password) private view returns (bool){
        return Profiles[ownerToProfile[msg.sender]].key == keccak256(abi.encodePacked(password));
    }

    /**
    Room Stuff. room is made, room is closed.
     */

     function newEvent(string memory title, uint40 capacity) private{
        uint id = uint(activeEvents.length+1);
        uint40[] memory profileIds = new uint40[](capacity);
        activeEvents.push(Event(id, title, ownerToProfile[msg.sender], capacity, profileIds));
        emit NewEvent(id, title);
    }

    function joinEvent(uint index) private {
        if(activeEvents.length != 0){
            activeEvents[index].profilesIds.push(ownerToProfile[msg.sender]);
            emit PlayerJoined(ownerToProfile[msg.sender], activeEvents[index].id);
        }
    }

}