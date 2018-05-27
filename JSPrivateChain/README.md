Ethereum 2 Private Nodes set up Smart Contract Deployment and Dapp call

1. Install geth from https://geth.ethereum.org/downloads/ and ensure the PATH of the computer is updated to identify geth binary.
2. Create a new directory, say, 'Hospital1' which would be the data directory for running the Hospital Node
3. On command prompt, navigate to the Hospital1 directory
4. Run the command> geth account new --datadir <Directory Path>/Hospital1

You will get a message like below. Create a password and store it along with the Account address in a safe location:

Your new account is locked with a password. Please give a password. Do not forge
t this password.
Passphrase:
Repeat passphrase:
Address: {1cb580b82af4eb639dcc661abbbee1c34b9a94bf}

<pwd>

5. Repeat step 4 to create a few more accounts (you can initiate a lot of ethereum on these accounts in the genesis block)

6. Repeat step 3,4,5 to create a data directory, say, Insurance1 and create accounts under the same.

7. edit CustomGenesis2.json to add high balance for all the accounts created above.

8. Run the below commands to delete any existing data (if you had already run some nodes and ran into issues:

geth removedb --datadir <Directory Path>/Hospital1

geth removedb --datadir <Directory Path>/Insurance1

9. Navigate to the Hospital1, Insurance1 folders on Windows Explorer and delete all folders / files other than the folder 'keystore' and its contents. 'keystore' folder would have the private keys of the accounts created.

10. Run the below command (by providing the appropriate Directory Paths at both the places in the command)
geth --identity "Hosp1Node" --datadir <Directory Path>/Hospital1 --nodiscover --networkid 16 --maxpeers 5 --ipcdisable --rpc --rpcport 8545 --rpccorsdomain "*" --rpcapi "db,eth,net,web3" init <Directory Path>/CustomGenesis2.json

Custom genesis Block would have been initialized.

11. Run the below command to run Hospital Node (provide the appropriate Directory Path):
geth --identity "Hosp1Node" --datadir <Directory Path>/Hospital1 --nodiscover --networkid 15 --maxpeers 5 --ipcdisable --rpc --rpcport 8545 --rpccorsdomain "*" --rpcapi "db,eth,net,web3" console

12. Run the command admin.nodeInfo.enode

13. Copy paste the complete enode that is displayed from the above command and replace the enode value in the 'static-nodes.json' file and place this file in the Insurance1 directory. This will make sure that when the Insurance node is run, it automatically adds Hospital node as a peer.

14. In a new cmd window, run the below command (by providing the appropriate Directory Paths at both the places in the command)
geth --identity "Ins1Node" --datadir <Directory Path>/Insurance1 --port 51869 --networkid 15 --nodiscover --ipcdisable --maxpeers 5 --rpc --rpcport 8546 --rpccorsdomain "*" --rpcapi "db,eth,net,web3" init <Directory Path>/CustomGenesis2.json

15. Run the below command to run Insurance Node (provide the appropriate Directory Path):
geth --identity "Ins1Node" --datadir C://Users/kavya/AppData/Roaming/Ethereum/Insurance1 --port 51869 --networkid 15 --nodiscover --ipcdisable --maxpeers 5 --rpc --rpcport 8546 --rpccorsdomain "*" --rpcapi "db,eth,net,web3" console 2

16. Run the below commands in either of the nodes to check the balance in the respective accounts. The address under quotes has to be changed as per your addresses:

web3.fromWei(eth.getBalance("1cb580b82af4eb639dcc661abbbee1c34b9a94bf"), "ether")
web3.fromWei(eth.getBalance("7cada28bde3f652f2c6a9528747115b88dcfc0c4"), "ether")
web3.fromWei(eth.getBalance("f4f099ad19756cac7e365c9276fc6ea33d2e3c44"), "ether")
web3.fromWei(eth.getBalance("9353dc76f2a374573964d2d09ae6c53e10c51c78"), "ether")
web3.fromWei(eth.getBalance("a3295bc314d99605df7d394044d9e559ff59de47"), "ether")
web3.fromWei(eth.getBalance(eth.accounts[0]), "ether") - For the balance of the coinbase / default account.

17. If you want to change the default address of the miner of a particular node, run the below command with the address you wish to change it to:
miner.setEtherbase("7cada28bde3f652f2c6a9528747115b88dcfc0c4")

18. run the command admin.peers on both the nodes to check they return non-empty set. If you wish to add temporarily a non-static node, you can run the below command:

admin.addPeer("enode://7083e3794f7895c59790775a390be3689b810b05f2b2d1f3c3fc63461ed429b09c3fc22d37a410095e8e83cbb2ec1eb9ad8113affe2949f7fc760ec2b0f0d675@[::]:30303?discport=0")

19. Deploy Smart contract on node 1

---First Notification of Claim 4

var NotifyClaim = eth.contract([{"constant":true,"inputs":[],"name":"hospitalizationDate","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"hospitalName","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"hospitalCount","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"claimList","outputs":[{"name":"hospitalAddress","type":"address"},{"name":"hospitalName","type":"string"},{"name":"patientName","type":"string"},{"name":"hospitalizationDate","type":"string"},{"name":"hospitalizationReason","type":"string"},{"name":"policyNumber","type":"string"},{"name":"insuranceCompany","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"hospitalNumber","type":"uint256"},{"name":"ptntName","type":"string"},{"name":"hospDate","type":"string"},{"name":"hospReason","type":"string"},{"name":"polNumber","type":"string"},{"name":"insCompany","type":"string"}],"name":"notifyClaim","outputs":[{"name":"","type":"uint256"},{"name":"","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"ownerReg","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"hospAddress","type":"address"},{"name":"hospName","type":"string"}],"name":"registerHospital","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"hospitalizationReason","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"registerOwner","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"claimCount","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"patientName","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"policyNumber","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"hospitalList","outputs":[{"name":"hospitalAddress","type":"address"},{"name":"hospitalName","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"insuranceCompany","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"claimNum","type":"uint256"}],"name":"displayClaim","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"hospNum","type":"uint256"}],"name":"displayHospital","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"claimHospital","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"anonymous":false,"inputs":[{"indexed":false,"name":"claimNo","type":"uint256"},{"indexed":false,"name":"message","type":"string"}],"name":"claimNotification","type":"event"}])

var bytecode = '0x608060405234801561001057600080fd5b506102d7806100206000396000f30060806040526004361061004c576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff168063d13319c414610051578063dfb29935146100e1575b600080fd5b34801561005d57600080fd5b5061006661014a565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100a657808201518184015260208101905061008b565b50505050905090810190601f1680156100d35780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156100ed57600080fd5b50610148600480360381019080803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091929192905050506101ec565b005b606060008054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101e25780601f106101b7576101008083540402835291602001916101e2565b820191906000526020600020905b8154815290600101906020018083116101c557829003601f168201915b5050505050905090565b8060009080519060200190610202929190610206565b5050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061024757805160ff1916838001178555610275565b82800160010185558215610275579182015b82811115610274578251825591602001919060010190610259565b5b5090506102829190610286565b5090565b6102a891905b808211156102a457600081600090555060010161028c565b5090565b905600a165627a7a723058203a68342fa2d9e6311d36893563d07c315a0a14a4f1b7ad363a0f251f9e9e79920029'

var deploy = {from:eth.coinbase, data:bytecode, gas: 20000000}

personal.unlockAccount(eth.coinbase)

Provide password of the account.

var NotifyClaimPartialInstance = NotifyClaim.new("DISQUALIFIED!", deploy)

20. After the above commands, the Smart Contract should appear among pending transactions on both the nodes.
Run eth.pendingTransactions to check the same.

21. Run miner.start() on one or both the nodes to ensure the transaction goes in ablack and gets mined:

Once mined, you will see something like the below:

> INFO [05-18|23:47:59] Successfully sealed new block            number=1 hash=8
a66ef.9ad9b4
INFO [05-18|23:48:08] ?? mined potential block                  number=1 hash=8a
66ef.9ad9b4
INFO [05-18|23:48:11] Commit new mining work                   number=2 txs=1 un
cles=0 elapsed=3.935s

22. At any state, you can check the Txn status by running the below (Txn hashcode taken from eth.pendingTransactions)

web3.eth.getTransaction("0x2a6175078f512110daf7b5f9140ab94a4112addb1c38f89673dae9780848b18c")

23. To check the details of pending block
eth.getBlock('pending',true)
To check the details of Block 2:
eth.getBlock(2) OR eth.getBlock(2, true)

24. To check the contract address, run the below command:

web3.eth.getTransactionReceipt("0x2a6175078f512110daf7b5f9140ab94a4112addb1c38f89673dae9780848b18c").contractAddress

Save the Contract address: "0xba91ebbfbac5344f7ff33c1f1ed6e93e6ba0f86c"


