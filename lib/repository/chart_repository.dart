import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sunrisescrob/api/endpoint/chart_top_artists_endpoint.dart';
import 'package:sunrisescrob/api/endpoint/chart_top_tags_endpoint.dart';
import 'package:sunrisescrob/api/endpoint/chart_top_tracks_endpoint.dart';
import 'package:sunrisescrob/api/last_fm_api_service.dart';
import 'package:sunrisescrob/api/response/mapper/response_mapper.dart';
import 'package:sunrisescrob/model/app_error.dart';
import 'package:sunrisescrob/model/chart/chart_artist.dart';
import 'package:sunrisescrob/model/chart/chart_track.dart';
import 'package:sunrisescrob/model/result.dart';
import 'package:sunrisescrob/model/tag.dart';

part 'chart_repository.g.dart';

abstract class ChartRepository {
  Future<Result<List<ChartArtist>>> getChartArtists(int page);
  Future<Result<List<ChartTrack>>> getChartTracks(int page);
  Future<Result<List<Tag>>> getChartTags(int page);
}

@Riverpod(dependencies: [lastFmApiService])
ChartRepository chartRepository(Ref ref) {
  return _ChartRepositoryImpl(ref.read(lastFmApiServiceProvider));
}

class _ChartRepositoryImpl implements ChartRepository {
  final LastFmApiService _lastFmApiService;

  const _ChartRepositoryImpl(this._lastFmApiService);

  @override
  Future<Result<List<ChartArtist>>> getChartArtists(int page) async {
    final endpoint = ChartTopArtistsEndpoint(
      params: {
        'page': page.toString(),
        'limit': '10',
      },
    );
    try {
      final result = await _lastFmApiService.request(endpoint);
      return Result.success(result.toChartArtistList());
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }

  @override
  Future<Result<List<ChartTrack>>> getChartTracks(int page) async {
    final endpoint = ChartTopTracksEndpoint(
      params: {
        'page': page.toString(),
        'limit': '10',
      },
    );
    try {
      final result = await _lastFmApiService.request(endpoint);
      return Result.success(result.toChartTrackList());
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }

  @override
  Future<Result<List<Tag>>> getChartTags(int page) async {
    final endpoint = ChartTopTagsEndpoint(
      params: {
        'page': page.toString(),
        'limit': '10',
      },
    );
    try {
      final result = await _lastFmApiService.request(endpoint);
      return Result.success(result.toTagList());
    } on Exception catch (error) {
      return Result.failure(AppError.getApiError(error));
    }
  }
}
