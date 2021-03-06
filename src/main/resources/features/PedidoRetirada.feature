@PedidosFogasDeRetirada
Feature: Realizar pedidos fogas retirada

  @PedidoDeRetirada
  Scenario: Pedido de retirada - caminho feliz
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
      | dadosPedido.retiradaNaRevenda        | true                  |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tipoPedido               | PedidoGasPortaria     |
      | dadosPedido.dataRetirada             | 2022-02-18            |
      | dadosPedido.horaRetiradaInicial      | 08:00:00              |
      | dadosPedido.horaRetiradaFinal        | 18:00:00              |
      | dadosPedido.total                    | {number}96            |
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
      | taxasDesconto.descontoRevenda        | {number}0.0           |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
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
    And fa??o um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200
    And limpo o objeto de requisicao

    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1276         |
      | situacao    | Acaminho             |
    And fa??o um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200
    And limpo o objeto de requisicao

    And adiciono o body do tipo "RequestAtualizaPedido"
    And utilizo os headers "AUTH_ENUM"
    And adiciono os queryParams
      | idPedido    | {storage}VarIdPedido |
      | idOrigem    | {number}6            |
      | idPrestador | {number}1276         |
      | situacao    | Concluido            |
    And fa??o um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200
    And adiciono o body do tipo "RequestAvaliaPedido"
    And adiciono os queryParams
      | idPedido            | {storage}VarIdPedido |
      | nota                | {number}1            |
      | respostaTempo       | {number}1            |
      | respostaAtendimento | {number}1            |
      | respostaValor       | {number}1            |
    And fa??o um put para "/pedido/avalia-pedido"
    And recebo a response com status 200

  @PedidoDeRetiradaSemIdEndereco
  Scenario: Pedido de retirada sem informar IdEndereco
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
      | dadosPedido.retiradaNaRevenda        | true                  |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tipoPedido               | PedidoGasPortaria     |
      | dadosPedido.dataRetirada             | 2022-02-14            |
      | dadosPedido.horaRetiradaInicial      | 08:00:00              |
      | dadosPedido.horaRetiradaFinal        | 12:00:00              |
      | dadosPedido.total                    | {number}96            |
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
      | taxasDesconto.descontoRevenda        | {number}0.0           |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Campo obrigat??rio |

  @PedidoDeRetiradaIdEnderecoInexistente
  Scenario: Pedido de retirada com IdEndereco inexistente
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false           |
      | dadosCliente.idCliente               | {number}335644        |
      | dadosCliente.idEndereco              | {number}0101010101    |
      | dadosCliente.latitude                | {number}-3.3465345    |
      | dadosCliente.longitude               | {number}-60.345236    |
      | dadosCliente.telefoneCliente         | 11942391453           |
      | dadosCliente.distanciaRevendaCliente | {number}4.3           |
      | dadosRevenda.nomeRevenda             | Revenda Antonio Teste |
      | dadosRevenda.revendaEscolhida        | {number}108598        |
      | dadosPedido.retiradaNaRevenda        | true                  |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tipoPedido               | PedidoGasPortaria     |
      | dadosPedido.dataRetirada             | 2022-02-14            |
      | dadosPedido.horaRetiradaInicial      | 08:00:00              |
      | dadosPedido.horaRetiradaFinal        | 12:00:00              |
      | dadosPedido.total                    | {number}96            |
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
      | taxasDesconto.descontoRevenda        | {number}0.0           |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | IdEndereco inexistente |

  @PedidoDeRetiradaSemLatitudeLongitude
  Scenario: Pedido de retirada sem informar latitude e longitude
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
      | dadosPedido.retiradaNaRevenda        | true                  |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tipoPedido               | PedidoGasPortaria     |
      | dadosPedido.dataRetirada             | 2022-02-14            |
      | dadosPedido.horaRetiradaInicial      | 08:00:00              |
      | dadosPedido.horaRetiradaFinal        | 12:00:00              |
      | dadosPedido.total                    | {number}96            |
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
      | taxasDesconto.descontoRevenda        | {number}0.0           |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Campo obrigat??rio |

  @PedidoDeRetiradaComLatitudeLongitudeInvalidas
  Scenario: Pedido de retirada com latitude e longitude inv??lidas
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
      | dadosPedido.retiradaNaRevenda        | true                  |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tipoPedido               | PedidoGasPortaria     |
      | dadosPedido.dataRetirada             | 2022-02-14            |
      | dadosPedido.horaRetiradaInicial      | 08:00:00              |
      | dadosPedido.horaRetiradaFinal        | 12:00:00              |
      | dadosPedido.total                    | {number}96            |
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
      | taxasDesconto.descontoRevenda        | {number}0.0           |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Latitude e longitude inv??lidas |

  @PedidoDeRetiradaComUsuarioInexistente
  Scenario: Pedido de retirada sem informar o idCliente
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
      | dadosPedido.retiradaNaRevenda        | true                  |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tipoPedido               | PedidoGasPortaria     |
      | dadosPedido.dataRetirada             | 2022-02-14            |
      | dadosPedido.horaRetiradaInicial      | 08:00:00              |
      | dadosPedido.horaRetiradaFinal        | 12:00:00              |
      | dadosPedido.total                    | {number}96            |
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
      | taxasDesconto.descontoRevenda        | {number}0.0           |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Campo obrigat??rio |

  @PedidoDeRetiradaSemTelefoneCliente
  Scenario: Pedido de retirada sem informar telefone do cliente
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
      | dadosPedido.retiradaNaRevenda        | true                  |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tipoPedido               | PedidoGasPortaria     |
      | dadosPedido.dataRetirada             | 2022-02-14            |
      | dadosPedido.horaRetiradaInicial      | 08:00:00              |
      | dadosPedido.horaRetiradaFinal        | 12:00:00              |
      | dadosPedido.total                    | {number}96            |
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
      | taxasDesconto.descontoRevenda        | {number}0.0           |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Campo obrigat??rio |

  @PedidoDeRetiradaDescontoMaiorQueValorTotal
  Scenario: Pedido de retirada com desconto maior que o valor total do pedido
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
      | dadosPedido.retiradaNaRevenda        | true                  |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tipoPedido               | PedidoGasPortaria     |
      | dadosPedido.dataRetirada             | 2022-02-14            |
      | dadosPedido.horaRetiradaInicial      | 08:00:00              |
      | dadosPedido.horaRetiradaFinal        | 12:00:00              |
      | dadosPedido.total                    | {number}96            |
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
      | taxasDesconto.descontoRevenda        | {number}200.0         |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | O desconto n??o pode ser maior que o valor total do pedido |

  @PedidoDeRetiradaDescontoIncorreto
  Scenario: Adicionar apenas 1 botija e informar desconto - R$ 3,00 de desconto por botija adicional
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
      | dadosPedido.retiradaNaRevenda        | true                  |
      | dadosPedido.observacao               | Gostei muito          |
      | dadosPedido.origem                   | {number}6             |
      | dadosPedido.recebedorPedido          | Ana maia              |
      | dadosPedido.tipoPedido               | PedidoGasPortaria     |
      | dadosPedido.dataRetirada             | 2022-02-14            |
      | dadosPedido.horaRetiradaInicial      | 08:00:00              |
      | dadosPedido.horaRetiradaFinal        | 12:00:00              |
      | dadosPedido.total                    | {number}96            |
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
      | taxasDesconto.descontoRevenda        | {number}3.0           |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Desconto n??o aplicado, adicione mais uma botija para obter o desconto |

  @PedidoDeRetiradaRevendaFechada
  Scenario: Pedido de retirada revenda fechada
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}14192      |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-14         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}96         |
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
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | A revenda n???o est??? mais disponivel! |

  @PedidoDeRetiradaTrocoMenorQuePreco
  Scenario: Pedido de retirada com troco menor que o valor total do pedido
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-14         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}96         |
      | dadosPedido.troco                    | {number}20         |
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
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | O troco n??o pode ser menor que o valor total do pedido |

  @PedidoDeRetiradaTrocoMaiorDe200
  Scenario: Pedido de retirada de 1 produto de 96 reais com troco maior de 200 reais
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-14         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}96         |
      | dadosPedido.troco                    | {number}300        |
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
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | O troco n??o pode ser maior de 200 Reais |

  @PedidoDeRetiradaMesmoValorCompra
  Scenario: Pedido de retirada com o troco no mesmo valor da compra
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-14         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}96         |
      | dadosPedido.troco                    | {number}96         |
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
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | O troco n??o pode ser no mesmo valor da compra |

  @PedidoDeRetiradaValorTotalIncorreto
  Scenario: Pedido de retirada com o valor total incorreto
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-14         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}96         |
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
      | taxasDesconto.descontoRevenda        | {number}3.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Valor total do pedido incorreto |

  @PedidoDeRetiradaTipoPedidoInvalido
  Scenario: Pedido de retirada com tipoPedido inv??lido
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tipoPedido               | PedidoEmpresa      |
      | dadosPedido.dataRetirada             | 2022-02-14         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}96         |
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
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Valor do campo inv??lido, exemplo: PedidoGas, PedidoGasPortaria, PEDIDO_COMPLETO,PEDIDO_ECONOMICO |

  @PedidoDeRetiradaMaisDeCincoProdutos
  Scenario: Pedido de retirada com mais de 5 produtos
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-14         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}960        |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}10         |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}13         |
      | dadosFidelidade.quilosCompra         | {number}130        |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Quantidade m??xima de 5 botijas por pedido |

  @PedidoDeRetiradaKgIncorreto
  Scenario: Pedido de retirada com os kg compra incorreto
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-14         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}96         |
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
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Valor do campo inv??lido |

  @PedidoDeRetiradaComProdutoInexistente
  Scenario: Pedido de retirada com produto inexistente
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-14         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}96         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P200               |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}200.0      |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}200        |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Produto inexistente, informe um produto v??lido |

  @PedidoDeRetiradaSemFormaPagamento
  Scenario: Pedido de retirada sem informar pagamento
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-14         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}96         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | null               |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Campo obrigat??rio |

  @PedidoDeRetiradaParaClientePedidoAndamento
  Scenario: Pedido de retirada para cliente que tem um pedido em andamento
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | Ana maia           |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-14         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}96         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | errors[0].message | Voc?? tem um pedido em andamento. Para fazer um novo pedido, conclua ou cancele este pedido |

  @PedidoDeRetiradaCanceladoCliente
  Scenario: Pedido de retirada cancelado pelo cliente
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-14         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}96         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
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
    And fa??o um put para "/pedido/atualiza-pedido"
    And recebo a response com status 200

  @PedidoDeRetiradaDataPassado
  Scenario: Pedido de retirada com data retirada no passado
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.recebedorPedido          | null               |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2021-02-14         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}96         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | [0].errors.message | A data de retirada n??o pode ser no passado |

  @PedidoDeRetiradaDiaSeguinte
  Scenario: Pedido de retirada com data retirada no dia seguinte
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-19         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}96         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 200

  @PedidoDeRetiradaSemData
  Scenario: Pedido de retirada sem informar data retirada
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | null               |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}96         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | [0].errors.message | Informe a data de retirada |

  @PedidoDeRetiradaSemHoraRetirada
  Scenario: Pedido de retirada sem hora retirada inicial
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-12-14         |
      | dadosPedido.horaRetiradaInicial      | null               |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}96         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | [0].errors.message | Informe a hora da retirada inicial |

  @PedidoDeRetiradaSemHoraFinal
  Scenario: Pedido de retirada sem hora retirada final
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-18         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | null               |
      | dadosPedido.total                    | {number}96         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | [0].errors.message | Informe a hora da retirada final |

  @PedidoDeRetiradaDiaSemana
  Scenario: Pedido de retirada informando dia da semana ao inv??s da data
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | Segunda-feira      |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}96         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | [0].errors.message | Informe uma data no formato YYYY-MM-DD |

  @PedidoDeRetiradaDescontoMaior
  Scenario: Pedido de retirada com desconto maior que o oferecido pela revenda
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-17         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 18:00:00           |
      | dadosPedido.total                    | {number}186        |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}2          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}26         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}6.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | [0].errors.message | O desconto n??o pode ser maior que o oferecido pela revenda |

  @PedidoDeRetiradaDescontoMenor
  Scenario: Pedido de retirada com desconto menor que o oferecido pela revenda
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-18         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}191        |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}2          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}26         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}1.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | [0].errors.message | O desconto n??o pode ser menor que o oferecido pela revenda |

  @PedidoDeRetiradaRevendaBloqueada
  Scenario: Pedido de retirada para uma revenda bloqueada
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}14462      |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-18         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}186        |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}2          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}26         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}6.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | [0].errors.message | Revenda bloqueada, escolha outra revenda para fazer o pedido |

  @PedidoDeRetiradaComTaxa
  Scenario: Pedido de retirada cobrando taxa de entrega
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-17         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}98         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.taxaEntrega            | {number}2          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | [0].errors.message | Taxa de entrega n??o aplicada para pedido de retirada |

  @PedidoDeRetiradaComPrecoProdutoIncorreto
  Scenario: Pedido de retirada com pre??o produto incorreto
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-17         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 12:00:00           |
      | dadosPedido.total                    | {number}20         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}20.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | [0].errors.message | Pre??o botija incorreto |

  @PedidoDeRetiradaFuturoDistante
  Scenario: Pedido de retirada informando data futuro distante
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-18         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 18:00:00           |
      | dadosPedido.total                    | {number}96         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | [0].errors.message | A data de retirada n??o deve ser distante |

  @PedidoDeRetiradaFormato
  Scenario: Pedido de retirada informando data no formato YYYY/MM/DD
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022/02/18         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 18:00:00           |
      | dadosPedido.total                    | {number}96         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | [0].errors.message | Informe uma data no formato YYYY-MM-DD |

  @PedidoDeRetiradaFormatoDDMMYYYY
  Scenario: Pedido de retirada informando data no formato dd-mm-yyyy
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 18-02-2022         |
      | dadosPedido.horaRetiradaInicial      | 08:00:00           |
      | dadosPedido.horaRetiradaFinal        | 18:00:00           |
      | dadosPedido.total                    | {number}96         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | [0].errors.message | Informe uma data no formato YYYY-MM-DD |

  @PedidoDeRetiradaFormatoHoras
  Scenario: Pedido de retirada informando yyyy-mm-dd
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-18         |
      | dadosPedido.horaRetiradaInicial      | oito horas         |
      | dadosPedido.horaRetiradaFinal        | dezoito horas      |
      | dadosPedido.total                    | {number}96         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Dinheiro           |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | [0].errors.message | Informe uma data no formato YYYY-MM-DD |

  @PedidoRetiradaPixRevendaNaoAceita
  Scenario: Pedido retirada com pagamento Pix para revenda que n??o aceita pix
    Given adiciono o body do tipo "RequestPedidoKMS" alterando os dados
      | dadosCliente.clienteSemId            | {bool}false        |
      | dadosCliente.idCliente               | {number}335644     |
      | dadosCliente.idEndereco              | {number}327567     |
      | dadosCliente.latitude                | {number}-3.3465345 |
      | dadosCliente.longitude               | {number}-60.345236 |
      | dadosCliente.telefoneCliente         | 11942391453        |
      | dadosCliente.distanciaRevendaCliente | {number}4.3        |
      | dadosRevenda.revendaEscolhida        | {number}108598     |
      | dadosPedido.retiradaNaRevenda        | true               |
      | dadosPedido.observacao               | Gostei muito       |
      | dadosPedido.origem                   | {number}6          |
      | dadosPedido.tipoPedido               | PedidoGasPortaria  |
      | dadosPedido.dataRetirada             | 2022-02-18         |
      | dadosPedido.horaRetiradaInicial      | oito horas         |
      | dadosPedido.horaRetiradaFinal        | dezoito horas      |
      | dadosPedido.total                    | {number}96         |
      | dadosPedido.troco                    | {number}0          |
      | dadosPedido.versaoApp                | {number}4.5        |
      | itensPedido[0].marca                 | Fogas              |
      | itensPedido[0].preco                 | {number}96.0       |
      | itensPedido[0].produto               | P13                |
      | itensPedido[0].quantidade            | {number}1          |
      | itensPedido[0].quilos                | {number}13.0       |
      | dadosPagamento.formaPagamento        | Pix                |
      | dadosFidelidade.pontosCompra         | {number}0          |
      | dadosFidelidade.quilosCompra         | {number}13         |
      | taxasDesconto.descontoFidelidade     | {number}0          |
      | taxasDesconto.descontoRevenda        | {number}0.0        |
    And utilizo os headers "AUTH_ID"
    When fa??o um post para "/pedido/novo/pedido-kms"
    Then recebo a response com status 200
    And salvo os dados da response
      | VarCiphertext | ciphertext |
    And adiciono o body do tipo "RequestPostPedido" alterando os dados
      | ciphertext | {storage}VarCiphertext |
    And utilizo os headers "AUTH_ENUM"
    And fa??o um post para "/pedido"
    And recebo a response com status 400 os dados
      | [0].errors.message | Revenda n??o aceita Pix, altere a forma de pagamento |