// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twistapi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) {
  return Episode(
    json['id'] as int,
    json['source'] as String,
    json['number'] as int,
    json['anime_id'] as int,
    json['create_at'] as String,
    json['updated_at'] as String,
  );
}

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'id': instance.id,
      'source': instance.source,
      'number': instance.number,
      'anime_id': instance.animeId,
      'create_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
