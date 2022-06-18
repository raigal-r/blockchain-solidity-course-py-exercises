//SPDX-License_Identifier:MIT

pragma solidity ^0.6.0;

//Contract that deploys another contract
//You need both files in the same folder
import "./SimpleStorage.sol";

//Also, for inheritance, I can define the solidly inheritance
//And my contract will have all the functions and variables than in SimpleStorage

contract StorageFactory is SimpleStorage{

    //To keep track of the contracts created
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        //creates an objexts of type SimpleStorage 
        //name it simpleStorage
        //and that is going to be a new SimpleSTorage contract that takes no predetermine parameters

        SimpleStorage simpleStorage = new SimpleStorage();
        //Like that, when we deploy, it appearsthe function, but showns nothing
        //We cannot read the contracts that are being deployed
        //We need a block explorer, like etherscan, or:

        //To keep track of all the simpleStorage contracts we deploy
        //Put then in a list, or in a array
        simpleStorageArray.push(simpleStorage);
    } 

    //Interact between contracts. Create a function that is calling an specific function from another contract

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        //Any time you interact with the contract you need two things
        //1st. Address of the contract you are going to interact with
        /// with the simpleStorageArray.push
        //ABI, Application Binary Interface
        /// from the import

        // _simpleStorageIndez is the number from the contract list array we want to interact with
        // and after we also pass a _simpleStorageNumber to call on the store function. That needs a "favouritenumber" as an input. 
        
        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        // now we can call the contract we can call any of its functions
        simpleStorage.store(_simpleStorageNumber);
        //with simpleStorage.store we can introduce a favourite number attached to the contract
        //But, we cannot see the favouriteNumber
        //We didn't add a retrieve functionality, se we are going to do that now in the following function

    }

    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256){
        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        return simpleStorage.retrieve();
    //Also that functionality can be writed as following:
    //SimpleStorage(address(simpleStorageArray[_simpleStorageIndex])).retrieve();
    
    }

    


}
