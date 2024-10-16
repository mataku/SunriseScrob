import 'package:dio/dio.dart';
import 'package:sunrisescrob/api/endpoint/endpoint.dart';
import 'package:sunrisescrob/api/response/chart/chart_top_tags_api_response.dart';

class ChartTopTagsEndpoint extends Endpoint<ChartTopTagsApiResponse> {
  ChartTopTagsEndpoint({
    super.path = '/2.0/?method=chart.gettoptags',
    required super.params,
    super.requestType = RequestType.get,
  });

  @override
  ChartTopTagsApiResponse parseFromJson(Response response) {
    return ChartTopTagsApiResponse.fromJson(response.data);
  }
}
