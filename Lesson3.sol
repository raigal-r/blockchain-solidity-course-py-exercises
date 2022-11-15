//SPDX-License_Identifier:MIT

pragma solidity >=0.6.6 <0.9.0;

//thats imports from the chainlink NPM Package
//Check the Interface: https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

//For the overflow
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";
// Also we can also copy the code at the top of the contract

/* Copied from the above link (is the same than the import!)
interface AggregatorV3Interface {

  function decimals()
    external
    view
    returns (
      uint8
    );

  function description()
    external
    view
    returns (
      string memory
    );

  function version()
    external
    view
    returns (
      uint256
    );

  // getRoundData and latestRoundData should both raise "No data present"
  // if they do not have data to report, instead of returning unset values
  // which could be misinterpreted as actual reported values.
  function getRoundData(
    uint80 _roundId
  )
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

}
*/

//We want this contract to accept some tipe of payment
contract FundMe{

    //So to acceot the payment we declare a function with the characteristic patable
    //when we define a function as payable means that function can be used to pay for things
    
    //For the mapping
    mapping(address => uint256) public addressToAmountFunded;

// Create an array to update tha balances at the withdrawal.
    addreses[] public funders;
//For the modifier
    address public owner;

    constructor() public{
      owner = msg.sender;
    } 
    function fund() public payable{

      //50$
      uint256 minimumUSD = 50 * 10 ** 18;
      require(getConversionRate(msg.value)>= minimumUSD, "You needto spend more ETH!");
        //The bottom will appear as fred, since it is a payable function
    
        //Keep track of who is sending us some money
        //Create a new mapping between addreses and value 
    addressToAmountFunded[msg.sender] += msg.value;
    //msg.sender keyword of address from the transaction call
    //msg.value keyword how much they sent

    //For the withdrawal
    funders.push(msg.sender);
    }

    //Create a minimum vale to fund our endeavours
    //Maybe set the amiunt in USD or other currency
    //How to do the conversion?
    // 1st - What the ETH -> USD conversion rate?
    // Oracle!Code predone for Kovan https://remix.ethereum.org/#url=https://docs.chain.link/samples/PriceFeeds/PriceConsumerV3.sol&optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.7+commit.e28d00a7.js
    // For the latest price of ETH
    // So we will have to import the ChainLink Code

    function getVersion() public view returns (uint256){
        //the address od the price feed is the one found in the documentation:
        //https://docs.chain.link/docs/ethereum-addresses/
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
        //Remember need to be deployed in the testnet because the address changes from the mainet
    }

    //Get price, min 23 video
    function getPrice() public view returns (uint256){
        //But if we check the function latestRoundData that us the
        //one we are going to call, returns 5 variables, so:
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        //Tuple, to don't put all the variables we don't need, we left the comas between the variable we are going to use
        (
        ,int256 answer,,, //That way the code also looks cleaner
        ) = priceFeed.latestRoundData(); 
        return uint256(answer * 10000000000); //Because answer is an int and not an uint
        //Result: 961,72867761, remember the result has 8 decimals
        // Also if you see the answer has only 8 decimals, but ETH has upt to 18 decimals, so you can multiply the answer to have all the decimals
        //That will increase the gas fee
      // Now in the fund function we will set the fund prince at 50$
    }

    //FAirst we do another function to set the fund price at 50$
    function getConversionRate(uint256 ethAmount) public view returns (uint256){
      uint256 ethPrice = getPrice(); //we call the getPrice() function and store the result in a variable
      uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
      return ethAmountInUsd;
      // The result has also 18 decimals
    
    }
    //But we are sending ETH to a contract that we cannot takje it back, 
    //to do it we need a withdrawal function

    //modifier, to change behavious of a function
    modifier onlyOwner {
      require(msg.sender == owner);
      _;
    }
    //and we at the modifier at the function declaration
    function withdraw() payable onlyOwner public {
      msg.sender.transfer(address(this).balance); // The address(this) refers to the current contract, like that we are transfering to the sender all our money! we need the requiere
      //now we have to update the balances

      for (uint256 funderIndex=0; funderIndex< funders.length; funderIndex++){
        address funder = funders[funderIndex];
        addressToAmountFunded[funder] = 0;
      }
      //reset funder array
      funders = new address[](0);
    }
}
