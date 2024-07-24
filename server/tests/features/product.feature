Feature: Cadastro e Manutenção do Produto

 Scenario: Cadastro do Produto Bem-Sucedido
    Given eu estou autenticado como administrador com email "nrc2@cin.ufpe.br" e senha "nia12345" e tenho um token JWT válido
    And que o banco de dados de produto está vazio
    When o fornecedor submete um formulário de cadastro de produto com nome "Camisa Nova", descrição "Algodão", preço "50.0", status "true", categoria "Camisas", descrição da categoria "Descrição da categoria"
    Then o sistema valida que os campos "nome", "descrição", "preço", "status" e "categoria" estão preenchidos
    And o sistema verifica que todos os dados estão válidos
    And o sistema salva o produto no banco de dados e retorna uma confirmação de sucesso

 Scenario: Cadastro do Produto com Campo Não Preenchido
    Given eu estou autenticado como administrador com email "nrc2@cin.ufpe.br" e senha "nia12345" e tenho um token JWT válido
    And que o banco de dados de produto está vazio
    When o fornecedor submete um formulário de cadastro de produto com nome "Camisa Nova", descrição "Algodão", preço "", status "true", categoria "Camisas", descrição da categoria "Descrição da categoria"
    Then o sistema valida se os campos "nome", "descrição", "preço", "status" e "categoria" estão preenchidos
    And o sistema retorna uma mensagem de erro informando que todos os campos devem ser preenchidos

 Scenario: Cadastro do Produto com Preço Negativo
  Given eu estou autenticado como administrador com email "nrc2@cin.ufpe.br" e senha "nia12345" e tenho um token JWT válido
  And que o banco de dados de produto está vazio
  When o fornecedor submete um formulário de cadastro de produto com nome "Camisa Nova", descrição "Algodão", preço "-50.0", status "true", categoria "Camisas", descrição da categoria "Descrição da categoria"
  Then o sistema valida que o campo "preço" possui um valor positivo
  And o sistema retorna uma mensagem de erro informando que o "preço" não pode ser negativo

 Scenario: Atualização do Produto Bem-Sucedida
   Given eu estou autenticado como administrador com email "nrc2@cin.ufpe.br" e senha "nia12345" e tenho um token JWT válido
   And que o produto com ID "123" existe no banco de dados de produto com nome "Camisa Nova", descrição "Algodão", preço "50", status "true", categoria "Camisas", descrição da categoria "Descrição da categoria"
   When o fornecedor submete um formulário de atualização de produto com nome "Camisa Azul", descrição "Algodão", preço "50", status "true", categoria "Camisas", descrição da categoria "Descrição da categoria"
   Then o sistema valida que os campos "nome", "descrição", "preço", "status" e "categoria" estão preenchidos
   And o sistema atualiza o produto no banco de dados e retorna uma confirmação de sucesso

 Scenario: Atualização do Produto com Campo Não Preenchido
  Given eu estou autenticado como administrador com email "nrc2@cin.ufpe.br" e senha "nia12345" e tenho um token JWT válido
  And que o produto com ID "123" existe no banco de dados de produto com nome "Camisa Nova", descrição "Algodão", preço "50", status "true", categoria "Camisas", descrição da categoria "Descrição da categoria"
  When o fornecedor submete um formulário de atualização de produto com nome "Camisa Azul", descrição "Algodão", preço "", status "true", categoria "Camisas", descrição da categoria "Descrição da categoria"
  Then o sistema valida se os campos "nome", "descrição", "preço", "status" e "categoria" estão preenchidos
  And o sistema retorna uma mensagem de erro informando que todos os campos devem ser preenchidos

 Scenario: Atualização do Produto com Preço Negativo
  Given eu estou autenticado como administrador com email "nrc2@cin.ufpe.br" e senha "nia12345" e tenho um token JWT válido
  And que o produto com ID "123" existe no banco de dados de produto com nome "Camisa Nova", descrição "Algodão", preço "50", status "true", categoria "Camisas", descrição da categoria "Descrição da categoria"
  When o fornecedor submete um formulário de atualização de produto com nome "Camisa Azul", descrição "Algodão", preço "-50", status "true", categoria "Camisas", descrição da categoria "Descrição da categoria"
  Then o sistema valida que o campo "preço" possui um valor positivo
  And o sistema retorna uma mensagem de erro informando que o "preço" não pode ser negativo

 Scenario: Exclusão de Produto Bem-Sucedida
   Given eu estou autenticado como administrador com email "nrc2@cin.ufpe.br" e senha "nia12345" e tenho um token JWT válido
   And que o produto com ID "123" existe no banco de dados de produto com nome "Camisa Nova", descrição "Algodão", preço "50", status "true", categoria "Camisas", descrição da categoria "Descrição da categoria"
   When o fornecedor submete um pedido de exclusão de produto
   Then o sistema verifica se o produto existe
   And o sistema remove o produto do banco de dados e retorna uma mensagem de confirmação de exclusão

 Scenario: Exclusão de Produto Mal-Sucedida
    Given eu estou autenticado como administrador com email "nrc2@cin.ufpe.br" e senha "nia12345" e tenho um token JWT válido
    When o fornecedor submete um pedido de exclusão de produto com ID "999"
    Then o sistema retorna uma mensagem de erro informando que o produto não foi encontrado

 Scenario: Leitura de Produto Específico Bem-Sucedida
   Given eu estou autenticado como administrador com email "nrc2@cin.ufpe.br" e senha "nia12345" e tenho um token JWT válido
   And que o produto com ID "123" existe no banco de dados de produto com nome "Camisa Nova", descrição "Algodão", preço "50", status "true", categoria "Camisas", descrição da categoria "Descrição da categoria"
   When o fornecedor solicita os detalhes de um produto específico
   Then o sistema verifica que o produto existe
   And o sistema retorna os detalhes do produto solicitado com nome "Camisa Nova", descrição "Algodão", preço "50", status "true", categoria "Camisas", descrição da categoria "Descrição da categoria"

 Scenario: Leitura de Produto Mal-Sucedida
    Given eu estou autenticado como administrador com email "nrc2@cin.ufpe.br" e senha "nia12345" e tenho um token JWT válido
    When o fornecedor solicita os detalhes de um produto específico com ID "999"
    Then o sistema retorna uma mensagem de erro informando que o produto não foi encontrado

 Scenario: Leitura de Todos os Produtos Bem-Sucedida
    Given eu estou autenticado como administrador com email "nrc2@cin.ufpe.br" e senha "nia12345" e tenho um token JWT válido
    And que existem produtos no banco de dados
    When o fornecedor solicita a lista de todos os produtos
    Then o sistema retorna a lista de todos os produtos