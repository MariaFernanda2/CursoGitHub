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

    AUTH_RAIO {
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
}