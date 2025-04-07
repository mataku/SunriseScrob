# Last.fm client

Flutter Architecture Sample like Model-View-ViewModel using Last.fm API.

## Features
- Recent scrobbles
- Top tracks
- Top artists
- Account info
- Switch theme

## Screenshots

| Recent tracks | Album | Artist |
| :--: | :--: | :--: |
| ![](./misc/scrobble.png) | ![](./misc/album.png) | ![](./misc/artist.png) |

## Setup

### Prepare env

```
API_KEY=your_lastfm_api_key
SHARED_SECRET=your_lastfm_shared_secret
```

### Dependencies

```shell
# fvm flutter
flutter pub get --no-example && dart run build_runner build --delete-conflicting-outputs
```

## Architecture

- View (Flutter Widget)
- Presentation layer: ChangeNotifier
- Data layer: Repository (or use UseCase if there are complex business logic, various data type, or something) and class with freezed and json_serializable
- Domain layer: Dart Class with freezed:  [./lib/model/](./lib/model)

TODO: image

### HTTP request

uses Endpoint data class.

```dart
abstract class Endpoint<T> {
  final String path;
  final Map<String, String> params;
  final RequestType requestType;

  Endpoint({
    required this.path,
    required this.params,
    required this.requestType,
  });

  T parseFromJson(Response<dynamic> response);
}
```

```dart
// api client
abstract class LastFmApiService {
  Future<T> request<T>(Endpoint<T> endpoint);
}

class _LastFmApiServiceImpl extends LastFmApiService {
  final Dio _dio;

  _LastFmApiServiceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<T> request<T>(Endpoint<T> endpoint) async {
    final result = switch (endpoint.requestType) {
      RequestType.get => _get(endpoint),
      RequestType.post => _post(endpoint),
    };

    return result;
  }

  Future<T> _get<T>(Endpoint<T> endpoint) async {
    final response =
        await _dio.get(endpoint.path, queryParameters: endpoint.params);
    return endpoint.parseFromJson(response);
  }

  Future<T> _post<T>(Endpoint<T> endpoint) async {
    final response =
        await _dio.post(endpoint.path, queryParameters: endpoint.params);
    return endpoint.parseFromJson(response);
  }
}

```

Define the type returned for each endpoint. In the API Client, use the `request` method with defined type in endpoint: `Future<T> request<T>(Endpoint<T> endpoint)`

```dart
// GET
class RecentTracksEndpoint extends Endpoint<RecentTracksApiResponse> {
  RecentTracksEndpoint(
      {super.path = '/2.0/?method=user.getrecenttracks',
      required super.params,
      super.requestType = RequestType.get});

  @override
  RecentTracksApiResponse parseFromJson(Response response) {
    return RecentTracksApiResponse.fromJson(response.data);
  }
}

// usage
final recentEndpoint = RecentTrackEndpoint(params: {'username': 'mataku'});
// ref.read(lastFmApiServiceProvider)
final response = await lastFmApiService.request(recentEndpoint); // RecentTracksApiResponse type
```

# Licenses

See [LICENSE](./LICENSE).

This app uses [Noto Sans Japanese](https://fonts.google.com/noto/specimen/Noto+Sans+JP) in golden tests.
