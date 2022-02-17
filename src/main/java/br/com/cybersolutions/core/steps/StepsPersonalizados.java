package br.com.cybersolutions.core.steps;

import io.cucumber.datatable.DataTable;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;

public class StepsPersonalizados {

    @Given("espero {int} milissegundos")
    public void esperoMilissegundos(int milissegundos) {
        try {
            Thread.sleep(milissegundos);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
