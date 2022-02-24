@PedidoCompleto
Feature: Pedido completo

  @PedidoCompletoCaminhoFeliz
  Scenario: Pedido completo - caminho feliz
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Vila Buriti          |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | {number}335638       |
      | cliente.idEndereco  | {number}327695       |
      | cliente.latitude    | {number}-3.14249561  |
      | cliente.longitude   | {number}-59.95363109 |
      | cliente.rua         | Rua Rio Quixito      |
      | cliente.siglaEstado | AM                   |
      | idOrigem            | {number}6            |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200

    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | 11942391453          |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}216          |
      | dadosPedido.troco                    | {number}0            |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |

    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 200
    And salvo os dados da response
      | VarIdPedido | idPedido |
#    And espero 60000 milissegundos

    And adiciono o body do tipo "RequestItensPedido"
    And adiciono os pathParams
      | idPedido    | {storage}VarIdPedido |
    And faço um get para "/qa/itens-pedido/{idPedido}"
    And recebo a response com status 200

    And espero 20000 milissegundos
    And adiciono o body do tipo "RequestNotificacoesPedido"
    And faço um get para "/qa/notificacoes/{idPedido}"
    And recebo a response com status 200

    And adiciono o body do tipo "RequestAtualizaPedido"
    And removo todos os pathParams
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1334         |
      | situacao    | Aceito               |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200

    And adiciono o body do tipo "RequestAtualizaPedido"
    And adiciono os queryParams
      | idPedido1    | {storage}VarIdPedido |
      | idOrigem1    | {number}6            |
      | idPrestador1 | {number}1334         |
      | situacao1    | Acaminho             |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200

    And adiciono o body do tipo "RequestAtualizaPedido"
    And adiciono os queryParams
      | idPedido2    | {storage}VarIdPedido |
      | idOrigem2    | {number}6            |
      | idPrestador2 | {number}1334         |
      | situacao2    | Concluido            |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200

    And adiciono o body do tipo "RequestAvaliaPedido"
    And adiciono os queryParams
      | idPedido            | {storage}VarIdPedido |
      | nota                | {number}1            |
      | respostaTempo       | {number}1            |
      | respostaAtendimento | {number}1            |
      | respostaValor       | {number}1            |
    And faço um put para "/pedido/avalia-pedido"
    And recebo a response com status 200

  @PedidoCompletoComTaxaDeEntrega
  Scenario: Pedido completo informando taxa de entrega
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Vila Buriti          |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | {number}335638       |
      | cliente.idEndereco  | {number}327695       |
      | cliente.latitude    | {number}-3.14249561  |
      | cliente.longitude   | {number}-59.95363109 |
      | cliente.rua         | Rua Rio Quixito      |
      | cliente.siglaEstado | AM                   |
 #    | codigoRevenda       | {number}108598       |
      | idOrigem            | {number}6            |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | 11942391453          |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}218          |
      | dadosPedido.troco                    | {number}0            |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}2            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Taxa de entrega não aplicada para pedido completo |

  @PedidoCompletoComDesconto
  Scenario: Pedido completo informando desconto
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Vila Buriti          |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | {number}335638       |
      | cliente.idEndereco  | {number}327695       |
      | cliente.latitude    | {number}-3.14249561  |
      | cliente.longitude   | {number}-59.95363109 |
      | cliente.rua         | Rua Rio Quixito      |
      | cliente.siglaEstado | AM                   |
      | idOrigem            | {number}6            |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | 11942391453          |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}213          |
      | dadosPedido.troco                    | {number}0            |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}3.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Desconto não aplicado para pedido completo |

  @PedidoCompletoEnderecoForaRaioEntrega #Preciso de um endereço que a fogas nao atende
  Scenario: Pedido completo para endereco fora do raio de entrega
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335705     |
      | dadosCliente.idEndereco              | {number}327658     |
      | dadosCliente.latitude                | {number}-9.9400463 |
      | dadosCliente.longitude               | {number}-67.796724 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda                         | null               |
      | dadosPedido.retiradaNaRevenda        | false              |
      | dadosPedido.tempoMinimoEntrega       | {number}15         |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30    |
      | dadosPedido.tempoMaximoEntrega       | {number}30         |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO    |
      | dadosPedido.total                    | {number}216        |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | itensPedido[0].valorVasilhame        | {number}120        |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}13         |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.taxaEntrega            | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Revenda não encontrada para o endereço informado |

  @PedidoCompletoComMaisDeCincoBotijas
  Scenario: Pedido completo com mais de 5 botijas
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Vila Buriti          |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | {number}335638       |
      | cliente.idEndereco  | {number}327695       |
      | cliente.latitude    | {number}-3.14249561  |
      | cliente.longitude   | {number}-59.95363109 |
      | cliente.rua         | Rua Rio Quixito      |
      | cliente.siglaEstado | AM                   |
      | idOrigem            | {number}6            |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | 11942391453          |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}1296         |
      | dadosPedido.troco                    | {number}0            |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}6            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}78           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Quantidade máxima de 5 botijas por pedido |

  @PedidoCompletoComKgIncorreto
  Scenario: Pedido completo com kg compra incorreto
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Vila Buriti          |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | {number}335638       |
      | cliente.idEndereco  | {number}327695       |
      | cliente.latitude    | {number}-3.14249561  |
      | cliente.longitude   | {number}-59.95363109 |
      | cliente.rua         | Rua Rio Quixito      |
      | cliente.siglaEstado | AM                   |
      | idOrigem            | {number}6            |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | 11942391453          |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}216          |
      | dadosPedido.troco                    | {number}0            |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}820          |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Valor do campo inválido |

  @PedidoCompletoComProdutoInexistente
  Scenario: Pedido completo com produto inexistente
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Vila Buriti          |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | {number}335638       |
      | cliente.idEndereco  | {number}327695       |
      | cliente.latitude    | {number}-3.14249561  |
      | cliente.longitude   | {number}-59.95363109 |
      | cliente.rua         | Rua Rio Quixito      |
      | cliente.siglaEstado | AM                   |
      | idOrigem            | {number}6            |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | 11942391453          |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}216          |
      | dadosPedido.troco                    | {number}0            |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P1300                |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Produto inexistente, informe um produto válido |

  @PedidoCompletoSemFormaPagamento
  Scenario: Pedido completo sem informar pagamento
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Vila Buriti          |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | {number}335638       |
      | cliente.idEndereco  | {number}327695       |
      | cliente.latitude    | {number}-3.14249561  |
      | cliente.longitude   | {number}-59.95363109 |
      | cliente.rua         | Rua Rio Quixito      |
      | cliente.siglaEstado | AM                   |
      | idOrigem            | {number}6            |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | 11942391453          |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}216          |
      | dadosPedido.troco                    | {number}0            |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | null                 |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Campo obrigatório |

  @PedidoCompletoPagamentoNoPix
  Scenario: Pedido completo com pagamento Pix
    Given adiciono o body do tipo "RequestListarRevenda" alterando os dados
      | cliente.bairro      | Vila Buriti          |
      | cliente.cidade      | manaus               |
      | cliente.idCliente   | {number}335638       |
      | cliente.idEndereco  | {number}327695       |
      | cliente.latitude    | {number}-3.14249561  |
      | cliente.longitude   | {number}-59.95363109 |
      | cliente.rua         | Rua Rio Quixito      |
      | cliente.siglaEstado | AM                   |
 #    | codigoRevenda       | {number}108598       |
      | idOrigem            | {number}6            |
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | 11942391453          |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}216          |
      | dadosPedido.troco                    | {number}0            |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Pix                  |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 200
    And salvo os dados da response
      | VarIdPedido | idPedido |
    And espero 60000 milissegundos
    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1276         |
      | situacao    | Aceito               |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200
    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1276         |
      | situacao    | Acaminho             |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200
    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1276         |
      | situacao    | Concluido            |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200

  @PedidoCompletoMaquininhaCredito
  Scenario: Pedido completo pagamento no crédito maquininha
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda                         | null               |
      | dadosPedido.retiradaNaRevenda        | false              |
      | dadosPedido.tempoMinimoEntrega       | {number}15         |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30    |
      | dadosPedido.tempoMaximoEntrega       | {number}30         |
      | dadosPedido.tipoPedido               | MaquinetaCredito   |
      | dadosPedido.total                    | {number}216        |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | itensPedido[0].valorVasilhame        | {number}120        |
      | dadosPagamento.formaPagamento        | MaquinetaCredito   |
      | dadosFidelidade.pontosCompra         | {number}13         |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.taxaEntrega            | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 200
    And salvo os dados da response
      | VarIdPedido | idPedido |
    And espero 60000 milissegundos
    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1276         |
      | situacao    | Aceito               |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200
    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1276         |
      | situacao    | Acaminho             |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200
    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1276         |
      | situacao    | Concluido            |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200

  @PedidoCompletoMaquininhaDebito
  Scenario: Pedido completo pagamento no crédito maquininha
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda                         | null               |
      | dadosPedido.retiradaNaRevenda        | false              |
      | dadosPedido.tempoMinimoEntrega       | {number}15         |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30    |
      | dadosPedido.tempoMaximoEntrega       | {number}30         |
      | dadosPedido.tipoPedido               | MaquinetaCredito   |
      | dadosPedido.total                    | {number}216        |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | itensPedido[0].valorVasilhame        | {number}120        |
      | dadosPagamento.formaPagamento        | MaquinetaDebito    |
      | dadosFidelidade.pontosCompra         | {number}13         |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.taxaEntrega            | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 200
    And salvo os dados da response
      | VarIdPedido | idPedido |
    And espero 60000 milissegundos
    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1276         |
      | situacao    | Aceito               |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200
    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1276         |
      | situacao    | Acaminho             |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200
    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1276         |
      | situacao    | Concluido            |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200

  @PedidoCompletoPagamentoInvalido
  Scenario: Pedido completo com pagamento inválido
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda                         | null               |
      | dadosPedido.retiradaNaRevenda        | false              |
      | dadosPedido.tempoMinimoEntrega       | {number}15         |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30    |
      | dadosPedido.tempoMaximoEntrega       | {number}30         |
      | dadosPedido.tipoPedido               | MaquinetaCredito   |
      | dadosPedido.total                    | {number}216        |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | itensPedido[0].valorVasilhame        | {number}120        |
      | dadosPagamento.formaPagamento        | Cheque             |
      | dadosFidelidade.pontosCompra         | {number}13         |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.taxaEntrega            | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Valor do campo inválido, exemplo: Dinheiro,CartaoNoAplicativo,MaquinetaCredito,MaquinetaDebito,Pix |

  @PedidoCompletoSemIdEndereco
  Scenario: Pedido completo sem informar IdEndereco
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | null                 |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | 11942391453          |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}216          |
      | dadosPedido.troco                    | {number}0            |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Campo obrigatório |

  @PedidoCompletoIdEnderecoInexistente
  Scenario: Pedido completo com IdEndereco inexistente
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | 0101010101           |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | 11942391453          |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}216          |
      | dadosPedido.troco                    | {number}0            |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | IdEndereco inexistente |

  @PedidoCompletoSemLatitudeLongitude
  Scenario: Pedido completo sem informar latitude e longitude
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false     |
      | dadosCliente.idCliente               | {number}335638  |
      | dadosCliente.idEndereco              | 0101010101      |
      | dadosCliente.latitude                | null            |
      | dadosCliente.longitude               | null            |
      | dadosCliente.telefoneCliente         | 11942391453     |
      | dadosCliente.distanciaRevendaCliente | {number}4.3     |
      | dadosRevenda                         | null            |
      | dadosPedido.retiradaNaRevenda        | false           |
      | dadosPedido.tempoMinimoEntrega       | {number}15      |
      | dadosPedido.observacao               | Gostei muito    |
      | dadosPedido.origem                   | {number}6       |
      | dadosPedido.recebedorPedido          | Ana maia        |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30 |
      | dadosPedido.tempoMaximoEntrega       | {number}30      |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO |
      | dadosPedido.total                    | {number}216     |
      | dadosPedido.troco                    | {number}0       |
      | dadosPedido.versaoApp                | {number}4.5     |
      | itensPedido[0].marca                 | Fogas           |
      | itensPedido[0].preco                 | {number}96.0    |
      | itensPedido[0].produto               | P13             |
      | itensPedido[0].quantidade            | {number}1       |
      | itensPedido[0].quilos                | {number}13.0    |
      | itensPedido[0].valorVasilhame        | {number}120     |
      | dadosPagamento.formaPagamento        | Dinheiro        |
      | dadosFidelidade.pontosCompra         | {number}13      |
      | dadosFidelidade.quilosCompra         | {number}13      |
      | taxasDesconto.descontoFidelidade     | {number}0       |
      | taxasDesconto.taxaEntrega            | {number}0       |
      | taxasDesconto.descontoRevenda        | {number}0.0     |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Campo obrigatório |

  @PedidoCompletoComUsuarioInexistente
  Scenario: Pedido completo sem informar o idCliente
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | null               |
      | dadosCliente.idEndereco              | {number}327695     |
      | dadosCliente.latitude                | {number}-01.010101 |
      | dadosCliente.longitude               | {number}-01.010101 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda                         | null               |
      | dadosPedido.retiradaNaRevenda        | false              |
      | dadosPedido.tempoMinimoEntrega       | {number}15         |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30    |
      | dadosPedido.tempoMaximoEntrega       | {number}30         |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO    |
      | dadosPedido.total                    | {number}216        |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | itensPedido[0].valorVasilhame        | {number}120        |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}13         |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.taxaEntrega            | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Campo obrigatório |

  @PedidoCompletoSemTelefoneCliente
  Scenario: Pedido completo sem informar telefone do cliente
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | null                 |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}216          |
      | dadosPedido.troco                    | {number}0            |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Campo obrigatório |

  @PedidoCompletoTelefoneClienteSemDDD
  Scenario: Pedido completo informando telefone do cliente sem DDD
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | null                 |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}216          |
      | dadosPedido.troco                    | {number}0            |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Telefone inválido, informe o DDD |

  @PedidoCompletoTelefoneClienteSemNonoDigito
  Scenario: Pedido completo informando telefone do cliente sem nono digito
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | 42391453             |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}216          |
      | dadosPedido.troco                    | {number}0            |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Telefone inválido, informe nono dígito |

  @PedidoCompletoTelefoneClienteApenasCaracteresEspeciais
  Scenario: Pedido completo informando telefone do cliente apenas com caracteres especiais
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | @@@@@@@@             |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}216          |
      | dadosPedido.troco                    | {number}0            |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Telefone inválido, informe um número de telefone válido |

  @PedidoCompletoTrocoMenorQuePreco
  Scenario: Pedido de entrega com troco menor que o valor total do pedido
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | 11942391453          |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}216          |
      | dadosPedido.troco                    | {number}200          |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | O troco não pode ser menor que o valor total do pedido |

  @PedidoCompletoTrocoMenorQuePreco
  Scenario: Pedido de entrega total de 216 reais com troco maior de 500 reais
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | 11942391453          |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}216          |
      | dadosPedido.troco                    | {number}500          |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Troco sugerido: 220 Reais, 250 Reais ou 300 Reais |

  @PedidoCompletoMesmoValorCompra
  Scenario: Pedido de entrega com o troco no mesmo valor da compra
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | 11942391453          |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}216          |
      | dadosPedido.troco                    | {number}216          |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | O troco não pode ser no mesmo valor da compra |

  @PedidoCompletoValorTotalIncorreto
  Scenario: Pedido completo com o valor total incorreto
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | 11942391453          |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}216          |
      | dadosPedido.troco                    | {number}0            |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}2            |
      | itensPedido[0].quilos                | {number}26.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Valor total do pedido incorreto |

  @PedidoCompletoCanceladoCliente
  Scenario: Pedido completo cancelado pelo cliente
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | 11942391453          |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}216          |
      | dadosPedido.troco                    | {number}0            |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 200
    And salvo os dados da response
      | VarIdPedido | idPedido |
    And espero 60000 milissegundos
    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1276         |
      | situacao    | CanceladoCliente     |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200

  @PedidoCompletoCanceladoPrestador
  Scenario: Pedido completo cancelado pelo entregador
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | 11942391453          |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}216          |
      | dadosPedido.troco                    | {number}0            |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 200
    And salvo os dados da response
      | VarIdPedido | idPedido |
    And espero 60000 milissegundos
    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1276         |
      | situacao    | CanceladoPrestador   |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200

  @PedidoCompletoPrestadorIndisponivel
  Scenario: Pedido completo prestador indisponivel
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false          |
      | dadosCliente.idCliente               | {number}335638       |
      | dadosCliente.idEndereco              | {number}327695       |
      | dadosCliente.latitude                | {number}-3.14249561  |
      | dadosCliente.longitude               | {number}-59.95363109 |
      | dadosCliente.telefoneCliente         | 11942391453          |
      | dadosCliente.distanciaRevendaCliente | {number}4.3          |
      | dadosRevenda                         | null                 |
      | dadosPedido.retiradaNaRevenda        | false                |
      | dadosPedido.tempoMinimoEntrega       | {number}15           |
      | dadosPedido.observacao               | Gostei muito         |
      | dadosPedido.origem                   | {number}6            |
      | dadosPedido.recebedorPedido          | Ana maia             |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30      |
      | dadosPedido.tempoMaximoEntrega       | {number}30           |
      | dadosPedido.tipoPedido               | PEDIDO_COMPLETO      |
      | dadosPedido.total                    | {number}216          |
      | dadosPedido.troco                    | {number}0            |
      | dadosPedido.versaoApp                | {number}4.5          |
      | itensPedido[0].marca                 | Fogas                |
      | itensPedido[0].preco                 | {number}96.0         |
      | itensPedido[0].produto               | P13                  |
      | itensPedido[0].quantidade            | {number}1            |
      | itensPedido[0].quilos                | {number}13.0         |
      | itensPedido[0].valorVasilhame        | {number}120          |
      | dadosPagamento.formaPagamento        | Dinheiro             |
      | dadosFidelidade.pontosCompra         | {number}13           |
      | dadosFidelidade.quilosCompra         | {number}13           |
      | taxasDesconto.descontoFidelidade     | {number}0            |
      | taxasDesconto.taxaEntrega            | {number}0            |
      | taxasDesconto.descontoRevenda        | {number}0.0          |
    And utilizo os headers "AUTH_ID"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And faço um post para "/pedido"
    And recebo a response com status 200
    And salvo os dados da response
      | VarIdPedido | idPedido |
    And espero 60000 milissegundos
    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1276         |
      | situacao    | Aceito               |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Prestador impossibilitado de aceitar pedido. Encontra-se não disponível. |

