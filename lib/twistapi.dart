import 'package:json_annotation/json_annotation.dart';

part 'twistapi.g.dart';

/* 
  {
    "id": 62095,
    "source": "U2FsdGVkX185EMQDTmdtyZq579OtcuzyDkm4TiV+fiArkt83pCEqr09c8eKFYEO4CNqSDhzR47RImpeikNWRcV31iEXh2R/5SnJrkJTdilA=",
    "number": 915,
    "anime_id": 638,
    "created_at": "2019-12-22 03:36:56",
    "updated_at": "2019-12-22 03:36:56"
  }
*/
@JsonSerializable()
class Episode {
  final int id;
  final String source;
  final int number;

  @JsonKey(name: 'anime_id')
  final int animeId;
  @JsonKey(name: 'create_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  Episode(
    this.id,
    this.source,
    this.number,
    this.animeId,
    this.createdAt,
    this.updatedAt,
  );
  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}
