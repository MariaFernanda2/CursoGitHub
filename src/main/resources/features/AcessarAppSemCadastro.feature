@AcessarAppSemCadastro
Feature: Acessar APP sem cadastro

  @AddCidadeNaoAtendida
  Scenario: Adicionar cidade na qual a Fogas nao atende
    Given adiciono o body do tipo "RequestCidadeNaoListada" alterando os dados
      | cidade           | Cotia         |
      | origemDigital    | {number}4     |
      | siglaEstado      | SP            |
      | versaoAplicativo | {number}4.8.1 |
    And utilizo os headers "CLIENT_ID"
    When faço um post para "/geral/cidade-nao-listada"
    Then recebo a response com status 200

  @NaoInformarOrigemDigital
  Scenario: Não informar origem digital
    Given adiciono o body do tipo "RequestCidadeNaoListada" alterando os dados
      | cidade      | Barueri |
      | siglaEstado | SP      |
    And utilizo os headers "CLIENT_ID"
    When faço um post para "/geral/cidade-nao-listada"
    Then recebo a response com status 400 os dados
      | errors[0].message | Campo obrigatório |

  @NaoInformarEstado
  Scenario: Nao informar o Estado
    Given adiciono o body do tipo "RequestCidadeNaoListada" alterando os dados
      | cidade        | Barueri   |
      | origemDigital | {number}4 |
    And utilizo os headers "CLIENT_ID"
    When faço um post para "/geral/cidade-nao-listada"
    Then recebo a response com status 400 os dados
      | errors[0].message | Campo obrigatório com o tamanho máximo de 2 caracteres |

  @InformarEstadoErrado
  Scenario: Informar a sigla do Estado incorreta
    Given adiciono o body do tipo "RequestCidadeNaoListada" alterando os dados
      | cidade        | Barueri   |
      | origemDigital | {number}4 |
      | siglaEstado   | VR        |
    And utilizo os headers "CLIENT_ID"
    When faço um post para "/geral/cidade-nao-listada"
    Then recebo a response com status 400 os dados
      | errors[0].message | Valor do campo inválido, exemplo: AM, PA, SP |

  @NaoInformarCidade
  Scenario: Nao informar a cidade
    Given adiciono o body do tipo "RequestCidadeNaoListada" alterando os dados
      | origemDigital | {number}4 |
      | siglaEstado   | SP        |
    And utilizo os headers "CLIENT_ID"
    When faço um post para "/geral/cidade-nao-listada"
    Then recebo a response com status 400 os dados
      | errors[0].message | Campo obrigatório com o tamanho máximo de 40 caracteres |

  @AddCidadeMaisDe40Caracteres
  Scenario: Adicionar cidade com mais de 40 caracteres
    Given adiciono o body do tipo "RequestCidadeNaoListada" alterando os dados
      | cidade        | iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii |
      | origemDigital | {number}4                                 |
      | siglaEstado   | SP                                        |
    And utilizo os headers "CLIENT_ID"
    When faço um post para "/geral/cidade-nao-listada"
    Then recebo a response com status 400 os dados
      | errors[0].message | Campo obrigatório com o tamanho máximo de 40 caracteres |

  @ListarCidade
  Scenario: Listar cidade
    Given adiciono o body do tipo "RequestListaCidade"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | siglaEstado     | AM        |
      | estado          | Amazonas  |
      | idOrigemDigital | {number}6 |
    When faço um get para "/geral/lista-cidade"
    Then recebo a response com status 200

  @ListarCidadeNull
  Scenario: Listar cidade com todos os dados null
    Given adiciono o body do tipo "RequestListaCidade"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | siglaEstado     | null |
      | estado          | null |
      | idOrigemDigital | null |
    When faço um get para "/geral/lista-cidade"
    Then recebo a response com status 400

  @ListarCidadeComSiglaEstadoNull
  Scenario: Listar cidade sem informar sigla do Estado
    Given adiciono o body do tipo "RequestListaCidade"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | siglaEstado     | null      |
      | estado          | Amazonas  |
      | idOrigemDigital | {number}6 |
    When faço um get para "/geral/lista-cidade"
    Then recebo a response com status 400 os dados
      | errors[0].message | Valor do campo inválido, exemplo: AM, PA, SP |

  @ListarCidadeComEstadoNull
  Scenario: Listar cidade sem informar Estado
    Given adiciono o body do tipo "RequestListaCidade"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | siglaEstado     | AM        |
      | estado          | null      |
      | idOrigemDigital | {number}6 |
    When faço um get para "/geral/lista-cidade"
    Then recebo a response com status 400 os dados
      | errors[0].message | Valor do campo inválido, exemplo: Amazonas, Espírito Santo, São Paulo, Paraná |

  @ListarCidadeSemOrigemDigital
  Scenario: Listar cidade sem informar IdOrigemDigital
    Given adiciono o body do tipo "RequestListaCidade"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | siglaEstado     | AM       |
      | estado          | Amazonas |
      | idOrigemDigital | null     |
    When faço um get para "/geral/lista-cidade"
    Then recebo a response com status 200

  @ListarCidadeComSiglaEstadoInexistente
  Scenario: Listar cidade informando sigla do estado inexistente
    Given adiciono o body do tipo "RequestListaCidade"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | siglaEstado     | AU        |
      | estado          | Amazonas  |
      | idOrigemDigital | {number}6 |
    When faço um get para "/geral/lista-cidade"
    Then recebo a response com status 400 os dados
      | errors[0].message | Valor do campo inválido, exemplo: AM, PA, SP |

  @ListarCidadeComEstadoInexistente
  Scenario: Listar cidade informando estado inexistente
    Given adiciono o body do tipo "RequestListaCidade"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | siglaEstado     | AM        |
      | estado          | Amazinas  |
      | idOrigemDigital | {number}6 |
    When faço um get para "/geral/lista-cidade"
    Then recebo a response com status 400 os dados
      | errors[0].message | Valor do campo inválido, exemplo: Amazonas, Espírito Santo, São Paulo, Paraná |

  @ListarCidadeComOrigemDigitalInexistente
  Scenario: Listar cidade informando OrigemDigital inexistente
    Given adiciono o body do tipo "RequestListaCidade"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | siglaEstado     | AM          |
      | estado          | Amazonas    |
      | idOrigemDigital | {number}156 |
    When faço um get para "/geral/lista-cidade"
    Then recebo a response com status 200



