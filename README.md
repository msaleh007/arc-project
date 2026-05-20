# Arc Testnet — Hardhat Setup

## ⚡ Quick Start

### Step 1 — Install dependencies
```bash
npm install
```

### Step 2 — Create .env file
Create a `.env` file in root folder:
```
PRIVATE_KEY=your_wallet_private_key_here
```
⚠️ Never share your private key!

### Step 3 — Get testnet USDC
- Go to Arc Faucet: https://faucet.arc.io
- Enter your wallet address
- Get free testnet USDC (used as gas)

### Step 4 — Compile contract
```bash
npm run compile
```

### Step 5 — Deploy to Arc Testnet
```bash
npm run deploy
| USDCPayment | `0xDf9A7077B53c9EA524F02Ce0fE48e3c9065B075f` | [View](https://testnet.arcscan.app/address/0xDf9A7077B53c9EA524F02Ce0fE48e3c9065B075f) |
```

## 🌐 Network Details
- **Chain ID:** 5042002
- **Gas Token:** USDC
- **Block Explorer:** https://explorer.testnet.arc.io
- **Faucet:** https://faucet.arc.io

## 📁 Project Structure
```
arc-hardhat/
├── contracts/
│   └── ArcTestContract.sol   ← Your smart contract
├── scripts/
│   └── deploy.js             ← Deploy script
├── hardhat.config.js         ← Network config
├── package.json
└── README.md
```

## 💡 Tips for Points/Airdrop
1. Deploy contract ✅
2. Interact with contract daily
3. Register multiple wallets
4. Keep on-chain activity consistent## Deployed Contracts on Arc Testnet

| Contract | Address |
|----------|---------|
| ArcTestContract | 0x80FA38299826D22Bc7e907E31281A0D74691F9Bc |
| ArcToken (ERC20) | 0xF4Da24868597E921464C97ADAf0674B492cED8a5 |

## Network Details
- Chain ID: 5042002
- RPC: https://rpc.testnet.arc.network
- Explorer: https://testnet.arcscan.app


