// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract bonusVendedor {

    string public nomeVendedor;
    uint256 public fatorBonus;

        constructor(string memory _nomeVendedor,uint256 _fatorBonus)  {
        nomeVendedor = _nomeVendedor;
        fatorBonus = _fatorBonus;

    }

    function valorDeBonificacao(uint256 valorVenda) 
    public 
    view
    returns(uint256 valorDeBonus) {

        valorDeBonus = valorVenda*(fatorBonus/100);

        return valorDeBonus;
    } 

}

// 0x6c3F9896A4eCd74C5687F4505Fd739de83c0E35B
