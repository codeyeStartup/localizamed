import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/blocs/conexaoAPI.dart';
import 'package:localizamed_app/components/tab_clinica.dart';

List<Clinicas> parseClinicas(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Clinicas>((json) => Clinicas.fromJson(json)).toList();
}

Future<List<Clinicas>> getClinicas(http.Client client) async {
  final response = await http.get(Uri.encodeFull(ConexaoAPI().api + 'clinicas'),
      headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
    return parseClinicas(response.body);
  } else {
    print("Entrou no exception de erro");
    throw Exception('Falha ao carregar Clinicas');
  }
}

class Clinicas {
  final String nome;
  final String razaoSocial;
  final String email;
  final String cnpj;
  final num latitute;
  final num longitude;
  final String descricao;
  final String cidade;
  final String bairro;
  final String uf;
  final String fone_1;
  final String fone_2;
  final String caminhoFoto;

  Clinicas(
      {this.nome,
      this.razaoSocial,
      this.email,
      this.cnpj,
      this.latitute,
      this.longitude,
      this.descricao,
      this.cidade,
      this.bairro,
      this.uf,
      this.fone_1,
      this.fone_2,
      this.caminhoFoto});

  factory Clinicas.fromJson(Map<String, dynamic> json) {
    return Clinicas(
      nome: json['nome'] as String,
      razaoSocial: json['razao_social'] as String,
      email: json['email'] as String,
      cnpj: json['cnpj'] as String,
      latitute: json['latitude'] as num,
      longitude: json['longitude'] as num,
      descricao: json['descricao'] as String,
      cidade: json['cidade'] as String,
      bairro: json['bairro'] as String,
      uf: json['uf'] as String,
      fone_1: json['fone_1'] as String,
      fone_2: json['fone_2'] as String,
      caminhoFoto: json['caminho_foto'] as String
    );
  }
}

//void main() => runApp(ClinCard());
