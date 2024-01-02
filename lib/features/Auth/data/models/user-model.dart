class UserModel {
  bool? success;
  UserData? userData;

  UserModel({this.success, this.userData});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (userData != null) {
      data['userData'] = userData!.toJson();
    }
    return data;
  }
}

class UserData {
  String? id;
  String? name;
  String? phone;
  String? nid;
  String? type;
  String? email;
  String? password;
  String? status;

  UserData(
      {this.id,
      this.name,
      this.phone,
      this.nid,
      this.type,
      this.email,
      this.password,
      this.status});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    nid = json['nid'];
    type = json['type'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['nid'] = nid;
    data['type'] = type;
    data['email'] = email;
    data['password'] = password;
    data['status'] = status;
    return data;
  }
}
