import 'package:ForDev/domain/models/models.dart';
import 'package:ForDev/domain/usecases/usecases.dart';
import 'package:ForDev/ui/pages/pages.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';
import 'package:faker/faker.dart';

class GetXSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;

  var _navigateTo = RxString();

  Future checkAccount() async {
    final account = await loadCurrentAccount.load();
    _navigateTo.value = account == null ? '/login' : '/surveys';
  }

  Stream<String> get navigateToStream => _navigateTo.stream;

  GetXSplashPresenter({@required this.loadCurrentAccount});
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {
  LoadCurrentAccountSpy loadCurrentAccount;

  GetXSplashPresenter sut;

  mockLoadCurrentAccount({Account account}) {
    when(loadCurrentAccount.load()).thenAnswer((_) async => account);
  }

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();

    sut = GetXSplashPresenter(loadCurrentAccount: loadCurrentAccount);

    mockLoadCurrentAccount(account: Account(faker.guid.guid()));
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should go to surveys page on success', () async {
    sut.navigateToStream.listen((page) => expect(page, '/surveys'));

    await sut.checkAccount();
  });

  test('Should go to login page on null resut', () async {
    mockLoadCurrentAccount(account: null);

    sut.navigateToStream.listen((page) => expect(page, '/login'));

    await sut.checkAccount();
  });
}
