// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


contract Gemyto{
    string public _name;
    string public _symbol;
    uint8 public  _decimal;
    uint256 public  _totalSupply;

    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;

    event Transfer(address indexed _from, address indexed _to, uint256 _val);
    event Approval(address indexed _owner, address indexed _spender, uint256 _va);

    constructor(){
        _name = "Gemyto Token";
        _symbol = "Gemy";
        //change this part
        _decimal = 18;
        _totalSupply = 560000000 * (10 ** uint256(_decimal));

        uint256 initialSupply = 400000000 * (10 ** uint256(_decimal));//for crowdsale
        balances[msg.sender] = initialSupply;
        balances[0xB55AAecA85c42AAa7Ac7f8756bf759fAbB773f02] = (_totalSupply - initialSupply)/2;//for GemytoTeam
        balances[0x6Ca302EF773EFd509C4bFDc78E6b17BfE5d7A68e] = (_totalSupply - initialSupply)/2;//for advisors
    }

    function name() public  view returns (string memory){
        return _name;
    }

    function symbol() public  view returns (string memory){
        return _symbol;
    }

    function decimal() public  view returns (uint8){
        return _decimal;
    }

    function totalSupply() public view returns (uint256){
        return _totalSupply;
    }

    function balanceOf(address _walletAddress) public view returns (uint256){
        return balances[_walletAddress];
    }

    function allowance(address _owner, address _spender) public view returns (uint256){
        return allowed[_owner][_spender];
    }

    function approve(address _spender, uint256 _val) public returns (bool){
        allowed[msg.sender][_spender] = _val;
        emit Approval(msg.sender, _spender, _val);
        return true;
    }

    function transfer(address _to, uint256 _amount) public returns (bool){
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
        return true;
    }

    function transferfrom(address _from, address _to, uint256 _amount) public returns (bool){
        require(balances[_from] >= _amount);
        require(allowed[_from][msg.sender] >= _amount);
        balances[_from] -= _amount;
        allowed[_from][msg.sender] -= _amount;
        balances[_to] += _amount;
        emit Transfer(_from, _to, _amount);
        return true;
    }



}