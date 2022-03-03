@PedidosFogasDeEntrega
Feature: Realizar pedidos fogas entrega

  @PedidoDeEntregaCaminhoFeliz
  Scenario: Pedido de entrega
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}98            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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
    And limpo o objeto de requisicao

    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1276         |
      | situacao    | Acaminho             |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200
    And limpo o objeto de requisicao

    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1276         |
      | situacao    | Concluido            |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200
    And adiciono o body do tipo "RequestAvaliaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido            | {storage}VarIdPedido |
      | nota                | {number}1            |
      | respostaTempo       | {number}1            |
      | respostaAtendimento | {number}1            |
      | respostaValor       | {number}1            |
    And faço um put para "/pedido/avalia-pedido"
    And recebo a response com status 200

  @PedidoDeEntregaSemIdEndereco
  Scenario: Pedido de entrega sem informar IdEndereco
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | null                  |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}75            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}75.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}2             |
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

  @PedidoDeEntregaIdEnderecoInexistente
  Scenario: Pedido de entrega com IdEndereco inexistente
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | 0101010101            |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}75            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}75.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}2             |
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

  @PedidoDeEntregaSemLatitudeLongitude
  Scenario: Pedido de entrega sem informar latitude e longitude
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | null                  |
      | dadosCliente.longitude               | null                  |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}75            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}75.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}2             |
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

  @PedidoDeEntregaComLatitudeLongitudeInvalidas
  Scenario: Pedido de entrega com latitude e longitude inválidas
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-01.010101    |
      | dadosCliente.longitude               | {number}-01.010101    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}75            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}75.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}2             |
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
      | errors[0].message | Latitude e longitude inválidas |

  @PedidoDeEntregaComUsuarioInexistente
  Scenario: Pedido de entrega sem informar o idCliente
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | null                  |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}75            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}75.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}2             |
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

  @PedidoDeEntregaSemTelefoneCliente
  Scenario: Pedido de entrega sem informar telefone do cliente
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | null                  |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}75            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}75.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}2             |
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

  @PedidoDeEntregaTelefoneClienteSemDDD
  Scenario: Pedido de entrega informando telefone do cliente sem DDD
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 942391453             |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}75            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}75.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}2             |
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

  @PedidoDeEntregaTelefoneClienteSemNonoDigito
  Scenario: Pedido de entrega informando telefone do cliente sem nono digito
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 42391453              |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}75            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}75.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}2             |
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

  @PedidoDeEntregaTelefoneClienteApenasCaracteresEspeciais
  Scenario: Pedido de entrega informando telefone do cliente apenas com caracteres especiais
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | @@@@@@@@              |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}75            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}75.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}2             |
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

  @PedidoDeEntregaDescontoMaiorQueValorTotal
  Scenario: Pedido de entrega com desconto maior que o valor total do pedido
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}75            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}75.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}200           |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}200           |
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
      | errors[0].message | O desconto não pode ser maior que o valor total do pedido |

  @PedidoDeEntregaDescontoIncorreto
  Scenario: Adicionar apenas 1 botija e informar desconto - R$ 3,00 de desconto por botija adicional
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
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200
  #   And salvo os dados da response
  #    | VarDesconto | promocaoRevenda.valorOferta |
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}93            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}0             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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
      | errors[0].message | Desconto não aplicado, adicione mais uma botija para obter o desconto |

  @PedidoDeEntregaComTaxaEntregaMaiorQueValorBotija
  Scenario: Pedido de entrega com taxa de entrega inválida
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
      | versaoApp           | {number}4.8.1        |
    And utilizo os headers "CLIENT_ID"
    When faço um put para "/revenda/listar"
    Then recebo a response com status 200
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}196           |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}100           |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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
      | errors[0].message | A taxa de entrega não corresponde ao valor da revenda escolhida |

  @PedidoDeEntregaRevendaInexistente
  Scenario: Pedido de entrega revenda inexistente
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.nomeRevenda             | Inexistente        |
      | dadosRevenda.revendaEscolhida        | {number}0101010101 |
      | dadosPedido.retiradaNaRevenda        | false              |
      | dadosPedido.tempoMinimoEntrega       | {number}15         |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30    |
      | dadosPedido.tempoMaximoEntrega       | {number}30         |
      | dadosPedido.tipoPedido               | PedidoGas          |
      | dadosPedido.total                    | {number}75         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}75.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}13         |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.taxaEntrega            | {number}2          |
      | taxasDesconto.descontoRevenda        | {number}2          |
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
      | errors[0].message | Revenda não encontrado(a) com o valor 101010101 |

  @PedidoDeEntregaRevendaFechada
  Scenario: Pedido de entrega revenda fechada
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}14192      |
      | dadosPedido.retiradaNaRevenda        | false              |
      | dadosPedido.tempoMinimoEntrega       | {number}15         |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30    |
      | dadosPedido.tempoMaximoEntrega       | {number}30         |
      | dadosPedido.tipoPedido               | PedidoGas          |
      | dadosPedido.total                    | {number}75         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}75.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}13         |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.taxaEntrega            | {number}2          |
      | taxasDesconto.descontoRevenda        | {number}2          |
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
      | errors[0].message | A revenda n�o est� mais disponivel! |

  @PedidoDeEntregaTrocoMenorQuePreco
  Scenario: Pedido de entrega com troco menor que o valor total do pedido
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}96            |
      | dadosPedido.troco                    | {number}50            |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}0             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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

  @PedidoDeEntregaTrocoMaiorDe200
  Scenario: Pedido de entrega de 1 produto de 96 reais com troco maior de 200 reais
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}96            |
      | dadosPedido.troco                    | {number}300           |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}0             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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
      | errors[0].message | O troco não pode ser maior de 200 Reais |

  @PedidoDeEntregaMesmoValorCompra
  Scenario: Pedido de entrega com o troco no mesmo valor da compra
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}96            |
      | dadosPedido.troco                    | {number}96            |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}0             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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

  @PedidoDeEntregaTrocoParaNumerosComCentavos
  Scenario: Pedido de entrega de R$100 com troco para R$99,99
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}100           |
      | dadosPedido.troco                    | {number}99.99         |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}100.0         |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}2             |
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

  @PedidoDeEntregaValorTotalIncorreto
  Scenario: Pedido de entrega com o valor total incorreto
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}750           |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}75.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}1             |
      | taxasDesconto.descontoRevenda        | {number}2.0           |
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

  @PedidoDeEntregaTipoPedidoInvalido
  Scenario: Pedido de entrega com tipoPedido inválido
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoAguaGalao       |
      | dadosPedido.total                    | {number}98            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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
      | errors[0].message | Valor do campo inválido, exemplo: PedidoGas, PedidoGasPortaria, PEDIDO_COMPLETO,PEDIDO_ECONOMICO |

  @PedidoDeEntregaMaisDeCincoProdutos
  Scenario: Pedido de entrega com mais de 5 produtos
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}752           |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}75.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}10            |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}130           |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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

  @PedidoDeEntregaKgIncorreto
  Scenario: Pedido de entrega com os kg compra incorreto
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}98            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}50.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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

  @PedidoDeEntregaComProdutoInexistente
  Scenario: Pedido de entrega com produto inexistente
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}98            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P230                  |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}230.0         |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}0             |
      | dadosFidelidade.quilosCompra         | {number}230           |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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

  @PedidoDeEntregaForaDoRaioDaRevenda
  Scenario: Pedido de entrega para cliente fora do raio de entrega da revenda
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335705        |
      | dadosCliente.idEndereco              | {number}327658        |
      | dadosCliente.latitude                | {number}-9.9400463    |
      | dadosCliente.longitude               | {number}-67.796724    |
      | dadosCliente.telefoneCliente         | 11995019550           |
      | dadosCliente.distanciaRevendaCliente | {number}200.0         |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}98            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}0             |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
    And utilizo os headers "AUTH_RAIO"
    When faço um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_RAIO2"
    And faço um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Endereço fora do raio de entrega da revenda |

  @PedidoDeEntregaSemFormaPagamento
  Scenario: Pedido de entrega sem informar pagamento
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}98            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | null                  |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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

  @PedidoDeEntregaMaquininhaCredito
  Scenario: Pedido de entrega pagamento no crédito maquininha
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}75            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}75.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | MaquinetaCredito      |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}2             |
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

  @PedidoDeEntregaMaquininhaDebito
  Scenario: Pedido de entrega pagamento no débito maquininha
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}75            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}75.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | MaquinetaDebito       |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}2             |
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

  @PedidoDeEntregaPagamentoInvalido
  Scenario: Pedido de entrega com pagamento inválido
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}75            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}75.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Cheque                |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}2             |
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

  @PedidoDeEntregaRevendaFechadaHorario
  Scenario: Pedido de entrega com revenda fechada pelo horário
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}14426      |
      | dadosPedido.retiradaNaRevenda        | false              |
      | dadosPedido.tempoMinimoEntrega       | {number}15         |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30    |
      | dadosPedido.tempoMaximoEntrega       | {number}30         |
      | dadosPedido.tipoPedido               | PedidoGas          |
      | dadosPedido.total                    | {number}75         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}75.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}13         |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.taxaEntrega            | {number}2          |
      | taxasDesconto.descontoRevenda        | {number}2          |
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
      | errors[0].message | A revenda n�o est� mais disponivel! |

  @PedidoDeEntregaParaClientePedidoAndamento
  Scenario: Pedido de entrega para cliente que tem um pedido em andamento
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}75            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}75.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}2             |
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
      | errors[0].message | Você tem um pedido em andamento. Para fazer um novo pedido, conclua ou cancele este pedido |

  @PedidoDeEntregaCanceladoCliente
  Scenario: Pedido de entrega cancelado pelo cliente
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}75            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}75.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}2             |
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
      | idPrestador | {number}1324         |
      | situacao    | CanceladoCliente     |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200

  @PedidoDeEntregaCanceladoPrestador
  Scenario: Pedido de entrega cancelado pelo entregador
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}75            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}75.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}2             |
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
      | idPrestador | {number}1324         |
      | situacao    | CanceladoPrestador   |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200

  @CancelarPedidoJaCancelado
  Scenario: Cancelar pedido que já foi cancelado
    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido      | {number}168071   |
      | codigoRevenda | {number}10013    |
      | idOrigem      | {number}6        |
      | idPrestador   | {number}1324     |
      | situacao      | CanceladoCliente |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Não é possível cancelar pedido que já foi cancelado |

  @AlterarStatusDeUmPedidoCancelado
  Scenario: Alterar status de um pedido cancelado
    And adiciono o body do tipo "RequestAtualizaPedido"
    And removo todos os queryParams
    And adiciono os queryParams
      | idPedido    | {number}168071      |
      | idOrigem    | {number}6           |
      | idPrestador | {number}1324        |
      | situacao    | AguardandoSerAceito |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Não é possível alterar status de um pedido cancelado |

  @PedidoDeEntrega
  Scenario: Alterar status de um pedido concluído
    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {number}168071      |
      | idOrigem    | {number}6           |
      | idPrestador | {number}1324        |
      | situacao    | AguardandoSerAceito |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Não é possível alterar status de um pedido concluído |

  @PedidoDeEntregaEstoqueFogasLog
  Scenario: Pedido de entrega - ESTOQUE FOGAS LOG
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}98            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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
    And limpo o objeto de requisicao

    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1276         |
      | situacao    | Acaminho             |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200
    And limpo o objeto de requisicao

    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1276         |
      | situacao    | Concluido            |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200

  @PedidoDeEntregaEntregadorProprio
  Scenario: Pedido de entrega - ENTREGADOR PROPRIO
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}98            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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

  @PedidoDeEntregaPrestadorInexistente
  Scenario: Pedido de entrega com Id prestador inexistente
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}98            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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
      | idPrestador | {number}132456       |
      | tipoEntrega | ENTREGADOR_PROPRIO   |
      | situacao    | Aceito               |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 400 os dados
      | errors.message | PrestadorId = 132456 não encontrado |

  @PedidoDeEntregaPrestadorNaoDisponivel
  Scenario: Pedido de entrega com prestador não disponível
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}98            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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
      | idPrestador | {number}132456       |
      | tipoEntrega | ENTREGADOR_PROPRIO   |
      | situacao    | Aceito               |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 400 os dados
      | errors.message | Prestador impossibilitado de aceitar pedido. Encontra-se não disponível. |

  @PedidoDeEntregaIdPedidoNull
  Scenario: Pedido de entrega com idPedido null
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}98            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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
      | idPedido    | null         |
      | idOrigem    | {number}6    |
      | idPrestador | {number}1324 |
      | situacao    | Concluido    |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 400 os dados
      | errors.message | Valor do campo inválido |

  @PedidoDeEntregaIdOrigemNull
  Scenario: Pedido de entrega com idOrigem null
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}98            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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
      | idOrigem    | null                 |
      | idPrestador | {number}1324         |
      | situacao    | Concluido            |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 400 os dados
      | [0].errors.message | Valor do campo inválido |


  @PedidoDeEntregaIdPrestadorNull
  Scenario: Pedido de entrega com idPrestador null
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}98            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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
      | idPrestador | null                 |
      | situacao    | Concluido            |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 400 os dados
      | [0].errors.message | Valor do campo inválido |

  @PedidoDeEntregaSituacaoNull
  Scenario: Pedido de entrega com situacao null
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}98            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Dinheiro              |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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
      | idPrestador | {number}1324         |
      | situacao    | null                 |
    And faço um put para "/pedido/atualiza-pedido"
    And recebo a response com status 400 os dados
      | errors.message | Valor do campo inválido |

  @PedidoDeEntregaBotijaEmFalta
  Scenario: Botija em falta
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}10013      |
      | dadosRevenda.idPrestador             | {number}0          |
      | dadosPedido.retiradaNaRevenda        | false              |
      | dadosPedido.tempoMinimoEntrega       | {number}15         |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30    |
      | dadosPedido.tempoMaximoEntrega       | {number}30         |
      | dadosPedido.tipoPedido               | PedidoGas          |
      | dadosPedido.total                    | {number}98         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}13         |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.taxaEntrega            | {number}2          |
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
      | errors.message | Botija indisponível |

  @PedidoDeEntregaComPrecoProdutoIncorreto
  Scenario: Pedido de entrega com preço produto incorreto
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}10013      |
      | dadosRevenda.idPrestador             | {number}0          |
      | dadosPedido.retiradaNaRevenda        | false              |
      | dadosPedido.tempoMinimoEntrega       | {number}15         |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30    |
      | dadosPedido.tempoMaximoEntrega       | {number}30         |
      | dadosPedido.tipoPedido               | PedidoGas          |
      | dadosPedido.total                    | {number}12         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}10.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}13         |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.taxaEntrega            | {number}2          |
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
      | [0].errors.message | Preço botija incorreto |

  @PedidoEntregaPixRevendaNaoAceita
  Scenario: Pedido de entrega pagamento no PIX para revenda que não aceita
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}327567        |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | false                 |
      | dadosPedido.tempoMinimoEntrega       | {number}15            |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tempoEstimadoEntrega     | {number}15 - 30       |
      | dadosPedido.tempoMaximoEntrega       | {number}30            |
      | dadosPedido.tipoPedido               | PedidoGas             |
      | dadosPedido.total                    | {number}98            |
      | dadosPedido.troco                    | {number}0             |
      | dadosPedido.versaoApp                | {number}4.5           |
      | itensPedido[0].marca                 | Fogas                 |
      | itensPedido[0].preco                 | {number}96.0          |
      | itensPedido[0].produto               | P13                   |
      | itensPedido[0].quantidade            | {number}1             |
      | itensPedido[0].quilos                | {number}13.0          |
      | dadosPagamento.formaPagamento        | Pix                   |
      | dadosFidelidade.pontosCompra         | {number}13            |
      | dadosFidelidade.quilosCompra         | {number}13            |
      | taxasDesconto.descontoFidelidade     | {number}0             |
      | taxasDesconto.taxaEntrega            | {number}2             |
      | taxasDesconto.descontoRevenda        | {number}0.0           |
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
      | [0].errors.message | Revenda não aceita Pix, altere a forma de pagamento |