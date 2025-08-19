module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  await deploy("CA_Nft", {
    from: deployer,
    args: [], // CA_Nft构造函数不需要参数
    log: true,
  });
};

module.exports.tags = ["CA_Nft"];
