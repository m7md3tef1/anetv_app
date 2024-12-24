/// id : 2
/// name : "alaa alaa"
/// email : "nobody6683b00c5c7b9@alaanetstreaming.com"

class UsersModel {
  UsersModel({
    num? id,
    String? name,
    String? email,
  }) {
    _id = id;
    _name = name;
    _email = email;
  }

  UsersModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
  }
  num? _id;
  String? _name;
  String? _email;
  UsersModel copyWith({
    num? id,
    String? name,
    String? email,
  }) =>
      UsersModel(
        id: id ?? _id,
        name: name ?? _name,
        email: email ?? _email,
      );
  num? get id => _id;
  String? get name => _name;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    return map;
  }
}
