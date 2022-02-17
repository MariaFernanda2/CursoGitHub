@CadastrarEndereco
Feature: Cadastrar endereco

  @GetBairros
  Scenario: Consulta para obter os bairros
    Given adiciono o body do tipo "RequestGetBairros"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | cidade      | manaus       |
      | siglaEstado | AM           |
      | bairro      | Adrianópolis |
    When faço um get para "/geral/get-bairro"
    Then recebo a response com status 200

  @GetBairrosSemSiglaEstado
  Scenario: Nao informar a sigla do Estado
    Given adiciono o body do tipo "RequestGetBairros"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | cidade      | manaus |
      | siglaEstado | null   |
    When faço um get para "/geral/get-bairro"
    Then recebo a response com status 400

  @GetBairrosSemCidade
  Scenario: Nao informar a cidade
    Given adiciono o body do tipo "RequestGetBairros"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | cidade      | null |
      | siglaEstado | AM   |
    When faço um get para "/geral/get-bairro"
    Then recebo a response com status 400

  @GetBairrosCidadeInexistente
  Scenario: Informar uma cidade inexistente
    Given adiciono o body do tipo "RequestGetBairros"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | cidade      | Cotia |
      | siglaEstado | SP    |
    When faço um get para "/geral/get-bairro"
    Then recebo a response com status 400

  @listaCidade
  Scenario: Listar cidades de um estado
    Given adiciono o body do tipo "RequestGetCidade"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | siglaEstado     | AM        |
      | estado          | Amazonas  |
      | idOrigemDigital | {number}6 |
    When faço um get para "/geral/lista-cidade"
    Then recebo a response com status 200

  @listaCidadeSemSiglaEstado
  Scenario: Listar cidades sem sigla do estado
    Given adiciono o body do tipo "RequestGetCidade"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | siglaEstado     | null      |
      | estado          | Amazonas  |
      | idOrigemDigital | {number}6 |
    When faço um get para "/geral/lista-cidade"
    Then recebo a response com status 400

  @listaCidadeSemEstado
  Scenario: Listar cidades sem estado
    Given adiciono o body do tipo "RequestGetCidade"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | siglaEstado     | AM        |
      | estado          | null      |
      | idOrigemDigital | {number}6 |
    When faço um get para "/geral/lista-cidade"
    Then recebo a response com status 400

  @listaCidadeComEstadoInexistente
    Scenario: Listar cidades com estado inexistente
      Given adiciono o body do tipo "RequestGetCidade"
      And utilizo os headers "CLIENT_ID"
      And adiciono os queryParams
        | siglaEstado     | AM        |
        | estado          | Brasil    |
        | idOrigemDigital | {number}6 |
      When faço um get para "/geral/lista-cidade"
      Then recebo a response com status 400

  @listaEstados
  Scenario: Listar todos os estados
    Given adiciono o body do tipo "RequestGetEstados"
    And utilizo os headers "CLIENT_ID"
    When faço um get para "/geral/lista-estado"
    Then recebo a response com status 200

