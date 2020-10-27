class Medic_info {
  String sId;
  String nome;

  Medic_info({this.sId, this.nome});

  Medic_info.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['nome'] = this.nome;
  }
}
