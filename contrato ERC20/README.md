# Contrato ERC20 - DIO Token

Token ERC20 personalizado criado para aprendizado de padrões de tokens na blockchain Ethereum.

## 📋 Sobre o Contrato

O **DIOtoken** é um token ERC20 completo que implementa todas as funções padrão da interface IERC20:

- **Nome**: DIO token
- **Símbolo**: DIO
- **Decimais**: 18
- **Supply Inicial**: 10 ETH (10 tokens com 18 casas decimais)

## 🚀 Como Foi Utilizado

Este contrato foi desenvolvido e testado usando:

1. **Remix IDE** - IDE online para desenvolvimento Solidity
2. **MetaMask** - Carteira conectada para assinatura de transações
3. **Rede de Teste** - Deploy em testnet/local para testes seguros

### Passo a Passo de Uso

#### 1. Deploy no Remix IDE
```
1. Abrir Remix IDE (https://remix.ethereum.org)
2. Criar arquivo contrato.sol e colar o código
3. Compilar o contrato (Solidity >= 0.8.0)
4. Conectar MetaMask à rede desejada
5. Fazer deploy através do Remix com MetaMask conectada
```

#### 2. Interação com o Contrato

Após o deploy, você pode:

**Consultar Informações (view):**
- `totalSupply()` - Ver supply total de tokens
- `balanceOf(address)` - Ver saldo de uma conta
- `allowance(owner, spender)` - Ver permissão de gasto

**Realizar Transações:**
- `transfer(receiver, amount)` - Transferir tokens
- `approve(spender, amount)` - Aprovar terceiro para gastar
- `transferFrom(owner, buyer, amount)` - Transferir em nome de outro

#### 3. Exemplo de Transação com MetaMask

```solidity
// Transferir 1 DIO token para outro endereço
transfer("0x123...", 1000000000000000000) // 1 token = 1e18

// Aprovar 5 tokens para um contrato usar
approve("0xContrato...", 5000000000000000000) // 5 tokens
```

## ⚡ Funcionalidades do ERC20

### Transfer
Permite transferir tokens diretamente do seu saldo para outro endereço.

### Approve & TransferFrom
Sistema de permissões que permite que contratos ou outros usuários gastem tokens em seu nome (usado em DeFi).

### Events
- `Transfer` - Emitido quando tokens são transferidos
- `Approval` - Emitido quando uma permissão é concedida

## 🔧 Tecnologias

- **Solidity**: >=0.8.0 <0.9.0
- **Padrão**: ERC20
- **Remix IDE**: Compilação e deploy
- **MetaMask**: Gerenciamento de carteira e assinatura de transações
- **Licença**: GPL-3.0

## ⚠️ Observações

- Este é um contrato educacional e NÃO foi auditado
- O supply inicial é mintado para o endereço que faz o deploy
- Não possui funções de mint/burn adicionais
- Não implementa pausável ou outras features avançadas

## 📚 Padrão ERC20

O ERC20 é o padrão mais popular para tokens fungíveis no Ethereum. Garante compatibilidade com:
- Exchanges descentralizadas (DEXs)
- Wallets (MetaMask, Trust Wallet, etc)
- Protocolos DeFi
- Exploradores de blockchain (Etherscan)

---

**Desenvolvido como parte do Binance Bootcamp - DIO** 🚀
