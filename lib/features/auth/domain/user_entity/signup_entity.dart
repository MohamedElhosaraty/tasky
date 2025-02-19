class SignupEntity {
  final String id;
  final String displayName;
  final String accessToken;
  final String refreshToken;

  SignupEntity({
    required this.id,
    required this.displayName,
    required this.accessToken,
    required this.refreshToken,
  });
}
