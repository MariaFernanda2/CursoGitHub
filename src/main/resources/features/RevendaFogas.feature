@RevendasFogas
Feature: Buscar informações da revenda

  @BuscarInformacoesRevenda
  Scenario: Buscar informações da revenda com todos os dados null
    Given adiciono o body do tipo "RequestRevenda"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | codigoRevenda | null |
      | celular       | null |
      | cnpj          | null |
      | maisInfo      | null |
    When faço um get para "/revenda"
    Then recebo a response com status 400 os dados
      | errors[0].message | Escolha o parâmetro codigoRevenda ou celular ou cnpj |

  @BuscarInformacoesRevendaCodigoInvalido
  Scenario: Buscar informações da revenda informando codigo revenda invalido
    Given adiciono o body do tipo "RequestRevenda"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | codigoRevenda | {number}12 |
    When faço um get para "/revenda"
    Then recebo a response com status 404 os dados
      | message | Não foi possível encontrar a revenda informada! |

  @BuscarInformacoesRevendaCelularInvalido
  Scenario: Buscar informações da revenda informando celular invalido
    Given adiciono o body do tipo "RequestRevenda"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | celular | {number}1234 |
    When faço um get para "/revenda"
    Then recebo a response com status 400 os dados
      | errors[0].message | o telefone deve ser no formato 99999999999, sem 55 |

  @BuscarInformacoesRevendaCnpjInvalido
  Scenario: Buscar informações da revenda informando cnpj invalido
    Given adiciono o body do tipo "RequestRevenda"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | cnpj | {number}1234 |
    When faço um get para "/revenda"
    Then recebo a response com status 400 os dados
      | errors[0].message | Número do CNPJ inválido |

  @BuscarInformacoesRevendaCodigo
  Scenario: Buscar informações da revenda informando codigo revenda
    Given adiciono o body do tipo "RequestRevenda"
    And utilizo os headers "CLIENT_ID"
    And adiciono os queryParams
      | codigoRevenda | {number}108598 |
    When faço um get para "/revenda"
    Then recebo a response com status 200