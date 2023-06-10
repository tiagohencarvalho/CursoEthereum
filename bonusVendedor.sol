// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract bonusVendedor {

    string public nomeVendedor;
    uint256  public valorDeBonus;
    uint256 public fatorBonus;

        constructor(string memory _nomeVendedor,uint256 _fatorBonus)  {
        nomeVendedor = _nomeVendedor;
        fatorBonus = _fatorBonus;

    }

    function valorDeBonificacao(uint256 valorVenda) public returns(uint256) {

        valorDeBonus = valorVenda*(fatorBonus/100);

        return valorDeBonus;
    } 

}

// 0x1f3FF6e98dEa265BaeB8FE9D44eBE46C56c6B0b1
