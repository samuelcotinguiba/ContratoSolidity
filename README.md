# Smart Contracts em Solidity

Repositório contendo contratos inteligentes desenvolvidos em Solidity com exemplos de interação via Web3.js

---

## 📚 Índice

1. [O que é Solidity?](#o-que-é-solidity)
2. [O que é Web3?](#o-que-é-web3)
3. [Conceitos de Solidity](#-conceitos-de-solidity)
4. [Projetos](#-projetos)

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

## 📁 Projetos

Este repositório contém três contratos inteligentes organizados em pastas separadas:

### 1. [Votacao/](Votacao/) - Sistema de Votação Descentralizado
Implementa um sistema de votação simples onde candidatos são definidos no deploy e usuários podem votar de forma transparente na blockchain.

**Principais Funcionalidades:**
- Registro de votos para candidatos pré-definidos
- Validação de candidatos
- Consulta de total de votos por candidato

**Tecnologias:** Solidity ^0.4.22, Remix IDE

---

### 2. [hello/](hello/) - Hello World com Web3.js
Contrato básico para aprendizado de Solidity e interação com blockchain via Web3.js, conectando MetaMask e Ganache.

**Principais Funcionalidades:**
- Armazenamento de strings na blockchain
- Modificação de variáveis de estado
- Exemplos completos de integração Web3

**Tecnologias:** Solidity ^0.8.0, Web3.js, Node.js, Ganache, MetaMask

---

### 3. [contrato/](contrato/) - Token ERC20 (DIO Token)
Implementação completa do padrão ERC20 para criação de tokens fungíveis na Ethereum.

**Principais Funcionalidades:**
- Transfer de tokens entre endereços
- Sistema de approve/allowance
- Consulta de saldos e supply total
- Deploy e transações via Remix IDE + MetaMask

**Tecnologias:** Solidity ^0.8.0, Padrão ERC20, Remix IDE, MetaMask

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
