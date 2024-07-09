// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'build_config_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BuildConfigDataImpl _$$BuildConfigDataImplFromJson(
        Map<String, dynamic> json) =>
    _$BuildConfigDataImpl(
      name: json['name'] as String,
      path: json['path'] as String,
      tests: json['tests'] == null
          ? false
          : const StringToBoolC().fromJson(json['tests'] as String),
      firebaseMocks: json['firebaseMocks'] == null
          ? false
          : const StringToBoolC().fromJson(json['firebaseMocks'] as String),
      emulators: json['emulators'] == null
          ? false
          : const StringToBoolC().fromJson(json['emulators'] as String),
      emulatorHost: json['emulatorHost'] as String? ?? "127.0.0.1",
      loggerLevel: $enumDecodeNullable(
              _$BuildConfigLoggerLevelEnumMap, json['loggerLevel']) ??
          BuildConfigLoggerLevel.all,
    );

Map<String, dynamic> _$$BuildConfigDataImplToJson(
        _$BuildConfigDataImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
      'tests': const StringToBoolC().toJson(instance.tests),
      'firebaseMocks': const StringToBoolC().toJson(instance.firebaseMocks),
      'emulators': const StringToBoolC().toJson(instance.emulators),
      'emulatorHost': instance.emulatorHost,
      'loggerLevel': _$BuildConfigLoggerLevelEnumMap[instance.loggerLevel]!,
    };

const _$BuildConfigLoggerLevelEnumMap = {
  BuildConfigLoggerLevel.all: 'all',
  BuildConfigLoggerLevel.trace: 'trace',
  BuildConfigLoggerLevel.debug: 'debug',
  BuildConfigLoggerLevel.info: 'info',
  BuildConfigLoggerLevel.warning: 'warning',
  BuildConfigLoggerLevel.error: 'error',
  BuildConfigLoggerLevel.fatal: 'fatal',
  BuildConfigLoggerLevel.off: 'off',
};
