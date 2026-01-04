# Smart Contracts em Solidity

Repositório contendo contratos inteligentes desenvolvidos em Solidity com exemplos de interação via Web3.js

---

## 📚 Índice

1. [O que é Solidity?](#o-que-é-solidity)
2. [O que é Web3?](#o-que-é-web3)
3. [Conceitos de Solidity](#-conceitos-de-solidity)
4. [Contrato de Votação](#contrato-de-votação)
5. [Contrato Hello World](#contrato-hello-world)

---

## O que é Solidity?

Solidity é uma linguagem de programação orientada a objetos, de alto nível, projetada especificamente para desenvolver **smart contracts** (contratos inteligentes) que rodam na **Ethereum Virtual Machine (EVM)**. 

### Características principais:

- **Linguagem Estaticamente Tipada**: Todas as variáveis devem ter seus tipos declarados
- **Baseada em Contratos**: O código é organizado em contratos, similares a classes em outras linguagens
- **Execução Descentralizada**: O código roda em blockchain, sendo imutável e transparente
- **Sintaxe Similar ao JavaScript/C++**: Facilita o aprendizado para desenvolvedores com experiência nessas linguagens

---

## O que é Web3?

**Web3.js** é uma biblioteca JavaScript que permite interagir com a blockchain Ethereum através de aplicações web. Ela funciona como uma ponte entre seu código JavaScript e os smart contracts na blockchain.

### Principais Funcionalidades:

- **Conexão com Provedores**: Conecta com nós Ethereum (Ganache, Infura, MetaMask)
- **Interação com Contratos**: Chama funções de smart contracts e recebe dados
- **Gerenciamento de Contas**: Acessa carteiras e envia transações
- **Eventos e Logs**: Escuta eventos emitidos pelos contratos

### Como Funciona:

```javascript
// 1. Conectar ao provedor (nó Ethereum)
const web3 = new Web3('http://localhost:7545');

// 2. Criar instância do contrato
const contract = new web3.eth.Contract(ABI, endereço);

// 3. Interagir com o contrato
await contract.methods.minhaFuncao().call(); // Leitura
await contract.methods.minhaFuncao().send({ from: conta }); // Escrita
```

**Casos de Uso:**
- Desenvolvimento de DApps (Aplicações Descentralizadas)
- Integração de carteiras (MetaMask, WalletConnect)
- Automação de transações blockchain
- Leitura de dados em tempo real da blockchain

---

## 📖 Conceitos de Solidity

### Estrutura Básica de um Contrato
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MeuContrato {
    // Variáveis de estado
    uint256 public numero;
    address public owner;
    
    // Eventos
    event NumeroAlterado(uint256 novoNumero);
    
    // Modificadores
    modifier apenasOwner() {
        require(msg.sender == owner, "Apenas o owner pode executar");
        _;
    }
    
    // Constructor
    constructor(uint256 _numero) {
        numero = _numero;
        owner = msg.sender;
    }
    
    // Funções
    function setNumero(uint256 _numero) public apenasOwner {
        numero = _numero;
        emit NumeroAlterado(_numero);
    }
}
```

### Tipos de Dados Principais
- **Inteiros**: `uint`, `int`, `uint256`, `int256`
- **Booleano**: `bool`
- **Endereços**: `address`, `address payable`
- **Strings**: `string`
- **Bytes**: `bytes`, `bytes32`
- **Arrays**: `uint[]`, `string[]`
- **Mappings**: `mapping(address => uint)`
- **Structs**: estruturas personalizadas
- **Enums**: enumerações

### Visibilidade de Funções
- **`public`** – Pode ser chamada por qualquer um (interna e externamente)
- **`external`** – Só pode ser chamada externamente
- **`internal`** – Só pode ser chamada dentro do contrato ou contratos filhos
- **`private`** – Só pode ser chamada dentro do próprio contrato

### Modificadores de Estado
- **`view`** – Lê dados, não modifica estado
- **`pure`** – Não lê nem modifica estado
- **`payable`** – Pode receber Ether

### Variáveis Globais Importantes
- **`msg.sender`** – Endereço de quem chamou a função
- **`msg.value`** – Quantidade de Wei enviada
- **`block.timestamp`** – Timestamp do bloco atual
- **`block.number`** – Número do bloco atual
- **`address(this).balance`** – Saldo do contrato

### Padrões Importantes
```solidity
// Require (validação)
require(condicao, "Mensagem de erro");

// Eventos (para logs)
event Transfer(address indexed from, address indexed to, uint256 value);
emit Transfer(msg.sender, recipient, amount);

// Modificadores (reutilização de lógica)
modifier onlyOwner() {
    require(msg.sender == owner);
    _;
}

// Herança
contract Token is ERC20 {
    // ...
}
```

---

## Contrato de Votação

Sistema de votação descentralizado implementado em Solidity.

### Tecnologias Utilizadas

- **Solidity**: ^0.4.22 até <0.9.0
- **Licença**: Fins Educacionais
- **EVM**: Ethereum Virtual Machine
- **IDE**: Remix IDE / Truffle / Hardhat

### Como Funciona

Este contrato implementa um sistema de votação simples e descentralizado na blockchain.

### Estrutura do Contrato

#### 1. **Variáveis de Estado**

```solidity
mapping (string => uint256) public votesReceived;
string[] public candidateList;
```

- `votesReceived`: Mapeia o nome de cada candidato para o número de votos recebidos
- `candidateList`: Array que armazena a lista de candidatos válidos

#### 2. **Constructor**

```solidity
constructor (string[] memory candidateNames)
```

- É executado apenas uma vez no momento do deploy do contrato
- Inicializa a lista de candidatos que poderão receber votos
- Os candidatos são definidos no momento da criação e não podem ser alterados

#### 3. **Funções Principais**

##### `voteForCandidate(string memory candidate)`
- Permite que qualquer endereço vote em um candidato
- Valida se o candidato existe antes de registrar o voto
- Incrementa o contador de votos do candidato

##### `totalVotesfor(string memory candidate)`
- Função de leitura (`view`) que não modifica o estado
- Retorna o número total de votos de um candidato específico
- Valida se o candidato existe antes de retornar

##### `validCandidate(string memory candidate)`
- Verifica se um candidato está na lista de candidatos válidos
- Usa `keccak256` para comparar strings de forma segura
- Retorna `true` se o candidato for válido, `false` caso contrário

### Fluxo de Uso

1. **Deploy**: O contrato é implantado com uma lista inicial de candidatos
   ```javascript
   // Exemplo: ["Alice", "Bob", "Carlos"]
   ```

2. **Votação**: Usuários chamam `voteForCandidate("Alice")` para registrar votos

3. **Consulta**: Qualquer pessoa pode verificar votos com `totalVotesfor("Alice")`

### Características de Segurança

- ✅ Valida candidatos antes de aceitar votos
- ✅ Todos os votos são registrados permanentemente na blockchain
- ✅ Transparência total - qualquer um pode verificar os resultados
- ⚠️ **Nota**: Este contrato não impede que um mesmo endereço vote múltiplas vezes

### Como Testar

1. Deploy do contrato em uma rede de teste (Remix IDE, Hardhat, Truffle)
2. Forneça uma lista de candidatos no constructor
3. Use `voteForCandidate()` para votar
4. Use `totalVotesfor()` para verificar resultados

---

## Contrato Hello World

Contrato simples para aprendizado e interação com MetaMask e Ganache via Web3.js

### Tecnologias Utilizadas

- **Solidity**: ^0.8.0
- **Web3.js**: ^4.x
- **Node.js**: Para execução dos scripts
- **Ganache**: Blockchain local para testes
- **MetaMask**: Carteira Ethereum
- **Remix IDE**: Compilação e deploy do contrato
- **Licença**: Fins Educacionais

### Código do Contrato

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

### Interação com Web3 via NPM

#### Pré-requisitos
```bash
npm install web3
```

#### Configuração e Conexão

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

#### Interagindo com o Contrato

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

```
#### Operações Disponíveis no Contrato

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

## 🚀 Como Começar

### Pré-requisitos

```bash
# Instalar Node.js e npm
# Baixar e instalar Ganache
# Instalar extensão MetaMask no navegador
```

### Instalação

```bash
# Instalar Web3.js
npm install web3

# Ou globalmente
npm install -g web3
```

### Deploy dos Contratos

1. Abra o [Remix IDE](https://remix.ethereum.org)
2. Importe os arquivos `.sol` do repositório
3. Compile os contratos
4. Conecte ao Ganache ou MetaMask
5. Faça o deploy
6. Copie o endereço do contrato e o ABI

---

## 📖 Recursos Adicionais

- [Documentação Solidity](https://docs.soliditylang.org/)
- [Web3.js Docs](https://web3js.readthedocs.io/)
- [Remix IDE](https://remix.ethereum.org/)
- [Ganache](https://trufflesuite.com/ganache/)
- [MetaMask](https://metamask.io/)

---

## 📄 Licença

Este repositório é destinado para **fins educacionais e de estudo**. 

Os contratos aqui contidos foram desenvolvidos como parte do **Binance Bootcamp - DIO** para aprendizado de:
- Desenvolvimento de Smart Contracts em Solidity
- Interação com blockchain via Web3.js
- Deploy e testes em ambiente local (Ganache)
- Integração com carteiras (MetaMask)

⚠️ **Aviso**: Estes contratos são exemplos didáticos e não devem ser utilizados em produção sem auditoria adequada.
