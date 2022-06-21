# projetopesquisa

É um projeto básico para realizar uma pesquisa em um domicílio sobre os serviços públicos ofericidos no local de moradia.

## Funcionalidades do projeto
A aplicação possui as páginas de login, seleção de domicílio, cadastro de domicílio, abertura de domicílio e questionário. <br>
- O login foi feito utilizando a autenticação por e-mail do Firebase. Oferece a opção de cadastrar novo usuário. <br>
- A tela de seleção mostra os domicílios cadastrados e o seu status. Seus status podem ser Não Iniciado, Em Andamento e Finalizado. Na lista possui um Slidable que oferece a opção de excluir. No appBar tem os ícones para adicionar novo domicílio e fazer logout. <br>
- Para cadastrar domicílio é permitido o preenchimento das informações do endereço, outros campos são preenchidos pelo próprio sistema. Oferece a opção no appBar para adicionar essas informações de endereço de maneira fake. <br>
-  A tela de abertura de Domicílio mostra as informações do domicílio e solicita o tipo de entrevista. Dependendo do tipo de entrevista selecionado a entrevista é encerrada ou vai para o questionário. <br>
- A tela de questionário apresenta perguntas para serem respondidas sobre o local do domicílio. Possui uma opção no appBar para capturar as coordenadas no momento do questionário está sendo aplicado. Ao salvar o questionário é executado críticas que estão num pacote. <br>

## Tecnologias utilizadas
Projeto desenvolvido em Flutter e Dart, utilizando Firebase para persistência de dados e das biblioteca Faker, flutter_slidable, email_validator e location.<br> 
Utilizado como api interna o gps para capturar a localização na página do questionário e consumo de um pacote interno utilizando suas funcionalidades para verificação das regras do questionário.

## Inicialização
Após baixar o projeto é necessário baixar o pacote pesquisapack no repositório https://github.com/FelipeBenincaza/packProjetos e colocar no mesmo local que foi colocado o projetoPesquisa.<br>
O pacote está sendo chamado via path local, verificar no arquivo pubspec se o nome do pacote esta o mesmo da pasta.

## Status do projeto
Em desenvolvimento