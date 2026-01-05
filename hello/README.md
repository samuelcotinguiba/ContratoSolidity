# Contrato Hello World

Contrato simples para aprendizado e interação com MetaMask e Ganache via Web3.js

## 📋 Sobre o Contrato

O **HelloWorld** é um contrato básico que demonstra armazenamento e modificação de variáveis de estado na blockchain, ideal para iniciantes aprenderem os fundamentos de Solidity.

## 🛠️ Tecnologias Utilizadas

- **Solidity**: ^0.8.0
- **Web3.js**: ^4.x
- **Node.js**: Para execução dos scripts
- **Ganache**: Blockchain local para testes
- **MetaMask**: Carteira Ethereum
- **Remix IDE**: Compilação e deploy do contrato
- **Licença**: Fins Educacionais

## 📖 Código do Contrato

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HelloWorld {
    string public hello = "Hello World!";
    string public name = "";
    
    function setName(string memory _name) public {
        name = _name;
    }
    
    function setHello(string memory _hello) public {
        hello = _hello;
    }
}
```

## 🔌 Interação com Web3 via NPM

### Pré-requisitos
```bash
npm install web3
```

### Configuração e Conexão

1. **Inicializar Web3 com provedor local (Ganache)**
```javascript
const Web3 = require('web3');
const web3 = new Web3('http://localhost:7545'); // Porta padrão do Ganache
```

2. **Importar ABI do Contrato**

Após compilar o contrato no Remix IDE, copie o ABI gerado e salve em um arquivo `ABI.json`:

```javascript
const contractABI = require('./ABI.json');
```

3. **Criar Instância do Contrato**

```javascript
// Endereço do contrato após deploy
const contractAddress = '0x...'; // Copie do Remix ou Ganache

// Criar nova instância do contrato
let contract = new web3.eth.Contract(contractABI, contractAddress);
```

### Interagindo com o Contrato

**Leitura de Dados (métodos `view`):**
```javascript
// Ler valor de 'hello'
contract.methods.hello().call()
    .then(result => console.log('Hello:', result));

// Ler valor de 'name'
contract.methods.name().call()
    .then(result => console.log('Name:', result));
```

**Escrita de Dados (transações):**
```javascript
// Obter conta da MetaMask/Ganache
const account = '0x...'; // Seu endereço de carteira

// Modificar o valor de 'name'
contract.methods.setName('Samuel').send({ from: account })
    .then(receipt => console.log('Transação confirmada:', receipt));

// Modificar o valor de 'hello'
contract.methods.setHello('Olá Mundo!').send({ from: account })
    .then(receipt => console.log('Transação confirmada:', receipt));
```

### Exemplo Completo

```javascript
const Web3 = require('web3');
const contractABI = require('./ABI.json');

// Conectar ao Ganache
const web3 = new Web3('http://localhost:7545');

// Configuração do contrato
const contractAddress = '0xYourContractAddress';
let contract = new web3.eth.Contract(contractABI, contractAddress);

// Função async para interagir
async function interagir() {
    // Obter contas do Ganache
    const accounts = await web3.eth.getAccounts();
    const account = accounts[0];
    
    // Ler valores iniciais
    const helloInicial = await contract.methods.hello().call();
    const nameInicial = await contract.methods.name().call();
    console.log('Hello inicial:', helloInicial);
    console.log('Name inicial:', nameInicial);
    
    // Modificar valores
    await contract.methods.setName('Binance').send({ from: account });
    await contract.methods.setHello('Blockchain!').send({ from: account });
    
    // Ler valores atualizados
    const helloFinal = await contract.methods.hello().call();
    const nameFinal = await contract.methods.name().call();
    console.log('Hello final:', helloFinal);
    console.log('Name final:', nameFinal);
}

interagir();
```

## 📊 Operações Disponíveis no Contrato

| Método | Tipo | Descrição |
|--------|------|-----------|
| `hello()` | view | Retorna o valor da variável `hello` |
| `name()` | view | Retorna o valor da variável `name` |
| `setHello(string)` | transaction | Modifica o valor de `hello` |
| `setName(string)` | transaction | Modifica o valor de `name` |

**Observações:**
- Métodos `view` não gastam gas (leitura)
- Métodos de transação requerem gas e confirmação da carteira
- Todas as modificações são registradas na blockchain

---

**Desenvolvido como parte do Binance Bootcamp - DIO** 🚀
