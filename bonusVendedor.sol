// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract bonusVendedor {

    string public nomeVendedor;
    uint256  public valorDeBonus;
    uint256  private valorVenda;
    uint256 constant fatorBonus = 10;


    function valorDeBonificacao() public returns(uint256) {

        valorDeBonus = valorVenda*(fatorBonus/100);

        return valorDeBonus;
    } 

}

// 0x66FF7Bd333CF2431A6Bc8Db65816D69d724Ba4CD
