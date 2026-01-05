// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract voting {
    
    mapping (string => uint256) public votesReceived; // "Receives" -> "Received"

    string[] public candidateList; // espaço estava faltando
    
    constructor (string[] memory candidateNames){
        candidateList = candidateNames;
    }

    function totalVotesfor(string memory candidate) view public returns(uint256){
        require(validCandidate(candidate));
        return votesReceived[candidate];
    }

    function voteForCandidate(string memory candidate) public{
        require(validCandidate(candidate));
        votesReceived[candidate] += 1;
    }
    
    function validCandidate(string memory candidate) view public returns(bool){
        for(uint i = 0; i < candidateList.length; i++){ // "lenght" -> "length"
            if(keccak256(abi.encodePacked(candidateList[i])) == keccak256(abi.encodePacked(candidate))){
                return true; // estava faltando o return true e fechar chaves
            }
        }
        return false;
    }
}