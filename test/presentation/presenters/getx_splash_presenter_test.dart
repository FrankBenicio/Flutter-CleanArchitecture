import 'package:ForDev/domain/usecases/usecases.dart';
import 'package:ForDev/ui/pages/pages.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class GetXSplashPresenter implements SplashPresenter {

  final LoadCurrentAccount loadCurrentAccount;

  var _navigateTo = RxString();

  Future checkAccount() async {
    await loadCurrentAccount.load();
  }

  Stream<String> get navigateToStream => _navigateTo.stream;

  GetXSplashPresenter({@required this.loadCurrentAccount});
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount{}

void main() {
  test('Should call LoadCurrentAccount', () async {
    final loadCurrentAccount = LoadCurrentAccountSpy();
    final sut = GetXSplashPresenter(loadCurrentAccount: loadCurrentAccount);

    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });
}
