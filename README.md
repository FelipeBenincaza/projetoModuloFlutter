# projetopesquisa

É um projeto básico para realizar uma pesquisa em um domicílio.

## Funcionalidades do projeto
- Cadastro de Domicilio - tela para cadastrar domicílio preenchendo as infomações do endereço. Oferece a opção no appBar para adicionar essas infomações de maneira fake.<br>
- Seleção de Questionario - tela para selecionar o domicílio e excluir domicilio através do Slidable.<br>
- Abertura de Domicílio - mostra as informações do domicílio e solicita o tipo de entrevista. Dependendo do tipo de entrevista selecionado a entrevista é encerrada ou vai para o questionário.<br>
- Questionario - tela de quetionario para o domicílio responder. Opção no appBar para capturar as coordenadas no momento do questionario está sendo aplicado.<br>

## Tecnologias utilizadas
Projeto desenvolvido em Flutter e Dart, utilizando Firebase para persistência de dados e das biblioteca Faker, flutter_slidable, email_validator e location.<br> 
Utilizado como api interna o gps para capturar alocalização na pagina do questionário e consumo de um pacote interno utilizando suas funcionalidades para verificação das regras do questionário.

## Inicialização
Após baixar o projeto é necessário baixar o pacote pesquisapack no repositorio https://github.com/FelipeBenincaza/packProjetos e colocar no mesmo local que foi colocado o projetoPesquisa.<br>
O pacote está sendo chamado via path local.

## Status do projeto
Em desenvolvimento
