import 'package:localizamed_app/blocs/conexaoAPI.dart';
import 'package:localizamed_app/repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localizamed_app/classes/clinica_class.dart';

class PesquisaBloc {
  Repository _repository = Repository();

  final _pesquisaGet = BehaviorSubject<List<Clinicas>>();
  BehaviorSubject<List<Clinicas>> get pesquisaList => _pesquisaGet.stream; 

  getPesquisa() async {
    List<Clinicas> pesquisaRes = await _repository.getPesquisa();
    _pesquisaGet.sink.add(pesquisaRes);
  }

  final BehaviorSubject<String> _pesquisaController = BehaviorSubject<String>();

  BehaviorSubject<String> get outPesquisa => _pesquisaController.stream;
  Function(String) get changePesquisa => _pesquisaController.sink.add;

  Future<void> pesquisa() async {
    final pesquisa = _pesquisaController.value;

    String url = ConexaoAPI().api + "search_clinica";
    Map<String, String> headers = {"Accept": "application/json"};

    try {
      http.Response response = await http.post(url, headers: headers, body: {"search": pesquisa});
      if (response.statusCode == 201){
        print(pesquisa);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('query', pesquisa);
      }
    } catch (erro) {
      print("catch de erro");
    }
  }

  void setPesquisa(String pesquisa) {
    _pesquisaController.add(pesquisa);
  }

  void dispose() {
    _pesquisaController.close();
    _pesquisaGet.close();
  }
}

final pesquisaBloc = PesquisaBloc();
