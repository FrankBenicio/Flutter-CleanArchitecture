import 'package:ForDev/data/http/http.dart';
import 'package:ForDev/data/usecases/usecases.dart';
import 'package:ForDev/domain/helpers/helpers.dart';
import 'package:ForDev/domain/models/models.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  HttpClientSpy httpClient;
  RemoteLoadSurveys sut;
  Uri url;
  List<Map> list;

  List<Map> mockValidData() => [
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(50),
          'didAnswer': faker.randomGenerator.boolean(),
          'date': faker.date.dateTime().toIso8601String(),
        },
        {
          'id': faker.guid.guid(),
          'question': faker.randomGenerator.string(50),
          'didAnswer': faker.randomGenerator.boolean(),
          'date': faker.date.dateTime().toIso8601String(),
        }
      ];

  PostExpectation _mockRequest() {
    return when(
        httpClient.request(url: anyNamed("url"), method: anyNamed("method")));
  }

  void mockHttpData(List<Map> data) {
    list = data;

    _mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error) {
    _mockRequest().thenThrow(error);
  }

  setUp(() {
    url = Uri.parse(faker.internet.httpUrl());

    httpClient = HttpClientSpy();

    sut = RemoteLoadSurveys(url: url, httpClient: httpClient);

    mockHttpData(mockValidData());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load();

    verify(httpClient.request(url: url, method: 'get'));
  });

  test('Should return surveys on 200', () async {
    await sut.load();

    verify(httpClient.request(url: url, method: 'get'));
  });

  test('Should return surveys on 200', () async {
    final surveys = await sut.load();

    expect(surveys, [
      Survey(
        id: list[0]['id'],
        question: list[0]['question'],
        didAnswer: list[0]['didAnswer'],
        dateTime: DateTime.parse(list[0]['date']),
      ),
      Survey(
        id: list[1]['id'],
        question: list[1]['question'],
        didAnswer: list[1]['didAnswer'],
        dateTime: DateTime.parse(list[1]['date']),
      )
    ]);
  });

  test(
      'Should throw UnexpectedError if HttpClient return 200 with invalid data',
      () async {
    mockHttpData([
      {'invalid_key': 'invalid_value'}
    ]);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test("Should throw UnexpectedError if HttpClient returns 404", () async {
    mockHttpError(HttpError.notFound);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test("Should throw UnexpectedError if HttpClient returns 500", () async {
    mockHttpError(HttpError.serverError);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test("Should throw AccessDinedError if HttpClient returns 403", () async {
    mockHttpError(HttpError.forbidden);

    final future = sut.load();

    expect(future, throwsA(DomainError.accessDenied));
  });
}
