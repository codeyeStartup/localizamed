class Search_model {
  Id iId;

  Search_model({this.iId});

  Search_model.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId.toJson();
    }
    return data;
  }
}

class Id {
  String nome;
  String id;
  String cidade;

  Id({this.nome, this.id, this.cidade});

  Id.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    id = json['id'];
    cidade = json['cidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['id'] = this.id;
    data['cidade'] = this.cidade;
    return data;
  }
}
