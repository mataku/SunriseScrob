import 'package:freezed_annotation/freezed_annotation.dart';

part 'top_tags_response.freezed.dart';
part 'top_tags_response.g.dart';

@JsonSerializable(explicitToJson: true)
class TopTagsResponse {
  @JsonKey(name: 'tag')
  final List<TagResponse> tagsResponse;

  const TopTagsResponse({
    required this.tagsResponse,
  });

  factory TopTagsResponse.fromJson(Map<String, dynamic> json) {
    // Sometimes Last.fm API returns non list.
    // it seems return map if tag's count is 1.
    //
    // "tags": {
    //   "tag": {
    //     "url": "https://www.last.fm/tag/2023",
    //     "name": "2023"
    //   }
    // },
    //
    //
    //
    if (json['tag'] is Map<String, dynamic>) {
      final TagResponse tagResponse = _TagResponse.fromJson(json['tag']);
      return TopTagsResponse(tagsResponse: [tagResponse]);
    } else {
      return _$TopTagsResponseFromJson(json);
    }
  }

  Map<String, dynamic> toJson() => _$TopTagsResponseToJson(this);
}

@freezed
abstract class TagResponse with _$TagResponse {
  const factory TagResponse({
    required String name,
    required String url,
  }) = _TagResponse;

  factory TagResponse.fromJson(Map<String, dynamic> json) =>
      _$TagResponseFromJson(json);
}
