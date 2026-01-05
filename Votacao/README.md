# Contrato de Votação

Sistema de votação descentralizado implementado em Solidity.

## 📋 Sobre o Contrato

Este contrato implementa um sistema de votação simples e descentralizado na blockchain, permitindo que usuários votem em candidatos pré-definidos.

## 🛠️ Tecnologias Utilizadas

- **Solidity**: ^0.4.22 até <0.9.0
- **Licença**: Fins Educacionais
- **EVM**: Ethereum Virtual Machine
- **IDE**: Remix IDE / Truffle / Hardhat

## 📖 Estrutura do Contrato

### Variáveis de Estado

```solidity
mapping (string => uint256) public votesReceived;
string[] public candidateList;
```

- `votesReceived`: Mapeia o nome de cada candidato para o número de votos recebidos
- `candidateList`: Array que armazena a lista de candidatos válidos

### Constructor

```solidity
constructor (string[] memory candidateNames)
```

- É executado apenas uma vez no momento do deploy do contrato
- Inicializa a lista de candidatos que poderão receber votos
- Os candidatos são definidos no momento da criação e não podem ser alterados

### Funções Principais

#### `voteForCandidate(string memory candidate)`
- Permite que qualquer endereço vote em um candidato
- Valida se o candidato existe antes de registrar o voto
- Incrementa o contador de votos do candidato

#### `totalVotesfor(string memory candidate)`
- Função de leitura (`view`) que não modifica o estado
- Retorna o número total de votos de um candidato específico
- Valida se o candidato existe antes de retornar

#### `validCandidate(string memory candidate)`
- Verifica se um candidato está na lista de candidatos válidos
- Usa `keccak256` para comparar strings de forma segura
- Retorna `true` se o candidato for válido, `false` caso contrário

## 🚀 Fluxo de Uso

1. **Deploy**: O contrato é implantado com uma lista inicial de candidatos
   ```javascript
   // Exemplo: ["Alice", "Bob", "Carlos"]
   ```

2. **Votação**: Usuários chamam `voteForCandidate("Alice")` para registrar votos

3. **Consulta**: Qualquer pessoa pode verificar votos com `totalVotesfor("Alice")`

## 🔒 Características de Segurança

- ✅ Valida candidatos antes de aceitar votos
- ✅ Todos os votos são registrados permanentemente na blockchain
- ✅ Transparência total - qualquer um pode verificar os resultados
- ⚠️ **Nota**: Este contrato não impede que um mesmo endereço vote múltiplas vezes

## 🧪 Como Testar

1. Deploy do contrato em uma rede de teste (Remix IDE, Hardhat, Truffle)
2. Forneça uma lista de candidatos no constructor: `["Alice", "Bob", "Carlos"]`
3. Use `voteForCandidate("Alice")` para votar
4. Use `totalVotesfor("Alice")` para verificar resultados
5. Use `validCandidate("Alice")` para validar se um candidato existe

---

**Desenvolvido como parte do Binance Bootcamp - DIO** 🚀
