// SPDX-License-Identifier: MIT
//0xf994d06D36b80eA298F31C0eC1123B0aA85e2dbA
pragma solidity 0.8.20;

contract aluguel {

    string public nomeLocator;
    string public nomeLocatario;
    uint256[] public valorDoAluguel;

        constructor(string memory _nomeLocator, string memory _nomeLocatario, uint256 _valorInicialAluguel)  {
        nomeLocator = _nomeLocator;
        nomeLocatario = _nomeLocatario;
         for(uint i = 0 ; i < 36; i ++){
            valorDoAluguel.push(_valorInicialAluguel);
        } 

    }

    function valorAluguelMes(uint mes) public view returns( uint256){
        return valorDoAluguel[mes - 1];
        }

    function partes() public view returns (string memory, string memory){
        return (nomeLocator, nomeLocatario);
    }

    function alteraNomeLocadorouLocatoraio(uint opcao, string memory name) external returns (bool) {
        if (opcao == 1) {
            nomeLocator = name;
        } else if (opcao == 2) {
            nomeLocatario = name;
        } else {
            return false;
        }
        return true;
    }

    function alteraValorMesesRestantes(uint inicioMes, uint256 aumento) public returns (bool){
    for(uint i = inicioMes ; i < valorDoAluguel.length; i ++ ){
        valorDoAluguel[i] = valorDoAluguel[i]+aumento;
    }
    return true;
}
    

}
