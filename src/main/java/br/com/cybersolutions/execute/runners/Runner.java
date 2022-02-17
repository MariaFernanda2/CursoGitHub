package br.com.cybersolutions.execute.runners;

import org.junit.BeforeClass;
import org.junit.runner.RunWith;

import br.com.cybersolutions.core.hooks.HookBefore;
import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import io.cucumber.junit.CucumberOptions.SnippetType;

@RunWith(Cucumber.class)
@CucumberOptions(
        plugin = {"com.aventstack.extentreports.cucumber.adapter.ExtentCucumberAdapter:"},
        features = "src/main/resources/features",
        glue = {"br.com.cybersolutions.execute", "br.com.cybersolutions.core"},

        tags = "@PedidoDeRetiradaSemHoraRetirada",

        snippets = SnippetType.CAMELCASE
        
)
public class Runner {
	
	

    @BeforeClass
    public static void frameworkSetup() {
         HookBefore.frameworkInitialSetup();
   
    }

}