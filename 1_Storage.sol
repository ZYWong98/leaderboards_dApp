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

    struct Profile {
        uint40 id;
        string name;
        uint hostRep;
        uint participationRep;
    }
    mapping (address => uint40) public ownerToProfile;

    struct Event {
        uint id;
        string title;
        uint40 hostId;
    }

    Profile[] private Profiles;
    Event[] private activeEvents;

    function store(string memory name) private{
        uint40 id = uint40(Profiles.length+1);
        Profiles.push(Profile(id, name, 0, 0));
        ownerToProfile[msg.sender] = id;
        emit NewProfile(id, name);
    }

    function newEvent(string memory title) private{
        uint id = uint(activeEvents.length+1);
        activeEvents.push(Event(id, title, ownerToProfile[msg.sender]));
        emit NewEvent(id, title);
    }
}