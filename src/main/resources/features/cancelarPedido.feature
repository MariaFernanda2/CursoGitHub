@CancelarPedido
Feature: Cancelar pedido

  Scenario: Cancelar pedido
    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    |  {number}168071  |
      | idOrigem    | {number}6        |
      | idPrestador | {number}1324     |
      | situacao    | CanceladoCliente |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200