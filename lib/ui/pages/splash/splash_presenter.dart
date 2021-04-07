abstract class SplashPresenter {
  Stream<String> get navigateToStream;

  Future checkAccount({int durationInSeconds});
}