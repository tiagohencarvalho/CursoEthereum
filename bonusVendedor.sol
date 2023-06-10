// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract bonusVendedor {

    string public nomeVendedor;
    uint32 public valorDeBonus;
    uint32 private valorVenda;

    uint32 constant fatorBonus = 500;

    function valorDeBonificacao() public returns(uint256) {

        valorDeBonus = valorVenda*fatorBonus;

        return valorDeBonus;
    } 

}

// 0xb56dE27e0aEB5C40cc8786d20F7378cE293E61eC
