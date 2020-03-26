import 'package:flutter/material.dart';

class Termos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
        Text('Termos e Condições de uso', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),),
        SizedBox(width: 2.4,),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
            Navigator.of(context).pop();
          },
        )
      ],),
      content: Container(
        height: 500,
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               Text('Codeye criou o aplicativo Localizamed como um aplicativo gratuito. Este SERVIÇO é fornecido pela Codeye, sem nenhum custo e destina-se ao uso como está.'),
        Text('Esta página é usada para informar os visitantes sobre nossas políticas de coleta, uso e divulgação de Informações pessoais, se alguém decidir usar nosso Serviço.'),
        Text('Se você optar por usar nosso Serviço, concorda em coletar e usar informações em relação a esta política. As informações pessoais que coletamos são usadas para fornecer e melhorar o serviço. Não usaremos ou compartilharemos suas informações com ninguém, exceto conforme descrito nesta Política de Privacidade.'),
        Text('Os termos usados ​​nesta Política de Privacidade têm o mesmo significado que em nossos Termos e Condições, que podem ser acessados ​​na Localizamed, a menos que definido de outra forma nesta Política de Privacidade.'),
        Text('Coleta e uso de informações', style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),),
        Text('Para uma experiência melhor, ao usar nosso Serviço, podemos solicitar que você nos forneça certas informações de identificação pessoal. As informações que solicitamos serão retidas por nós e usadas conforme descrito nesta política de privacidade.'),
        Text('O aplicativo usa serviços de terceiros que podem coletar informações usadas para identificá-lo.'),
        Text('Link para a política de privacidade de provedores de serviços de terceiros usados ​​pelo aplicativo'),
        Text('Serviços do Google \n'
            'Facebook\n'
            'Dados de log'),
        Text('Queremos informar que, sempre que você usa nosso Serviço, em caso de erro no aplicativo, coletamos dados e informações (através de produtos de terceiros) no seu telefone chamado Log Data. Esses dados de registro podem incluir informações como o endereço IP do dispositivo, nome do dispositivo, versão do sistema operacional, a configuração do aplicativo ao utilizar nosso serviço, a hora e a data de uso do serviço e outras estatísticas .'),
        Text('Cookies', style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),),
        Text('Cookies são arquivos com uma pequena quantidade de dados que são comumente usados ​​como identificadores exclusivos anônimos. Eles são enviados para o navegador a partir dos sites visitados e armazenados na memória interna do dispositivo.'),
        Text('Este serviço não usa esses "cookies" explicitamente. No entanto, o aplicativo pode usar código e bibliotecas de terceiros que usam "cookies" para coletar informações e melhorar seus serviços. Você tem a opção de aceitar ou recusar esses cookies e saber quando um cookie está sendo enviado para o seu dispositivo. Se você optar por recusar nossos cookies, poderá não conseguir usar algumas partes deste Serviço.'),
        Text('Provedores de serviço', style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),),
        Text('Podemos empregar empresas e indivíduos de terceiros devido aos seguintes motivos:'),
        Text('Para facilitar nosso serviço;\n'
              'Fornecer o serviço em nosso nome;\n'
              'Executar serviços relacionados ao serviço; ou\n'
              'Para nos ajudar a analisar como nosso Serviço é usado.\n'
              'Queremos informar aos usuários deste Serviço que esses terceiros têm acesso às suas Informações Pessoais. O motivo é executar as tarefas atribuídas a eles em nosso nome. No entanto, eles são obrigados a não divulgar ou usar as informações para qualquer outra finalidade.'),
        Text('Segurança', style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),),
        Text('Valorizamos sua confiança em nos fornecer suas informações pessoais, portanto, estamos nos esforçando para usar meios comercialmente aceitáveis ​​de protegê-las. Mas lembre-se de que nenhum método de transmissão pela Internet ou método de armazenamento eletrônico é 100% seguro e confiável, e não podemos garantir sua segurança absoluta.'),
        Text('Links para outros sites', style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),),
        Text('Este serviço pode conter links para outros sites. Se você clicar em um link de terceiros, será direcionado para esse site. Observe que esses sites externos não são operados por nós. Portanto, recomendamos que você reveja a Política de Privacidade desses sites. Não temos controle e não assumimos nenhuma responsabilidade pelo conteúdo, políticas de privacidade ou práticas de sites ou serviços de terceiros.'),
        Text('Privacidade das crianças', style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),),
        Text('Esses serviços não tratam de menores de 13 anos. Não coletamos intencionalmente informações de identificação pessoal de crianças menores de 13 anos. No caso de descobrirmos que uma criança menor de 13 anos nos forneceu informações pessoais, as excluiremos imediatamente de nossos servidores. Se você é pai ou mãe ou responsável e sabe que seu filho nos forneceu informações pessoais, entre em contato conosco para que possamos realizar as ações necessárias.'),
        Text('Alterações a esta Política de Privacidade', style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),),
        Text('Podemos atualizar nossa Política de Privacidade periodicamente. Portanto, é recomendável revisar esta página periodicamente para verificar se há alterações. Notificaremos você sobre quaisquer alterações, publicando a nova Política de Privacidade nesta página. Essas alterações entram em vigor imediatamente após serem publicadas nesta página.'),
        Text('Contate-Nos', style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),),
        Text('Se você tiver alguma dúvida ou sugestão sobre nossa Política de Privacidade, não hesite em nos contactar em localizamedapp@gmail.com.'),
            ],
          ),
        ),
      ),
    );
  }
}