import 'package:flutter_app_first/my/models/json_placeholder_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'json_placeholder_model_test.mocks.dart';

@GenerateMocks([], customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {
  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      final client = MockHttpClient();
      final model = JsonPlaceholderModel(client: client);

      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async =>
            http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200),
      );

      final album = await model.fetchAlbum();

      expect(album.userId, 1);
      expect(album.id, 2);
      expect(album.title, 'mock');
    });

    test('requests a random album from 1 to 100 as json', () async {
      final client = MockHttpClient();
      final model = JsonPlaceholderModel(client: client);

      when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async =>
            http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200),
      );

      await model.fetchAlbum();

      final captured = verify(
        client.get(captureAny, headers: captureAnyNamed('headers')),
      ).captured;
      final url = captured[0] as Uri;
      final headers = captured[1] as Map<String, String>;

      expect(url.origin, 'https://jsonplaceholder.typicode.com');
      expect(url.pathSegments.first, 'albums');
      expect(int.parse(url.pathSegments.last), inInclusiveRange(1, 100));
      expect(headers, {'Accept': 'application/json'});
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockHttpClient();
      final model = JsonPlaceholderModel(client: client);

      when(
        client.get(any, headers: anyNamed('headers')),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(model.fetchAlbum(), throwsException);
    });

    test('throws a FormatException if the json has the wrong shape', () {
      final client = MockHttpClient();
      final model = JsonPlaceholderModel(client: client);

      when(
        client.get(any, headers: anyNamed('headers')),
      ).thenAnswer((_) async => http.Response('{"title": "no ids"}', 200));

      expect(model.fetchAlbum(), throwsFormatException);
    });
  });
}
