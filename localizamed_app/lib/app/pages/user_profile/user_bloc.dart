import 'dart:async';
import 'dart:io';
import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:localizamed_app/app/models/user_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/app/utils/conexaoAPI.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc {
  BehaviorSubject<File> _imageUser = BehaviorSubject<File>();
  Stream<File> get imageUser => _imageUser.stream;

  void changeImage(File file) {
    _imageUser.add(file);
  }

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

  Future<Map<String, dynamic>> changeUserImage(io.File imagemPerfil) async {
    return await updateImageUser(imagemPerfil);
  }

  Future<Map<String, dynamic>> updateImageUser(io.File imagemPerfil) async {
    Response response;

    Dio dio = Dio();
    dio.options.headers = {
      'Content-type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authtorization': 'token'
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

  @override
  void dispose() {
    _imageUser.close();
  }
}

/* final userBloc = UserBloc(); */
