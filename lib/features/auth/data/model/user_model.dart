class UserModel {
  String? id;
  String? accessToken;
  String? refreshToken;

  UserModel({
    this.id,
    this.accessToken,
    this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["_id"],
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "access_token": accessToken,
    "refresh_token": refreshToken,
  };
}
