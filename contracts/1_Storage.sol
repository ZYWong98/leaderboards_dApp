// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;
import "./ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Storage is Ownable{
    
    /**
    Constructor to initialize contract, add 1 dummy profile & 1 dummy event
     */
    constructor()
        //ERC20("Reputation", "REP")
        {
        //_mint(address(this), 100000000000000);
        store('Profile not found','12345');
        newEvent('Not an event', 0);
        store('Dan','swordfish');
        
        //emit address(this));
        }
    
    /*
    id is self creating from how many people are in the app.
    its also only 40 because we have 8 billion people in world so it gets us everyone    
    */

    event NewProfile(uint40 id, string name);
    event NewEvent(uint id, string title);
    event PlayerJoined(uint40 playerId, uint eventId);
    //event ListEvent(uint id, string title, uint40 capacity);

    struct Profile {
        uint40 id;
        string name;
        //uint hostRep;
        uint256 participationRep;
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

    function store(string memory name, string memory password) public {
        uint40 id = uint40(Profiles.length+1);
        Profiles.push(Profile(id, name, 0, keccak256(abi.encodePacked(password))));
        ownerToProfile[msg.sender] = id;
        emit NewProfile(id, name);
    }

    /**
    Gets the user profile for the UI
     */
    function getProfile(uint eventRoomId) view public returns(Profile memory){
        for(uint i=0;i<activeEvents.length;i++){
                if(activeEvents[i].id==eventRoomId)
                {
                    for(uint j = 0; j< Profiles.length;j++){
                        if(activeEvents[i].hostId == Profiles[j].id){
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

    function login(uint40 id,string memory password) public returns (bool){
        for(uint i = 0;i<Profiles.length;i++){
        if(Profiles[i].id == id && Profiles[i].key == keccak256(abi.encodePacked(password))){
            ownerToProfile[msg.sender] = Profiles[i].id;
            return true;
        }
        }

        return false;
    }

    /**
    Distribute tokens to each participant
     */

     function distributeToken(uint40 userId) public {
        for(uint j=0;j<Profiles.length;j++){
                if(Profiles[j].id==userId)
                {
                    Profiles[j].participationRep++; 
                }
            }
        
    }

    /**
    Room Stuff. room is made, room is closed, list all open rooms.
     */

     function newEvent(string memory title, uint40 capacity) public {
        require(isOwner(), "Only owner can make new events");
        uint id = uint(activeEvents.length+1);
        uint40[] memory profileIds = new uint40[](0);
        activeEvents.push(Event(id, title, ownerToProfile[msg.sender], capacity, profileIds));
        emit NewEvent(id, title);
    }

    function joinEvent(uint index)  external{
        require(!isOwner(), "Owner is already a participant of event");
        if(activeEvents.length != 0){
            activeEvents[index].profilesIds.push(ownerToProfile[msg.sender]);
            emit PlayerJoined(ownerToProfile[msg.sender], activeEvents[index].id);
        }
    }

    function closeEvent(uint eventRoomId) external {
        require(isOwner(), "Only owner can close this event");
        Event storage currentEvent = activeEvents[0];
        for(uint k=0; k< activeEvents.length;k++){
            if(activeEvents[k].id == eventRoomId){
                currentEvent = activeEvents[k];
            }
        }
        for(uint j=0;j<Profiles.length;j++){
                if(Profiles[j].id==eventRoomId)
                {
                    distributeToken(Profiles[j].id);
                }
            }
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

    function currentEvents() view public returns (Event[] memory){
        return activeEvents;
    }

    /**
    List all profiles. Owner only
     */
    function currentProfiles() view public returns (Profile[] memory) {
        return Profiles;
    }

/**

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Pausable)
    {
        super._update(from, to, value);
    }
*/
}
