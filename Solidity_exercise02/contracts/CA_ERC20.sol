// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

// 定义事件
contract CA_ERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // 使用 mapping 存储账户余额和授权信息
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;
    address private _owner;

    constructor(uint256 _initialSupply) {
        _owner = msg.sender;
        _balances[msg.sender] = _initialSupply;
        _totalSupply = _initialSupply;
        emit Transfer(address(0), msg.sender, _initialSupply);
    }

    // 修饰器，限制只有合约所有者可以调用
    modifier onlyOwner() {
        require(msg.sender == _owner, "Not owner");
        _;
    }

    // 查询账户余额
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    // 转账函数
    function transfer(address to, uint256 amount) public returns (bool) {
        address owner = msg.sender;
        _transfer(owner, to, amount);
        return true;
    }

    // 授权函数
    function approve(address spender, uint256 amount) public returns (bool) {
        address owner = msg.sender;
        _approve(owner, spender, amount);
        return true;
    }

    // 代扣转账函数
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public returns (bool) {
        address spender = msg.sender;
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    // 内部转账函数
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal {
        require(from != address(0), "Transfer from the zero address");
        require(to != address(0), "Transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "Transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
        }
        _balances[to] += amount;

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    // 内部授权函数
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal {
        require(owner != address(0), "Approve from the zero address");
        require(spender != address(0), "Approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    // 内部使用授权额度函数
    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "Insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

    // 查询授权额度
    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    // 增发代币函数
    function mint(address account, uint256 amount) public onlyOwner {
        require(account != address(0), "Mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    // 钩子函数，可用于扩展逻辑
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {} 

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {} 

    // 查询总供应量
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }
}