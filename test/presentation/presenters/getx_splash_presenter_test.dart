import 'package:ForDev/domain/models/models.dart';
import 'package:ForDev/domain/usecases/usecases.dart';
import 'package:ForDev/presentation/presenters/presenters.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';



class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {
  LoadCurrentAccountSpy loadCurrentAccount;

  GetXSplashPresenter sut;

  PostExpectation mockLoadCurrentAccountCall() =>
      when(loadCurrentAccount.load());

  mockLoadCurrentAccount({Account account}) {
    mockLoadCurrentAccountCall().thenAnswer((_) async => account);
  }

  mockLoadCurrentAccountError() {
    mockLoadCurrentAccountCall().thenThrow(Exception());
  }

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();

    sut = GetXSplashPresenter(loadCurrentAccount: loadCurrentAccount);

    mockLoadCurrentAccount(account: Account(faker.guid.guid()));
  });

  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount(durationInSeconds: 0);

    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should go to surveys page on success', () async {
    sut.navigateToStream.listen((page) => expect(page, '/surveys'));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on null result', () async {
    mockLoadCurrentAccount(account: null);

    sut.navigateToStream.listen((page) => expect(page, '/login'));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on null token', () async {
    mockLoadCurrentAccount(account: Account(null));

    sut.navigateToStream.listen((page) => expect(page, '/login'));

    await sut.checkAccount(durationInSeconds: 0);
  });

  test('Should go to login page on error', () async {
    mockLoadCurrentAccountError();

    sut.navigateToStream.listen((page) => expect(page, '/login'));

    await sut.checkAccount(durationInSeconds: 0);
  });
}
