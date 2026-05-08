# TodoList contract (Hardhat 3)

## Local deploy

Requires Node.js `>= 22.13.0`.

```sh
npm install
npm run build
npm run deploy:hardhat
```

To deploy to a running local node:

```sh
npm run node
# in another terminal
npm run deploy:localhost
```

## Sepolia deploy

Set `SEPOLIA_RPC_URL` and `PRIVATE_KEY` (see `.env.example`), then:

```sh
npm install
npm run build
npm run deploy:sepolia
```

Note: this repo loads `.env` automatically from `hardhat.config.ts`.
