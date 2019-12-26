class TresClinicas {
  final String id;
  final String nome;
  final String cidade;
  final String caminhoFoto;

  TresClinicas({this.id, this.nome, this.cidade, this.caminhoFoto});

  factory TresClinicas.fromJson(Map<String, dynamic> json) {
    return TresClinicas(
      id: json['_id'] as String,
      nome: json['nome'] as String,
      cidade: json['cidade'] as String,
      caminhoFoto: json['caminho_foto'] as String,
    );
  }
}