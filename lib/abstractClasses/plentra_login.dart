abstract class PlentraLogin {
  void onSuccess(String token);

  void onLoading();

  void onInvalidEmailId();

  void onEmailIdNotProvided();

  void onPasswordNotProvided();

  void onInvalidCredentials();

  void onLoadfinished();

  void onError(dynamic error);
}
