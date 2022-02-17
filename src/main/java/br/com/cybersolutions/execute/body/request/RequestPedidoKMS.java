package br.com.cybersolutions.execute.body.request;


import br.com.cybersolutions.execute.body.model.dadosCliente;
import br.com.cybersolutions.execute.body.model.dadosFidelidade;
import br.com.cybersolutions.execute.body.model.dadosNotaFiscal;
import br.com.cybersolutions.execute.body.model.dadosPagamento;
import br.com.cybersolutions.execute.body.model.dadosPedido;
import br.com.cybersolutions.execute.body.model.dadosRevenda;
import br.com.cybersolutions.execute.body.model.itensPedido;
import br.com.cybersolutions.execute.body.model.pedidoEconomico;
import br.com.cybersolutions.execute.body.model.taxasDesconto;

import java.util.ArrayList;
import java.util.List;

public class RequestPedidoKMS {

    private dadosCliente dadosCliente = new dadosCliente();
    private dadosRevenda dadosRevenda = new dadosRevenda();
    private dadosFidelidade dadosFidelidade = new dadosFidelidade();
    private dadosNotaFiscal dadosNotaFiscal = new dadosNotaFiscal();
    private dadosPagamento dadosPagamento = new dadosPagamento();
    private dadosPedido dadosPedido = new dadosPedido();
    private List<itensPedido> itensPedido = new ArrayList<>();
    private pedidoEconomico pedidoEconomico = new pedidoEconomico();
    private taxasDesconto taxasDesconto = new taxasDesconto();

    public RequestPedidoKMS(){
        itensPedido.add(new itensPedido());
    }
}
