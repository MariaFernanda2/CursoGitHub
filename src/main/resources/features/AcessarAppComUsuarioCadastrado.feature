@AcessarAppComUsuarioCadastrado
Feature: Acessar App com Usuario Cadastrado

  @AcessarAppComUsuarioCadastrado
  Scenario: Acessar aplicativo com usuario cadastrado
    Given adiciono o body do tipo "RequestClienteID"
    And utilizo os headers "AUTH_ENUM"
    When faço um get para "/cliente/335644"
    Then recebo a response com status 200 os dados
      | idCliente   | {number}335644 |
      | tipoCliente | PF             |

  @AcessarAppSemPassarIdCliente
  Scenario: Acessar aplicativo sem passar ID  cliente
    Given adiciono o body do tipo "RequestClienteID"
    And utilizo os headers "AUTH_ENUM"
    When faço um get para "/cliente"
    Then recebo a response com status 422

  @IdClienteInexistente
  Scenario: Acessar aplicativo com usuario inexistente
    Given adiciono o body do tipo "RequestClienteID"
    And utilizo os headers "AUTH_ENUM"
    When faço um get para "/cliente/000000"
    Then recebo a response com status 422 os dados
      | msg | ID Cliente não permitido 4 |

  @testeIntegradoUsuarioCadastrado
  Scenario: Garantir que o acesso foi realizado com sucesso para ID cliente
    Given adiciono o body do tipo "RequestQaClientes"
    And utilizo os headers "AUTH_ENUM"
    When faço um get para "/qa/clientes/335644"
    Then recebo a response com status 200 os dados
      | [0].idCliente                | {number}335644            |
      | [0].situacao                 | Ativo                     |
      | [0].nome                     | Maria Fernanda            |
      | [0].email                    | mariafernanda@yopmail.com |
      | [0].cpf_cnpj                 | 46359385813               |
      | [0].revendaFavorita          | Seu Jose do Gas           |
      | [0].numeroDispositivo        | 11942391453               |
      | [0].usuarioUltimaAtualizacao | Mafe                      |
      | [0].cadastroCompleto         | {bool}true                |

  @testeIntegradoEndereco
  Scenario: Garantir que o acesso foi realizado com sucesso trazendo os dados do endereco corretos
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
      | [0].latitude            | {number}-3.099931F                  |
      | [0].longitude           | {number}-60.00592FF                 |
      | [0].numeroApto          | C2                                  |
      | [0].blocoPredio         | A                                   |
      | [0].moveuMapa           | {bool}true                          |

  @testeIntegradoFidelidade
  Scenario: Garantir que o acesso foi realizado com sucesso trazendo os dados de fidelidade
    Given adiciono o body do tipo "RequestQaFidelidade"
    And utilizo os headers "AUTH_ID"
    When faço um get para "/qa/fidelidade/335644"
    Then recebo a response com status 200 os dados
      | [0].idCliente            | {number}335644 |
#     | [0].pontosAcumulados     | {number}49     |
      | [0].pontosUsados         | {number}0      |
#     | [0].classificacaoCliente | Azul           |

  @testeIntegradoEstadoCidade
  Scenario: Garantir que o acesso foi realizado com sucesso trazendo sigla do estado e cidade
    Given adiciono o body do tipo "RequestGetCidadesEstados"
    And utilizo os headers "AUTH_ID"
    And adiciono os queryParams
      | siglaEstado | AM     |
      | cidade      | manaus |
    When faço um get para "/qa/cidades?siglaEstado"
    Then recebo a response com status 200

#  @testeIntegradoCodigoAmigo
#  Scenario: Garantir que o acesso foi realizado com sucesso trazendo os dados do codigo amigo
#    Given adiciono o body do tipo "RequestQaCodigoAmigo"
#    And utilizo os headers "AUTH_ID"
#    When faço um get para "/qa/codigoAmigoCliente/335644"
#    Then recebo a response com status 200




