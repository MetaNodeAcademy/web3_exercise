
module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  await deploy('CA_ERC20', {
    from: deployer,
    args: ['MyToken', 'MTK'], // Constructor arguments for CA_ERC20
    log: true,
  });
};

module.exports.tags = ['CA_ERC20'];
