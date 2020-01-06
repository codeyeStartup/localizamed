  import 'package:rxdart/rxdart.dart';

class PesquisaBloc{

    final BehaviorSubject<String> _pesquisaController = BehaviorSubject<String>();

    void setPesquisa(String pesquisa){
      _pesquisaController.add(pesquisa);
    }

    void dispose(){
        _pesquisaController.close();
    }
  }