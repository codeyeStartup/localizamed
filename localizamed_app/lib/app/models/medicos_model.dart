class Medicos {
  final String sId;
  final String nome;
  final String especialidade;
  final String cidade;
  final String caminhoFoto;
  final String sexo;
  final String temFoto;


  Medicos({this.sId,this.nome, this.cidade, this.caminhoFoto, this.especialidade, this.temFoto, this.sexo});

  factory Medicos.fromJson(Map<String, dynamic> json) {
    return Medicos(
      sId: json['_id'] as String,
      nome: json['nome'] as String,
      especialidade: json['especialidade'] as String,
      cidade: json['cidade'] as String,
      temFoto: json['temFoto'] as String,
      caminhoFoto: json['caminho_foto'] as String,
      sexo: json['sexo'] as String
    );
  }
}