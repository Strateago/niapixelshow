GUI Cenário: Administrador Adiciona uma nova Categoria de Produto
Given o administrador com o login “liginha” e senha “liginha123” está logado no painel de administração do e-commerce
And está na página “Gerenciamento de Categorias”
When ele seleciona a opção “Adicionar Nova Categoria”
And ele insere o nome “Acessórios Temáticos”
And ele adiciona a descrição “broches, chaveiros e cordões para crachá temáticos do centro de informática”
And ele confirma o cadastro da categoria 
Then ele é redirecionado de volta para a página “Gerenciamento de Categorias”
And ele pode ver a nova categoria “Acessórios Temáticos” na lista de categorias

GUI Cenário: Administrador Edita uma Categoria Existente 
Given o administrador com o login “liginha” e senha “liginha123” está logado no painel de administração do e-commerce
And está na página “Gerenciamento de Categorias”
And há uma categoria chamada “Camisetas Personalizadas”
When ele seleciona a opção “editar” para a categoria “Camisetas Personalizadas”
And ele altera o nome da categoria para “Camisetas Temáticas”
And ele atualiza a descrição e a imagem representativa 
And ele confirma o cadastro da categoria  
Then ele é redirecionado de volta para a página “Gerenciamento de Categorias”
And ele pode ver a categoria atualizada com o novo nome “Camisetas Temáticas”

GUI Cenário: Administrador Remove uma Categoria Existente 
Given o administrador com o login “liginha” e senha “liginha123” está logado no painel de administração do e-commerce
And está na página “Gerenciamento de Categorias”
And há uma categoria chamada “Promoções Temporárias”
When ele seleciona a opção “remover” para a categoria “Promoções Temporárias”
And ele confirma a remoção
Then ele é redirecionado de volta para a página “Gerenciamento de Categorias”
And ele não vê mais a categoria “Promoções Temporárias” na lista de categorias