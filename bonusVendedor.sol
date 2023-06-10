// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract bonusVendedor {

    string public nomeVendedor;
    uint256  public valorDeBonus;
    uint256  private valorVenda;
    uint256 public fatorBonus;

        constructor(string memory _nomeVendedor,uint256 _fatorBonus, uint256 _valorVenda)  {
        nomeVendedor = _nomeVendedor;
        valorVenda = _fatorBonus;
        valorVenda = _valorVenda;
    }

    function valorDeBonificacao() public returns(uint256) {

        valorDeBonus = valorVenda*(fatorBonus/100) + valorVenda;

        return valorDeBonus;
    } 

}

// 0x7a14081375471f60b60D5c68adcc542BA436ED6d
