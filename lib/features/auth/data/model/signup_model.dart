class SignupModel {
  String? id;
  String? displayName;
  String? accessToken;
  String? refreshToken;

  SignupModel({
    this.id,
    this.displayName,
    this.accessToken,
    this.refreshToken,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
    id: json["_id"],
    displayName: json["displayName"],
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "displayName": displayName,
    "access_token": accessToken,
    "refresh_token": refreshToken,
  };
}
