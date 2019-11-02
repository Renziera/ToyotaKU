pragma solidity ^0.5.1;

contract ToyotaKUContract {
    mapping(string => Servis) servis;
    mapping(string => string) parts;
    
    address toyotaKU;
    
    modifier onlyToyotaKU(){
        require(msg.sender == toyotaKU);
        _;
    }
    
    struct Servis {
        string _data;
        uint256 _waktu;
    }
    
    constructor() public {
        toyotaKU = msg.sender;
    }
    
    function tambahServis(string memory _id, string memory _data, uint256 _waktu) public onlyToyotaKU {
        servis[_id] = Servis(_data, _waktu);
    }
    
    function tambahParts(string memory _id, string memory _data) public onlyToyotaKU {
        parts[_id] = _data;
    }
    
}
