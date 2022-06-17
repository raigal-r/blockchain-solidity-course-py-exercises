//At the top of the contract you want to add a SPDX License Identifier
//Every source ile should start with a comment indicating its license
//MIT most open license out there

//SPDX-LIcense-Identifier: MIT



pragma solidity ^0.6.0;

contract SimpleStorage {

    //uint256 favouriteNumber = 5;
    //bool facouriteBool = true;
    //string favouriteString = "String";
    //int256 favouriteInt = -5;
    //address favourtiteAddress = 0x8c71822277C9961e96B83954Ef7943208198DF53;
    //bytes32 favouriteBytes = "cat";

    uint256 public favoriteNumber; //This will get initialized to 0
    bool favouriteBool;



    struct People {
        uint256 favoriteNumber;
        string name;
    }
     //array, store a list
     //Dynamic array because it can change its size, to have a fixe size I put the number between []  
    People[] public people;

    //Mapping, looking for information, try to find soe information.
    //I know the name, but not its favouring number
    mapping(string => uint256) public nameToFavouriteNumber;

    People public person = People({favoriteNumber: 2, name: "Rachel"});

    //create a function
    function store(uint256 _favoriteNumber) public{
        favoriteNumber = _favoriteNumber;
    }
    //Ways to store information
    // memory:information stored only during the function execution, after execution variable deleted
    // storage: information will persists after the function execution, after execution variable stored
    //string is not a value type,it is an object, it is an array
   function addPerson(string memory _name, uint256 _favoriteNumber) public {
       people.push(People({favoriteNumber: _favoriteNumber, name: _name}));
        // Also: people.push(People({_favouriteNumber, _name}));
   
    //For the mapping
        nameToFavouriteNumber[_name] = _favoriteNumber;
   }


    // key words that makea function no transactional
    // view, pure
    //view is just reading from the blockchain, not making a state change, not necessary a transaction
    //pure,  functions that purely do some type of math
    //but, not saving the state anywhere
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }
    


}

// In Remix, to write the contract use the JavaScript VM
// To deploy it in the testnet (you will need testnet ETH) use the Injected Web3, enviorement. 
