// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
 

interface IERC20 {
    // 转账事件
    event Transfer(address indexed from, address indexed to, uint256 value);

    // 授权事件
    
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // 获取总供应量
    function totalSupply() external view returns (uint256);

    // 获取账户余额
    function balanceOf(address account) external view returns (uint256);

    // 转账
    function transfer(address to, uint256 amount) external returns (bool);

    // 获取授权金额
    function allowance(address owner, address spender) external view returns (uint256);

    // 授权
    function approve(address spender, uint256 amount) external returns (bool);

    // 转账
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}
 
contract CA_ERC20 is IERC20 {
    string public name;
    string public symbol;
    uint8 public decimals = 18;
    uint256 public totalSupply;

    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowances;

    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        owner = msg.sender;
    }

    function balanceOf(address account) external view override returns (uint256) {
        return balances[account];
    }

    function transfer(address recipient, uint256 amount) external override returns (bool) {
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(balances[msg.sender] >= amount, "ERC20: transfer amount exceeds balance");
        
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        
        emit Transfer(msg.sender, recipient, amount);
        
        return true;
    }

    function allowance(address _owner, address spender) external view override returns (uint256) {
        return allowances[_owner][spender];
    }

    function approve(address spender, uint256 amount) external override returns (bool) {
        require(spender != address(0), "ERC20: approve to the zero address");
        
        allowances[msg.sender][spender] = amount;
        
        emit Approval(msg.sender, spender, amount);
        
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        require(balances[sender] >= amount, "ERC20: transfer amount exceeds balance");
        require(allowances[sender][msg.sender] >= amount, "ERC20: transfer amount exceeds allowance");

        balances[sender] -= amount;
        balances[recipient] += amount;
        allowances[sender][msg.sender] -= amount;
        
        emit Transfer(sender, recipient, amount);
        
        return true;
    }

    function mint(address to, uint256 amount) external onlyOwner {
        require(to != address(0), "ERC20: mint to the zero address");
        
        totalSupply += amount;
        balances[to] += amount; 
        
        emit Transfer(address(0), to, amount);
    }
}
