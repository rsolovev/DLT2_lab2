pragma solidity ^0.5.0;

contract ERC721{
    struct Token {
        string name;
        string image;
        bool exist;
    }
	mapping(address => Token) tokens;
	uint totalSupply = 1000;
	string names = "";
	string images = "";
	
	function createToken(address addr, string memory title, string memory image) public payable{
	    require (msg.value == 1000000000000000000);
	    Token memory temp_t = Token(title, image, true);
	    tokens[addr] = temp_t;
	    totalSupply -= 1;
	}
	
	function modifyToken(address addr, string memory title, string memory image) public {
	    require (tokens[addr].exist);
	    Token memory temp_t = Token(title, image, true);
	    tokens[addr] = temp_t;
	}
	
	function transferToken(address addr, address _to) public {
        require (tokens[addr].exist);
        Token memory temp_t = tokens[addr];
		tokens[_to] = temp_t;
		delete tokens[addr];
		tokens[addr].exist = false;
		
	}
	
	function buy(address addr, address payable _from) public payable{
        require (tokens[_from].exist);
        require (msg.value == 1000000000000000000);
        _from.transfer(msg.value);
        Token memory temp_t = tokens[_from];
		tokens[addr] = temp_t;
		delete tokens[_from];
		tokens[_from].exist = false;
	}
	
	function checkToken(address _owner) public view returns (string memory, string memory){
	    require (tokens[_owner].exist);
		return(tokens[_owner].name, tokens[_owner].image);
	}
}