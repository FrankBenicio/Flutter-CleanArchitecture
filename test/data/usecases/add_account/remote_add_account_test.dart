import 'package:ForDev/data/http/http.dart';
import 'package:ForDev/data/usecases/usecases.dart';
import 'package:ForDev/domain/helpers/helpers.dart';
import 'package:ForDev/domain/usecases/usecases.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class HttpClientSpy extends Mock implements HttpClient<Map> {}

void main() {
  RemoteAddAccount sut;
  HttpClientSpy httpClient;
  Uri url;
  AddAccountParams params;

  Map mockValidData() =>
      {'accessToken': faker.guid.guid(), 'name': faker.person.name()};

  PostExpectation _mockRequest() {
    return when(httpClient.request(
        url: anyNamed("url"),
        method: anyNamed("method"),
        body: anyNamed("body")));
  }

  void mockHttpError(HttpError error) {
    _mockRequest().thenThrow(error);
  }

  void mockHttpData(Map data) {
    _mockRequest().thenAnswer((_) async => data);
  }

  setUp(() {
    httpClient = HttpClientSpy();
    url = Uri.parse(faker.internet.httpsUrl());
    sut = RemoteAddAccount(httpClient: httpClient, url: url);
    String password = faker.internet.password();
    params = AddAccountParams(
        email: faker.internet.email(),
        password: password,
        passwordConfirmation: password,
        name: faker.person.name());

    mockHttpData(mockValidData());
  });

  test("Should call HttpClient with correct values", () async {
    await sut.add(params);

    verify(httpClient.request(url: url, method: 'post', body: {
      'email': params.email,
      'name': params.name,
      'password': params.password,
      'passwordConfirmation': params.passwordConfirmation
    }));
  });

  test("Should throw UnexpectedError if HttpClient returns 400", () async {
    mockHttpError(HttpError.badRequest);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test("Should throw UnexpectedError if HttpClient returns 404", () async {
    mockHttpError(HttpError.notFound);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test("Should throw UnexpectedError if HttpClient returns 500", () async {
    mockHttpError(HttpError.serverError);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test("Should throw EmailInUse if HttpClient returns 403", () async {
    mockHttpError(HttpError.forbidden);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.emailInUse));
  });

  test("Should return an Account if HttpClient returns 200", () async {
    final validData = mockValidData();
    mockHttpData(validData);

    final account = await sut.add(params);

    expect(account.token, validData['accessToken']);
  });

  test("Should throw UnexpectedError if HttpClient returns 200 with invalid data", () async {

    mockHttpData({'invalid_key': 'invalid_value' });

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });
}
