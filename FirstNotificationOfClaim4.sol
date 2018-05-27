pragma solidity ^0.4.0;
contract Claim {

    address public owner;
    uint public ownerReg = 1;
    struct Hospital {
        address hospitalAddress;
        string hospitalName;
    }
    uint public hospitalCount=0;
    Hospital[] public hospitalList;
    string public hospitalName;
    struct Claim {
        address hospitalAddress;
        string hospitalName;
        string patientName;
        string hospitalizationDate;
        string hospitalizationReason;
        string policyNumber;
        string insuranceCompany;
    }
    uint public claimCount=0;
    Claim[] public claimList;    
    string public claimHospital;
    string public patientName;
    string public hospitalizationDate;
    string public hospitalizationReason;
    string public policyNumber;
    string public insuranceCompany;

    event claimNotification(
       uint claimNo,
       string message
    );
    /// Comments
    function registerOwner() public returns(string) {
        if (ownerReg >1) return "Only one owner possible";
        ownerReg++;
        owner = msg.sender;
        hospitalList.length = 9999999999;
        claimList.length = 999999999999999;
        //console.log("Owner is " + owner);
        return "Owner added";
    }
    function registerHospital(address hospAddress, string hospName) public returns(string){
        if (msg.sender != owner) return "You cannot Register Hospital";
        hospitalList[hospitalCount].hospitalAddress = hospAddress;
        hospitalList[hospitalCount].hospitalName = hospName;
        hospitalCount++;
        //log2(bytes32(msg.sender), " added the hospital ",bytes32(hospAddress));
        return hospName;

    }
    function notifyClaim(uint hospitalNumber, string ptntName, string hospDate, string hospReason, string polNumber, string insCompany) public returns (uint,string){
        if (hospitalList[hospitalNumber].hospitalAddress != msg.sender) {
            claimNotification(0,"This account is not authorized for the Hospital Number given");
            return (0,"This account is not authorized for the Hospital Number given");
        }
        claimList[claimCount].hospitalAddress = hospitalList[hospitalNumber].hospitalAddress;
        claimList[claimCount].hospitalName = hospitalList[hospitalNumber].hospitalName;
        claimList[claimCount].patientName = ptntName;
        claimList[claimCount].hospitalizationDate = hospDate;
        claimList[claimCount].hospitalizationReason = hospReason;
        claimList[claimCount].policyNumber = polNumber;
        claimList[claimCount].insuranceCompany = insCompany;
        claimNotification(claimCount,"Claim added succesfully");
        claimCount++;
        return (claimCount-1,"Claim added succesfully");
    }
        function displayHospital(uint hospNum) public returns(string){
        if (msg.sender != owner) return "You cannot view Hospital details";
        if (hospNum+1>hospitalCount) return "Invalid Hospital Number";
        hospitalName = hospitalList[hospNum].hospitalName;
        return hospitalName;

    }
        function displayClaim (uint claimNum) public returns(string){
        if (msg.sender != owner) return "You cannot view Claim details";
        if (claimNum+1>claimCount) return "Invalid Claim Number";
        claimHospital = claimList[claimNum].hospitalName;
        patientName = claimList[claimNum].patientName;
        hospitalizationDate = claimList[claimNum].hospitalizationDate;
        hospitalizationReason = claimList[claimNum].hospitalizationReason;
        policyNumber = claimList[claimNum].policyNumber;
        insuranceCompany = claimList[claimNum].insuranceCompany;
        return patientName;

    }

}