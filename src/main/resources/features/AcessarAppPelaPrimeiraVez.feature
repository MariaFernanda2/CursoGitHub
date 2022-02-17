@AcessarAppPelaPrimeiraVez
Feature: Acessar App pela primeira vez

  @InformarNumeroDeCelularParaLogin
  Scenario: Informar numero de celular para login
    Given adiciono o body do tipo "RequestSolicitaSMS" alterando os dados
      | origem   | {number}6   |
      | telefone | 11942391453 |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/geral/solicita-sms"
    Then recebo a response com status 200
    Given adiciono o body do tipo "RequestTelefones"
    And utilizo os headers "AUTH_ENUM"
    When faço um get para "/qa/telefones/335644"
    Then recebo a response com status 200 os dados
      | [0].idTelefone | {number}345050 |


  @InformarNumeroDeCelularInvalido
  Scenario: Informar numero de celular invalido
    Given adiciono o body do tipo "RequestSolicitaSMS" alterando os dados
      | origem   | {number}6 |
      | telefone | 1         |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/geral/solicita-sms"
    Then recebo a response com status 400 os dados
      | errors[0].message | O campo telefone não pde ter menos de 11 caracteres. |

  @NaoInformarNumeroDeCelular
  Scenario: Nao informar numero de celular
    Given adiciono o body do tipo "RequestSolicitaSMS" alterando os dados
      | origem   | {number}6 |
      | telefone | null      |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/geral/solicita-sms"
    Then recebo a response com status 400 os dados
      | errors[0].message | O campo telefone não pode ser nulo |

  @InformarNumeroDeCelularSemDDD
  Scenario: Informar numero de celular sem DDD
    Given adiciono o body do tipo "RequestSolicitaSMS" alterando os dados
      | origem   | {number}6 |
      | telefone | 942391453 |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/geral/solicita-sms"
    Then recebo a response com status 400 os dados
      | errors[0].message | Informar o DDD |

  @InformarDDDsemNumeroDoCelular
  Scenario: Informar DDD e não informar o celular
    Given adiciono o body do tipo "RequestSolicitaSMS" alterando os dados
      | origem   | {number}6 |
      | telefone | 011       |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/geral/solicita-sms"
    Then recebo a response com status 400 os dados
      | errors[0].message | O campo telefone não pde ter menos de 11 caracteres. |

  @InformarCelularComCaracteresEspeciais
  Scenario: Informar numero de celular com caracteres especiais
    Given adiciono o body do tipo "RequestSolicitaSMS" alterando os dados
      | origem   | {number}6      |
      | telefone | (11)94239-1453 |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/geral/solicita-sms"
    Then recebo a response com status 400 os dados
      | errors[0].message | O campo telefone não pde ter menos de 11 caracteres. |

  @InformarCaracteresEspeciais
  Scenario: Informar apenas caracteres especiais no campo telefone
    Given adiciono o body do tipo "RequestSolicitaSMS" alterando os dados
      | origem   | {number}6   |
      | telefone | @@@@@@@@@@@ |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/geral/solicita-sms"
    Then recebo a response com status 400 os dados
      | errors[0].message | O campo telefone não pde ter menos de 11 caracteres. |

  @InformarMaisDeOnzeCaracteres
  Scenario: Informar mais de onze caracteres no campo celular
    Given adiciono o body do tipo "RequestSolicitaSMS" alterando os dados
      | origem   | {number}6    |
      | telefone | 119423914533 |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/geral/solicita-sms"
    Then recebo a response com status 400 os dados
      | errors[0].message | O campo telefone não pode ter mais de 11 caracteres.   |

  @InformarCelularSemDDDeSemNonoDigito
  Scenario: Informar celular sem DDD e sem nono digito
    Given adiciono o body do tipo "RequestSolicitaSMS" alterando os dados
      | origem   | {number}6 |
      | telefone | 423914533 |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/geral/solicita-sms"
    Then recebo a response com status 400 os dados
      | errors[0].message | Informe o DDD e o nono digito |

  @InformarCodigoSmsInvalido
  Scenario: Informar codigo sms invalido
    Given adiciono o body do tipo "RequestClienteSMS" alterando os dados
      | codigoSMS          | {number}1021  |
      | idOrigemDigital    | {number}6     |
      | numeroDispositivo  | 11942391453   |
      | tipoCliente        | PF            |
      | versaoAplicativo   | {number}4.8.1 |
      | telefoneSemMascara | 11942391453   |
    And utilizo os headers "AUTH_SMS"
    When faço um post para "/cliente/sms"
    Then recebo a response com status 400 os dados
      | errors[0].message | Código SMS Inválido |

  @InformarCodigoSmsSemOrigemDigital
  Scenario: Informar codigo sms sem a origem digital
    Given adiciono o body do tipo "RequestClienteSMS" alterando os dados
      | codigoSMS          | {number}137   |
      | idOrigemDigital    | null          |
      | numeroDispositivo  | 11942391453   |
      | tipoCliente        | PF            |
      | versaoAplicativo   | {number}4.8.1 |
      | telefoneSemMascara | 11942391453   |
    And utilizo os headers "AUTH_SMS"
    When faço um post para "/cliente/sms"
    Then recebo a response com status 400

  @InformarCodigoSmsSemOrigemDigital
  Scenario: Informar codigo sms sem o numero do dispositivo
    Given adiciono o body do tipo "RequestClienteSMS" alterando os dados
      | codigoSMS          | {number}137   |
      | idOrigemDigital    | {number}6     |
      | numeroDispositivo  | null          |
      | tipoCliente        | PF            |
      | versaoAplicativo   | {number}4.8.1 |
      | telefoneSemMascara | 11942391453   |
    And utilizo os headers "AUTH_SMS"
    When faço um post para "/cliente/sms"
    Then recebo a response com status 400

  @InformarCodigoSmsSemNumeroDispositivoTelefoneSemMascara
  Scenario: Informar codigo sms sem o numero do dispositivo e sem telefone sem mascara
    Given adiciono o body do tipo "RequestClienteSMS" alterando os dados
      | codigoSMS          | {number}137   |
      | idOrigemDigital    | {number}6     |
      | numeroDispositivo  | null          |
      | tipoCliente        | PF            |
      | versaoAplicativo   | {number}4.8.1 |
      | telefoneSemMascara | null          |
    And utilizo os headers "AUTH_SMS"
    When faço um post para "/cliente/sms"
    Then recebo a response com status 400

  @InformarNumeroSemDDDsms
  Scenario: Informar codigo sms com o numero do dispositivo sem o DDD
    Given adiciono o body do tipo "RequestClienteSMS" alterando os dados
      | codigoSMS          | {number}137   |
      | idOrigemDigital    | {number}6     |
      | numeroDispositivo  | 942391453     |
      | tipoCliente        | PF            |
      | versaoAplicativo   | {number}4.8.1 |
      | telefoneSemMascara | 942391453     |
    And utilizo os headers "AUTH_SMS"
    When faço um post para "/cliente/sms"
    Then recebo a response com status 400

  @InformarCodigoSmsSemNonoDigito
  Scenario: Informar codigo sms com o numero do dispositivo sem o 9
    Given adiciono o body do tipo "RequestClienteSMS" alterando os dados
      | codigoSMS          | {number}137   |
      | idOrigemDigital    | {number}6     |
      | numeroDispositivo  | 42391453      |
      | tipoCliente        | PF            |
      | versaoAplicativo   | {number}4.8.1 |
      | telefoneSemMascara | 42391453      |
    And utilizo os headers "AUTH_SMS"
    When faço um post para "/cliente/sms"
    Then recebo a response com status 400

  @ListarRevenda
  Scenario: Informar endereço para listar revenda
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Adrianópolis         |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | {number}335644       |
      | cliente.idEndereco  | {number}327567       |
      | cliente.latitude    | {number}-3.3465345   |
      | cliente.longitude   | {number}-60.345236   |
      | cliente.rua         | São josé dos pinhais |
      | cliente.siglaEstado | AM                   |
      | codigoRevenda       | {number}108598       |
      | idOrigem            | {number}1            |
      | pesquisa            | MARIA                |
      | tipoPedido          | PEDIDO_ECONOMICO     |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200

    Given adiciono o body do tipo "RequestEnderecos"
    And utilizo os headers "AUTH_ENUM"
    When faço um get para "/qa/enderecos/335644"
    Then recebo a response com status 200 os dados
      | [0].idEndereco          | {number}327567                      |
      | [0].idCliente           | {number}335644                      |
      | [0].rua                 | S?o jos? dos pinhais                |
      | [0].numero              | 04                                  |
      | [0].complemento         | casa vermelha com pot?o de aluminio |
      | [0].pontoReferencia     | Mercadinho pague barato             |
      | [0].bairro              | Adrian?polis                        |
      | [0].cep                 | 69123-456                           |
      | [0].idCidadeAtendimento | {number}1                           |
      | [0].cidade              | manaus                              |
      | [0].siglaEstado         | AM                                  |
      | [0].cordaFachada        | azul                                |
      | [0].latitude            | {number}-3.34653450F                |
      | [0].longitude           | {number}-60.34523600F               |
      | [0].numeroApto          | C2                                  |
      | [0].blocoPredio         | A                                   |
      | [0].moveuMapa           | {bool}true                          |

  @ListarRevendaSemIdClienteIdEndereco
  Scenario: Listar revenda sem informar IdCliente e IdEndereco
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Adrianópolis         |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | null                 |
      | cliente.idEndereco  | null                 |
      | cliente.latitude    | {number}-3.3465345   |
      | cliente.longitude   | {number}-60.345236   |
      | cliente.rua         | São josé dos pinhais |
      | cliente.siglaEstado | AM                   |
      | codigoRevenda       | {number}108598       |
      | idOrigem            | null                 |
      | pesquisa            | MARIA                |
      | tipoPedido          | PEDIDO_ECONOMICO     |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200

  @ListarRevendaSemEnderecoIdClienteIdEndereco
  Scenario: Listar revenda sem informar IdClient, IdEndereco e endereco
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | codigoRevenda | {number}108598   |
      | idOrigem      | {number}1        |
      | pesquisa      | MARIA            |
      | tipoPedido    | PEDIDO_ECONOMICO |
      | versaoApp     | {number}4.8.1    |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 400

  @ListarRevendaBairroInexistente
  Scenario: Listar revenda com bairro inexistente
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | inexistente          |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | {number}335644       |
      | cliente.idEndereco  | {number}327567       |
      | cliente.latitude    | {number}-3.3465345   |
      | cliente.longitude   | {number}-60.345236   |
      | cliente.rua         | São josé dos pinhais |
      | cliente.siglaEstado | AM                   |
      | codigoRevenda       | {number}108598       |
      | idOrigem            | {number}1            |
      | pesquisa            | MARIA                |
      | tipoPedido          | PEDIDO_ECONOMICO     |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200

  @ListarRevendaCidadeInexistente
  Scenario: Listar revenda com cidade inexistente
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Adrianópolis         |
      | cliente.cidade      | inexistente          |
      | cliente.idCliente   | {number}335644       |
      | cliente.idEndereco  | {number}327567       |
      | cliente.latitude    | {number}-3.3465345   |
      | cliente.longitude   | {number}-60.345236   |
      | cliente.rua         | São josé dos pinhais |
      | cliente.siglaEstado | AM                   |
      | codigoRevenda       | {number}108598       |
      | idOrigem            | {number}1            |
      | pesquisa            | MARIA                |
      | tipoPedido          | PEDIDO_ECONOMICO     |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200

  @ListarRevendaIdClienteInexistente
  Scenario: Listar revenda com ID cliente inexistente
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Adrianópolis         |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | {number}000000       |
      | cliente.idEndereco  | {number}327567       |
      | cliente.latitude    | {number}-3.3465345   |
      | cliente.longitude   | {number}-60.345236   |
      | cliente.rua         | São josé dos pinhais |
      | cliente.siglaEstado | AM                   |
      | codigoRevenda       | {number}108598       |
      | idOrigem            | {number}1            |
      | pesquisa            | MARIA                |
      | tipoPedido          | PEDIDO_ECONOMICO     |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200

  @ListarRevendaIdEnderecoInexistente
  Scenario: Listar revenda com ID endereco inexistente
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Adrianópolis         |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | {number}000000       |
      | cliente.idEndereco  | {number}000000       |
      | cliente.latitude    | {number}-3.3465345   |
      | cliente.longitude   | {number}-60.345236   |
      | cliente.rua         | São josé dos pinhais |
      | cliente.siglaEstado | AM                   |
      | codigoRevenda       | {number}108598       |
      | idOrigem            | {number}1            |
      | pesquisa            | MARIA                |
      | tipoPedido          | PEDIDO_ECONOMICO     |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200

  @ListarRevendaSemLatitudeLongitude
  Scenario: Listar revenda sem latitude e longitude
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Adrianópolis         |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | {number}335644       |
      | cliente.idEndereco  | {number}327567       |
      | cliente.latitude    | null                 |
      | cliente.longitude   | null                 |
      | cliente.rua         | São josé dos pinhais |
      | cliente.siglaEstado | AM                   |
      | codigoRevenda       | {number}108598       |
      | idOrigem            | {number}1            |
      | pesquisa            | MARIA                |
      | tipoPedido          | PEDIDO_ECONOMICO     |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200

  @ListarRevendaSemRua
  Scenario: Listar revenda sem informar rua
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Adrianópolis       |
      | cliente.cidade      | manaus             |
      | cliente.idCliente   | {number}335644     |
      | cliente.idEndereco  | {number}327567     |
      | cliente.latitude    | {number}-3.3465345 |
      | cliente.longitude   | {number}-60.345236 |
      | cliente.rua         | null               |
      | cliente.siglaEstado | AM                 |
      | codigoRevenda       | {number}108598     |
      | idOrigem            | {number}1          |
      | pesquisa            | MARIA              |
      | tipoPedido          | PEDIDO_ECONOMICO   |
      | versaoApp           | {number}4.8.1      |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200

  @ListarRevendaSemSiglaEstado
  Scenario: Listar revenda sem informar sigla do estado
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Adrianópolis         |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | {number}335644       |
      | cliente.idEndereco  | {number}327567       |
      | cliente.latitude    | {number}-3.3465345   |
      | cliente.longitude   | {number}-60.345236   |
      | cliente.rua         | São josé dos pinhais |
      | cliente.siglaEstado | null                 |
      | codigoRevenda       | {number}108598       |
      | idOrigem            | {number}1            |
      | pesquisa            | MARIA                |
      | tipoPedido          | PEDIDO_ECONOMICO     |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200

  @ListarRevendaSemCodigoRevenda
  Scenario: Listar revenda sem informar codigo revenda
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Adrianópolis         |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | {number}335644       |
      | cliente.idEndereco  | {number}327567       |
      | cliente.latitude    | {number}-3.3465345   |
      | cliente.longitude   | {number}-60.345236   |
      | cliente.rua         | São josé dos pinhais |
      | cliente.siglaEstado | AM                   |
      | codigoRevenda       | null                 |
      | idOrigem            | {number}1            |
      | pesquisa            | MARIA                |
      | tipoPedido          | PEDIDO_ECONOMICO     |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 400

  @ListarRevendaSemIdOrigem
  Scenario: Listar revenda sem informar id origem
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Adrianópolis         |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | {number}335644       |
      | cliente.idEndereco  | {number}327567       |
      | cliente.latitude    | {number}-3.3465345   |
      | cliente.longitude   | {number}-60.345236   |
      | cliente.rua         | São josé dos pinhais |
      | cliente.siglaEstado | AM                   |
      | codigoRevenda       | {number}108598       |
      | idOrigem            | null                 |
      | pesquisa            | MARIA                |
      | tipoPedido          | PEDIDO_ECONOMICO     |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200

  @ListarRevendaPesquisaInexistente
  Scenario: Listar revenda com uma pesquisa inexistente
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Adrianópolis         |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | {number}335644       |
      | cliente.idEndereco  | {number}327567       |
      | cliente.latitude    | {number}-3.3465345   |
      | cliente.longitude   | {number}-60.345236   |
      | cliente.rua         | São josé dos pinhais |
      | cliente.siglaEstado | AM                   |
      | codigoRevenda       | {number}108598       |
      | idOrigem            | {number}1            |
      | pesquisa            | Revenda@#123         |
      | tipoPedido          | PEDIDO_ECONOMICO     |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 400

  @ListarRevendatipoPedidoInexistente
  Scenario: Listar revenda com tipo de pedido inexistente
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Adrianópolis         |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | {number}335644       |
      | cliente.idEndereco  | {number}327567       |
      | cliente.latitude    | {number}-3.3465345   |
      | cliente.longitude   | {number}-60.345236   |
      | cliente.rua         | São josé dos pinhais |
      | cliente.siglaEstado | AM                   |
      | codigoRevenda       | {number}10013        |
      | idOrigem            | {number}1            |
      | pesquisa            | Chaminha             |
      | tipoPedido          | PEDIDO_NA            |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200




