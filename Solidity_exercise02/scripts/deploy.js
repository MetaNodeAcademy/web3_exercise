// 更完善的部署脚本：
// 功能：
// 1. 解析初始发行量（支持环境变量 INIT_SUPPLY 或命令行第一个非 -- 参数，默认 1_000_000）
// 2. 部署 CA_ERC20 合约
// 3. 输出部署者、合约地址、初始总量、gas 消耗等信息
// 4. （可选）若存在 ETHERSCAN_API_KEY 且非本地网络，则自动尝试合约验证（可通过设置 SKIP_VERIFY=1 跳过）
// 使用示例：
//   INIT_SUPPLY=500000 npx hardhat run scripts/deploy.js --network localhost
//   npx hardhat run scripts/deploy.js --network hardhat 2500000
//   (上面第二个示例中 2500000 为初始发行量)

const hre = require("hardhat");
require("dotenv").config({ path: ".env" });

const INFURA_API_KEY = process.env.INFURA_API_KEY;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

async function main() {
  // 解析初始供应量
  const userArgs = process.argv.slice(2).filter((a) => !a.startsWith("--"));
  const initSupplyStr = process.env.INIT_SUPPLY || userArgs[0] || "1000000"; // 默认 1000000
  if (!/^\d+$/.test(initSupplyStr)) {
    throw new Error(`INIT_SUPPLY 需为非负整数，收到: ${initSupplyStr}`);
  }
  const initialSupply = BigInt(initSupplyStr);
  if (initialSupply === 0n) {
    throw new Error("初始发行量必须 > 0");
  }

  console.log("================ 部署开始 ================");
  console.log(`网络: ${hre.network.name}`);

  const [deployer] = await hre.ethers.getSigners();
  console.log(`部署账户: ${deployer.address}`);
  const balance = await hre.ethers.provider.getBalance(deployer.address);
  console.log(`账户 ETH 余额: ${hre.ethers.formatEther(balance)} ETH`);

  // 获取工厂并部署
  const Factory = await hre.ethers.getContractFactory("CA_ERC20");
  console.log("部署参数 => 初始发行量:", initialSupply.toString());
  const contract = await Factory.deploy(initialSupply);

  console.log("交易发送中 (hash):", contract.deploymentTransaction().hash);
  const receipt = await contract.deploymentTransaction().wait();
  await contract.waitForDeployment();
  const addr = await contract.getAddress();
  console.log("合约地址:", addr);
  console.log("部署区块:", receipt.blockNumber);
  console.log("部署 gasUsed:", receipt.gasUsed.toString());
  if (receipt.gasPrice) {
    console.log(
      "部署费用(近似 ETH):",
      hre.ethers.formatEther(receipt.gasUsed * receipt.gasPrice)
    );
  } else if (receipt.gasUsed && receipt.effectiveGasPrice) {
    console.log(
      "部署费用(近似 ETH):",
      hre.ethers.formatEther(receipt.gasUsed * receipt.effectiveGasPrice)
    );
  }

  const totalSupply = await contract.totalSupply();
  console.log("合约总供应量:", totalSupply.toString());
  const deployerBal = await contract.balanceOf(deployer.address);
  console.log("部署者初始代币余额:", deployerBal.toString());

  // 可选验证（跳过本地 / 内置 hardhat 网络）
  if (
    !process.env.SKIP_VERIFY &&
    process.env.ETHERSCAN_API_KEY &&
    !["hardhat", "localhost"].includes(hre.network.name)
  ) {
    console.log("尝试验证合约...");
    try {
      await hre.run("verify:verify", {
        address: addr,
        constructorArguments: [initialSupply.toString()],
      });
      console.log("验证成功");
    } catch (e) {
      console.warn("验证失败:", e.message || e);
    }
  } else {
    console.log(
      "跳过验证 (无 ETHERSCAN_API_KEY 或本地网络或已设置 SKIP_VERIFY)。"
    );
  }

  console.log("================ 部署完成 ================");
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error("部署失败:", err);
    process.exit(1);
  });
