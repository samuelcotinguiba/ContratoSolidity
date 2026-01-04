# Contrato de Votação em Solidity

## O que é Solidity?

Solidity é uma linguagem de programação orientada a objetos, de alto nível, projetada especificamente para desenvolver **smart contracts** (contratos inteligentes) que rodam na **Ethereum Virtual Machine (EVM)**. 

### Características principais:

- **Linguagem Estaticamente Tipada**: Todas as variáveis devem ter seus tipos declarados
- **Baseada em Contratos**: O código é organizado em contratos, similares a classes em outras linguagens
- **Execução Descentralizada**: O código roda em blockchain, sendo imutável e transparente
- **Sintaxe Similar ao JavaScript/C++**: Facilita o aprendizado para desenvolvedores com experiência nessas linguagens

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

## Como Funciona o Contrato de Votação

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

### Tecnologias Utilizadas

- **Solidity**: ^0.4.22 até <0.9.0
- **Licença**: MIT
- **EVM**: Ethereum Virtual Machine

## Como Testar

1. Deploy do contrato em uma rede de teste (Remix IDE, Hardhat, Truffle)
2. Forneça uma lista de candidatos no constructor
3. Use `voteForCandidate()` para votar
4. Use `totalVotesfor()` para verificar resultados
