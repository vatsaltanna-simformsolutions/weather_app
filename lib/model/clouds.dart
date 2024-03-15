import 'package:json_annotation/json_annotation.dart';

part 'clouds.g.dart';

@JsonSerializable()
class Clouds {
  @JsonKey(name: "all")
  final int? all;

  Clouds({
    this.all,
  });

  Clouds copyWith({
    int? all,
  }) =>
      Clouds(
        all: all ?? this.all,
      );

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}
