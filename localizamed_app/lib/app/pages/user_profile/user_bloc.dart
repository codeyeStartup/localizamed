import 'dart:async';
import 'dart:io';
import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:localizamed_app/app/models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/app/pages/login/login_bloc.dart';
import 'package:localizamed_app/app/utils/conexaoAPI.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc {
  BehaviorSubject<File> _imageUser = BehaviorSubject<File>();
  Stream<File> get imageUser => _imageUser.stream;

  void changeImage(File file) {
    _imageUser.add(file);
  }
  
  //User data 
  Future<Usuario> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('tokenjwt');
      var uid = await getUserID();

      var url = ConexaoAPI().api + 'usuario/$uid';
      var header = {
        "Content-Type": "application/json",
        "x-access-token": token
      };

      final response = await http.get(url, headers: header);
      Usuario model = Usuario.fromJson(json.decode(response.body));
      return model;
    } catch (err) {
      return err;
    }
  }

  //Get user ID
  Future<String> getUserID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map tokens = json.decode(preferences.get("tokens"));
    final Map uid = tokens["userData"];

    return uid['_id'].toString();
  }

  //Get user Email
  Future<String> getUserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map tokens = json.decode(preferences.get("tokens"));
    final Map email = tokens["userData"];

    return email['email'].toString();
  }
  
  //Send user profile image 
  Future<Map<String, dynamic>> changeUserImage(io.File imagemPerfil) async {
    return await updateImageUser(imagemPerfil);
  }

  Future<Map<String, dynamic>> updateImageUser(io.File imagemPerfil) async {
    Response response;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('tokenjwt');

    Dio dio = Dio();
    dio.options.headers = {
      'Content-type': 'multipart/form-data',
      'Accept': 'application/json',
      'x-access-token': token
    };

    String fileName = imagemPerfil.path.split('/').last;

    FormData payload = FormData.fromMap({
      "caminho_foto":
          await MultipartFile.fromFile(imagemPerfil.path, filename: fileName)
    });

    try {
      var id = await getUserID();
      String url = ConexaoAPI().api + 'usuario_image/$id';

      response = await dio.patch(url, data: payload);
      await response.data;
      return {'mensage': 'Change Image sucessful', 'code': response.statusCode};
    } on DioError catch (e) {
      return {
        'message': e.response.data['msg'],
        'code': e.response.data['code']
      };
    }
  }

  //Change dados
  Future<Map<String, dynamic>> changeUser(
    String nome,
    String email,
    String uf,
    String cidade,
    String bairro,
    String logradouro,
    String phone, 
  ) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = await UserBloc().getUserEmail();
    var token = prefs.getString('tokenjwt');
    String url = ConexaoAPI().api + 'usuarioUpdate/$email';
    Map<String, String> headers = {
      "Accept": "application/json",
      "x-access-token": token
    };

    Map payload = {
       "nome": nome,
        "email": email,
        "uf" : uf,
        "cidade" : cidade,
        "bairro" : bairro,
        "logradouro" : logradouro,
        "fone_1": phone,
    };

    try{
      http.Response response = await http.put(url, headers: headers, body: payload);
      //await LoginBloc().saveUserAuthentication(jsonDecode(response.body));

      return {
        'message' : 'Change data successeful',
        'code' : response.statusCode
      };    
    }catch(err){ 
      return {
        'message' : err.response.data['msg'],
        'code': 400
      };
    }
  }

  @override
  void dispose() {
    _imageUser.close();
  }
}