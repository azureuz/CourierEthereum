pragma solidity >=0.4.22 <0.7.0;

contract Mail{
    
    //Return address for mail
    struct returnAddress {
        string returnName;
        string streetName;
        string cityName;
        string stateName;
        uint256 zipcode;
    }
    
    //Send address for mail
    struct sendAddress {
        string name;
        string streetName;
        string cityName;
        string stateName;
        uint256 zipcode;
    }
    
    //Mappings
    mapping(address=> returnAddress) public sender;
    
    //for receiver address map it with receivers public key..   
    mapping(address=> sendAddress) public receiver;
    
    function addSender(string memory _returnName, string memory _streetName, string memory _cityName, string memory _stateName, uint _zipcode) public{
        sender[msg.sender] = returnAddress(_returnName,_streetName,_cityName,_stateName,_zipcode);
        //exo skeleton "Alice","Sinhagad road","Pune","Maharashtra","411021"
    }
    
    function addReceiver(address _receiverAddress, string memory _name, string memory _streetName, string memory _cityName, string memory _stateName, uint _zipcode) public{
        sender[_receiverAddress] = returnAddress(_name,_streetName,_cityName,_stateName,_zipcode);
        //exo skeleton "PUBLIC ADDRESS","Alice","Sinhagad road","Pune","Maharashtra","411021"
    }    
    
    
}

contract DeliveryGuy{
    
    address payable contractDeployer;
    enum status {Delivered, Undelivered }
    status mailStatus;
    
    constructor() public{
        mailStatus = status.Undelivered;
    }
    
   modifier onlyWhenDelivered {
       require(mailStatus == status.Delivered, "Currently Undelivered");
       _;
   }
    
    struct deliveryGuy {
        address deliveryGuyAddress;
        string deliveryGuyName;
    }
    
    mapping(address=>deliveryGuy) public deliveryGuyInfo;
    //function to get delivery guy public key and name
    //function must be called by delivery guy himself to initiate
    function initDeliveryGuy(string memory _name) public{
        deliveryGuyInfo[msg.sender]= deliveryGuy(msg.sender, _name);
        //exo skeleton "name"
        contractDeployer = msg.sender;
    }
    
    function deliverySuccess() public {
        mailStatus= status.Delivered;
    }
    
    //function to pay delivery guy ethers
    function payDeliveryGuy(address payable _deliveryPublic) external payable onlyWhenDelivered {
        address payable deliveryPublicKey = _deliveryPublic;
        deliveryPublicKey.transfer(msg.value);
    }  
    
    
}

