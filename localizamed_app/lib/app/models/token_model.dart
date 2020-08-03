class Token {
  String token;
  String refreshToken;
  UserData userData;

  Token({this.token, this.refreshToken, this.userData});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    if (this.userData != null) {
      data['userData'] = this.userData.toJson();
    }
    return data;
  }
}

class UserData {
  String sId;
  String email;

  UserData({this.sId, this.email});

  UserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    return data;
  }
}