// SPDX-License-Identifier: MIT
// 0xB8Abed49fb68b23c2DF9a07e8f6f086c633522B1
pragma solidity 0.8.20;

contract aluguelMelhorado {

    mapping(string => Contratos) public clientes;
    uint public totalDeContratos;

    struct Contratos {
        string nomeLocador;
        string nomeLocatario;
        string nomeContrato;
        uint256[] valorDoAluguel;
        bool status;
    }

        modifier somenteParteValida(uint _parte) {
        require(_parte == 1 || _parte ==2, "Parte invalida");
        _;
    }

        modifier somenteMesValido(uint _mes) {
        require(_mes > 0 || _mes <= 36, "Mes invalido");
        _;
    }

    function criaContrato(
        string memory _nomeLocador,
        string memory _nomeLocatario,
        string memory _nomeContrato,
        uint  _valorInicialContrato)
        external returns (bool){
            require(clientes[_nomeContrato].status == false, "contrato ja aberto");
            uint256[] memory novoValorDoAluguel = new uint256[](36);
            for (uint i = 0; i < 36; i++) {
            novoValorDoAluguel[i] = _valorInicialContrato;
    }
            Contratos memory novoContrato = Contratos(_nomeLocador, _nomeLocatario, _nomeContrato, novoValorDoAluguel, true);
            clientes[_nomeContrato] = novoContrato;
            totalDeContratos++;
            return true;
        }


    function valorAluguelMes(string memory _nomeContrato, uint _mes)
    public
    view
    somenteMesValido(_mes)
    returns(uint256){
        return clientes[_nomeContrato].valorDoAluguel[_mes - 1];
        }

   function partes(string memory _nomeContrato)
   public
    view
    returns (string memory Locador, string memory Locatario){
         Locador = clientes[_nomeContrato].nomeLocador;
         Locatario = clientes[_nomeContrato].nomeLocatario;
     return (Locador, Locatario);
     }

   function alteraNomeLocadorouLocatoraio(string memory _nomeContrato, uint opcao, string memory name)
   external
   somenteParteValida(opcao)
   returns (bool) {
        if (opcao == 1) {
           clientes[_nomeContrato].nomeLocador = name;
       } else if (opcao == 2) {
             clientes[_nomeContrato].nomeLocatario = name;
        } else {
            return false;
        }
        return true;
    }

    function alteraValorMesesRestantes(string memory _nomeContrato, uint inicioMes, uint256 aumento) public returns (bool){
   for(uint i = inicioMes ; i < clientes[_nomeContrato].valorDoAluguel.length; i ++ ){
        clientes[_nomeContrato].valorDoAluguel[i] = clientes[_nomeContrato].valorDoAluguel[i]+aumento;
   }
   return true;
}
}
