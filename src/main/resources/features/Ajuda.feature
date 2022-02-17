@Ajuda
Feature: Ajuda para os Aplicativos
  #Seção Ajuda para os Aplicativos: Como Funciona, Dúvidas Frequentes e Termo de Uso.

  @AjudaParaOsAppComoFunciona
  Scenario: Ajuda para os aplicativos - Como Funciona
  Given adiciono o body do tipo "RequestAjuda"
  And utilizo os headers "CLIENTE_ENUM"
  And adiciono os queryParams
  | idCliente     | 335644 |
  | tipoAjuda     | 1      |
  | origemDigital | 6      |
  When faço um get para "/ajuda/cliente"
  Then recebo a response com status 404

  @AjudaParaOsAppDuvidasFrequente
  Scenario: Ajuda para os aplicativos - Duvidas Frequente
  Given adiciono o body do tipo "RequestAjuda"
  And utilizo os headers "CLIENTE_ENUM"
  And adiciono os queryParams
  | idCliente     | 335644 |
  | tipoAjuda     | 2      |
  | origemDigital | 6      |
  When faço um get para "/ajuda/cliente"
  Then recebo a response com status 200

  @AjudaParaOsAppTermoDeuso
  Scenario: Ajuda para os aplicativos - Termo de Uso
  Given adiciono o body do tipo "RequestAjuda"
  And utilizo os headers "CLIENTE_ENUM"
  And adiciono os queryParams
  | idCliente     | 335644 |
  | tipoAjuda     | 3      |
  | origemDigital | 6      |
  When faço um get para "/ajuda/cliente"
  Then recebo a response com status 200

  @AjudaParaOsAppTermoAceite
  Scenario: Ajuda para os aplicativos - Termo Aceite
  Given adiciono o body do tipo "RequestAjuda"
  And utilizo os headers "CLIENTE_ENUM"
  And adiciono os queryParams
  | idCliente     | 335644 |
  | tipoAjuda     | 4      |
  | origemDigital | 6      |
  When faço um get para "/ajuda/cliente"
  Then recebo a response com status 404

  @AjudaParaOsAppAssistenciaTecnica
  Scenario: Ajuda para os aplicativos - Assistencia Tecnica
  Given adiciono o body do tipo "RequestAjuda"
  And utilizo os headers "CLIENTE_ENUM"
  And adiciono os queryParams
  | idCliente     | 335644 |
  | tipoAjuda     | 5      |
  | origemDigital | 6      |
  When faço um get para "/ajuda/cliente"
  Then recebo a response com status 200

  @AjudaParaOsAppCozinhaSegura
  Scenario: Ajuda para os aplicativos - Cozinha Segura
  Given adiciono o body do tipo "RequestAjuda"
  And utilizo os headers "CLIENTE_ENUM"
  And adiciono os queryParams
  | idCliente     | 335644 |
  | tipoAjuda     | 6      |
  | origemDigital | 6      |
  When faço um get para "/ajuda/cliente"
  Then recebo a response com status 200

  @AjudaParaOsAppProgramaFidelidade
  Scenario: Ajuda para os aplicativos - Programa Fidelidade
  Given adiciono o body do tipo "RequestAjuda"
  And utilizo os headers "CLIENTE_ENUM"
  And adiciono os queryParams
  | idCliente     | 335644 |
  | tipoAjuda     | 9      |
  | origemDigital | 6      |
  When faço um get para "/ajuda/cliente"
  Then recebo a response com status 200

  @AjudaParaOsAppCompartilheGanhe
  Scenario: Ajuda para os aplicativos - Compartilhe e Ganhe
  Given adiciono o body do tipo "RequestAjuda"
  And utilizo os headers "CLIENTE_ENUM"
  And adiciono os queryParams
  | idCliente     | 335644 |
  | tipoAjuda     | 10     |
  | origemDigital | 6      |
  When faço um get para "/ajuda/cliente"
  Then recebo a response com status 200

  @AjudaParaOsAppEntregaEconomica
  Scenario: Ajuda para os aplicativos - Entrega Economica
  Given adiciono o body do tipo "RequestAjuda"
  And utilizo os headers "CLIENTE_ENUM"
  And adiciono os queryParams
  | idCliente     | 335644 |
  | tipoAjuda     | 13     |
  | origemDigital | 6      |
  When faço um get para "/ajuda/cliente"
  Then recebo a response com status 200

