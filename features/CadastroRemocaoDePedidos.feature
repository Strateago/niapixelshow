Scenario: Visualizar pedidos em andamento
	Given o cliente com login “ze” e senha “zeze” está logado na loja
	And está na página de “meus pedidos”
    And ele tem um pedido cadastrado com uma camisa “Camisa Cin 50 anos” de tamanho “M” e quantidade “1” em andamento
	When ele seleciona a opção “ver pedido”
    Then ele pode ver uma tela com as informações endereço “Rua do zeze” , valor “R$45,00” e data “21/05/2024”
