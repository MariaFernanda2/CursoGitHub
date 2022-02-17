@PedidosFogas
Feature: Listar pedido

@ListarPedido
Scenario: Listar pedido
Given adiciono o body do tipo "RequestPedido"
And utilizo os headers "AUTH_ENUM"
And adiciono os queryParams
| idOrigemDigital | 6      |
| idCliente       | 335644 |
When faço um get para "/pedido"
Then recebo a response com status 200

@ListarPedidoIdClienteinexistente
Scenario: Listar pedido com Id cliente inexistente
Given adiciono o body do tipo "RequestPedido"
And utilizo os headers "AUTH_ENUM"
And adiciono os queryParams
| idPedido        | 16728 |
| idOrigemDigital | 6     |
| idCliente       | 33564 |
When faço um get para "/pedido"
Then recebo a response com status 200

@ListarPedidoIdPedidoInexistente
Scenario: Listar pedido com Id pedido inexistente
Given adiciono o body do tipo "RequestPedido"
And utilizo os headers "AUTH_ENUM"
And adiciono os queryParams
| idPedido        | 123456789 |
| idOrigemDigital | 6         |
| idCliente       | 335644    |
When faço um get para "/pedido"
Then recebo a response com status 400

@ListarPedidoComOrigemDigitalInexistente
Scenario: Listar pedido com origem digital inexistente
Given adiciono o body do tipo "RequestPedido"
And utilizo os headers "AUTH_ENUM"
And adiciono os queryParams
| idPedido        | 123456789 |
| idOrigemDigital | 325       |
| idCliente       | 335644    |
When faço um get para "/pedido"
Then recebo a response com status 400

@ListarPedidoNull
Scenario: Listar pedido com os parametros null
Given adiciono o body do tipo "RequestPedido"
And utilizo os headers "AUTH_ENUM"
And adiciono os queryParams
| idPedido        | null |
| idOrigemDigital | null |
| idCliente       | null |
When faço um get para "/pedido"
Then recebo a response com status 422