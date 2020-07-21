import 'dart:io';

import 'package:build_cli_annotations/build_cli_annotations.dart';
import 'package:json_annotation/json_annotation.dart';

part 'main.g.dart';

@CliOptions()
@JsonSerializable(
  anyMap: true,
  checked: true,
  disallowUnrecognizedKeys: true,
  nullable: false,
)
class Configuration {
  @CliOption(abbr: 'n', help: 'this is the name', nullable: true)
  @JsonKey(required: true)
  final String name;

  @CliOption(abbr: 'c', help: 'this is the count', defaultsTo: 0)
  @JsonKey(required: true)
  final int count;

  bool help;

  Configuration({this.name, this.count, this.help}) {
    if (help != true && name.isEmpty) {
      throw ArgumentError.value(name, 'name', 'Cannot be empty.');
    }

    if (help != true && count <= 0) {
      throw ArgumentError.value(count, 'count', 'Should be positive.');
    }
  }

  factory Configuration.fromJson(Map json) => _$ConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$ConfigurationToJson(this);

  @override
  String toString() => 'Configuration: ${toJson()}';
}

void main(List<String> arguments) {
  final config = parseConfiguration(arguments);

  if (config.help == true) {
    print(_$parserForConfiguration.usage);
  }

  print(config.toString());
}