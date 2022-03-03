package br.com.cybersolutions.core.steps;

import io.cucumber.java.en.And;
import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;

public class StepsLimpaRequisicao {

    @And("limpo o objeto de requisicao")
    public void limparObjRequisicao() {
        RestAssured.requestSpecification = null;
        RestAssured.requestSpecification = new RequestSpecBuilder().build();
    }
}
