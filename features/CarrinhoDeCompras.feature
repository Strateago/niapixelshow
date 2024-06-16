Scenario: Adicionar o pedido ao carrinho com sucesso 
    Given o cliente de login “ze” e senha “zeze” está logado na loja
    And está na página de “produtos”
    When o cliente tenta adicionar uma camisa de tamanho “P” ao carrinho
    Then ele vê uma mensagem de confirmação de adição do produto
    And pode ver a camisa de tamanho “P” no seu carrinho

Scenario: Remover um dos pedidos disponíveis do carrinho 
    Given o cliente de login “ze” e senha “zeze” está 
    And está na página “seu carrinho”
    And ele tem três itens diferentes adicionadas no carrinho
    And o primeiro produto é uma camisa “Camisa Cin 50 anos” de tamanho “P” e quantidade “1”
    And o segundo produto é uma camisa “Camisa Cin Básica” de tamanho “P” e quantidade “2”
    And o terceiro produto é uma camisa “Camisa Cin Rosa” de tamanho “P” e quantidade “1”
    When ele seleciona a opção “remover” o produto “Camisa Cin 50 anos” do carrinho
    Then ele pode ver uma tela pedindo para confirmar a remoção

Scenario: Confirmação de remoção de pedido
            Given o cliente de login “ze” e senha “zeze” está logado na loja
            And está na página “confirmar remoção”
            And ele tem um produto “Camisa Cin 50 anos” no carrinho
            And está removendo o produto “Camisa Cin 50 anos”
            When ele seleciona a opção “sim”
            Then ele retorna para a tela “seu carrinho”
            And ele pode ver o carrinho sem o produto “Camisa Cin 50 anos”

Scenario: Editar pedido no carrinho de pedidos  
        Given o cliente com login "ze" e senha "zeze" está logado na loja
        And está na página "seu carrinho"
        And ele tem um pedido no carrinho com uma camisa “Camisa Cin 50 anos” de tamanho "P" e quantidade "1"
        When ele seleciona a opção "editar" o pedido
        And ele altera o tamanho da camisa “Camisa Cin 50 anos” para "M"
        And ele confirma a edição do pedido
        Then ele pode ver o pedido atualizado com a camisa de tamanho "M" e quantidade "1”


Scenario: Cliente finaliza a compra dos pedidos no carrinho     
        Given o cliente com login "ze" e senha "zeze" está logado na loja     
        And está na página "seu carrinho"    
        And ele tem um pedido no carrinho com uma camisa de tamanho "M" e quantidade "1"     
        When ele seleciona a opção "finalizar"     
        Then ele pode ver a página de revisão do pedido     
        When ele confirma os detalhes do pedido    
        And ele fornece as informações de pagamento válidas     
        And ele seleciona a opção "pagar"
        Then ele pode ver uma tela de confirmação de pedido
        And ele pode ver um resumo do pedido com um número de confirmação    
        And o status do pedido é atualizado para "processando"     	