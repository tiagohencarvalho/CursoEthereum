// SPDX-License-Identifier: MIT
// 0x726a5532291D2afA6615902b3DA32377EACc463c
pragma solidity 0.8.20;

contract controle {
    address public locador;

    modifier apenasLocador() {
        require(msg.sender == locador, "Apenas locador");
        _;
    }

    constructor() {
        locador = msg.sender;
    }
}

contract Ownable {
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public onlyOwner returns (bool) {
        owner = _owner;
        return true;
    }
}

contract livroDeBordo is Ownable, controle {
    mapping(bytes32 => string) public ownerMessages;

    function saveMessage(string calldata _msg)
        external
        onlyOwner
        returns (bytes32)
    {
        ownerMessages[keccak256(bytes(_msg))] = _msg;
        return keccak256(bytes(_msg));
    }
}

contract aluguelMelhorado is livroDeBordo {
    mapping(string => Contratos) public clientes;
    uint256 public totalDeContratos;

    struct Contratos {
        string nomeLocador;
        string nomeLocatario;
        string nomeContrato;
        uint256[] valorDoAluguel;
        bytes32 codigoContrato;
        bool status;
    }

    modifier somenteParteValida(uint256 _parte) {
        require(_parte == 1 || _parte == 2, "Parte invalida");
        _;
    }

    modifier somenteMesValido(uint256 _mes) {
        require(_mes > 0 || _mes <= 36, "Mes invalido");
        _;
    }

    function criaContrato(
        string memory _nomeLocador,
        string memory _nomeLocatario,
        string memory _nomeContrato,
        uint256 _valorInicialContrato
    ) external returns (bool) {
        require(clientes[_nomeContrato].status == false, "contrato ja aberto");
        uint256[] memory novoValorDoAluguel = new uint256[](36);
        for (uint256 i = 0; i < 36; i++) {
            novoValorDoAluguel[i] = _valorInicialContrato;
        }
        Contratos memory novoContrato = Contratos(
            _nomeLocador,
            _nomeLocatario,
            _nomeContrato,
            novoValorDoAluguel,
            keccak256(bytes(string.concat(_nomeLocador, _nomeLocatario))),
            true
        );
        clientes[_nomeContrato] = novoContrato;
        totalDeContratos++;
        return true;
    }

    function codigoContrato(string memory _nomeContrato, string calldata _msg)
        external
        onlyOwner
        returns (bytes32)
    {
        ownerMessages[
            keccak256(
                bytes(
                    string.concat(
                        clientes[_nomeContrato].nomeLocador,
                        clientes[_nomeContrato].nomeLocatario
                    )
                )
            )
        ] = _msg;
        return keccak256(bytes(_msg));
    }

    function valorAluguelMes(string memory _nomeContrato, uint256 _mes)
        public
        view
        apenasLocador
        somenteMesValido(_mes)
        returns (uint256)
    {
        return clientes[_nomeContrato].valorDoAluguel[_mes - 1];
    }

    function partes(string memory _nomeContrato)
        public
        view
        returns (string memory Locador, string memory Locatario)
    {
        Locador = clientes[_nomeContrato].nomeLocador;
        Locatario = clientes[_nomeContrato].nomeLocatario;
        return (Locador, Locatario);
    }

    function alteraNomeLocadorouLocatoraio(
        string memory _nomeContrato,
        uint256 opcao,
        string memory name
    ) external
    apenasLocador
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

    function alteraValorMesesRestantes(
        string memory _nomeContrato,
        uint256 inicioMes,
        uint256 aumento
    ) public
    apenasLocador
    returns (bool) {
        for (
            uint256 i = inicioMes;
            i < clientes[_nomeContrato].valorDoAluguel.length;
            i++
        ) {
            clientes[_nomeContrato].valorDoAluguel[i - 1] =
                clientes[_nomeContrato].valorDoAluguel[i - 1] +
                aumento;
        }
        return true;
    }
}
