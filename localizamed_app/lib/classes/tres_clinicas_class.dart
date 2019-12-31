class TresClinicas {
  List<Clinica3> clinicas;
  TresClinicas({this.clinicas});

  TresClinicas.fromJson(Map<String, dynamic> json) {
    if (json['clinicas'] != null) {
      clinicas = new List<Clinica3>();
      json['clinicas'].forEach((v) {
        clinicas.add(new Clinica3.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clinicas != null) {
      data['clinicas'] = this.clinicas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Clinica3 {
  String sId;
  String nome;
  String email;
  String cidade;
  String caminhoFoto;

  Clinica3(
      {this.sId,
      this.nome,
      this.email,
      this.cidade,
      this.caminhoFoto,
});

  Clinica3.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nome = json['nome'];
    cidade = json['cidade'];
    caminhoFoto = json['caminho_foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['nome'] = this.nome;
    data['cidade'] = this.cidade;
    data['caminho_foto'] = this.caminhoFoto;
    return data;
  }
}

/* class TresClinicas {
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
} */