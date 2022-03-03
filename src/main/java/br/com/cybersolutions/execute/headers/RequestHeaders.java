package br.com.cybersolutions.execute.headers;

import br.com.cybersolutions.core.interfaces.EnumHeadersInterface;
import io.restassured.http.Header;
import io.restassured.http.Headers;

public enum RequestHeaders implements EnumHeadersInterface {

    CLIENT_ID {
        @Override

        public Headers setHeaders() {

            return new Headers(clientID);
        }

    },
    ACESS_TOKEN {
        @Override

        public Headers setHeaders() {

            return new Headers(AcessToken);
        }

    },

    CLIENTE_ENUM {
        @Override

        public Headers setHeaders() {
            return new Headers(IdCliente);
        }

    },
    AUTH_ID {
        @Override

        public Headers setHeaders() {

            return new Headers(clientID, AcessToken, IdCliente);
        }

    },

    AUTH_IDPCOMPLETO {
        @Override

        public Headers setHeaders() {

            return new Headers(clientID, AcessTokenClientePedidoCompleto, IdClientePedidoCompleto);
        }

    },

    AUTH_SMS {
        @Override

        public Headers setHeaders() {

            return new Headers(clientID, Authorization);
        }

    },
    AUTH_ENUM {
        @Override

        public Headers setHeaders() {
            return new Headers(clientID, AcessToken);
        }
    },

    AUTH_RAIO2 {
        @Override

        public Headers setHeaders() {
            return new Headers(acessToken2, clientID);
        }
    },

    AUTH_HEADER {
        @Override

        public Headers setHeaders() {
            return new Headers(acessToken2, clientID, IdClient3);
        }
    },

    AUTH_PRESTADOR {
        @Override

        public Headers setHeaders() {
            return new Headers(AcessTokenPrestador, ClienteIdPrestador);
        }
    },
    AUTH_PCOMPLETO {
        @Override

        public Headers setHeaders() {
            return new Headers(AcessTokenClientePedidoCompleto, clientID);
        }
    },

    AUTH_RAIOREVENDA {
        @Override

        public Headers setHeaders() {
            return new Headers(clientID, acessToken2, IdClient2);
        }

    };


    Header clientID = new Header("client_id", "5418a6fe-b6fa-3278-927d-48713cc21e7a");

    Header AcessToken = new Header("access_token", "cc6d45fa-379b-3834-9ec3-c47f9ec29728");

    Header IdCliente = new Header("idCliente", "335644");

    Header Authorization = new Header("Authorization", " Basic NTQxOGE2ZmUtYjZmYS0zMjc4LTkyN2QtNDg3MTNjYzIxZTdhOmE3N2M1NzFjLTk2MGYtMzVkMS04ZmQwLTU2MmY4MWIwZThhZA==");




    Header acessToken2 = new Header("access_token", "aee95356-bdf8-3f70-95c4-6390079796ca");

    Header IdClient2 = new Header("idCliente", "335705");

    Header IdClient3 = new Header("idCliente", "335638");

    Header IdClientePedidoCompleto = new Header("idCliente", "335729");

    Header AcessTokenClientePedidoCompleto = new Header("access_token", "70d00532-5fec-38eb-9f05-693a21c8e080");

    Header AcessTokenPrestador = new Header("access_token", "bd6165e3-d56f-3853-9ee7-dd07465b8d3a");

    Header ClienteIdPrestador = new Header("client_id","747ac3bd-16b7-300b-b574-541fd9236e6f");
}