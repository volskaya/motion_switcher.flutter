import 'package:app/utils/json_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';

part "build_config_data.freezed.dart";
part "build_config_data.g.dart";
part "build_config_fields.dart";

@freezed
class BuildConfigData with _$BuildConfigData {
  const factory BuildConfigData({
    // Reserved props.
    //
    // Do not edit these in the .settings files, these will be written programatically.
    required String name,
    required String path,

    // Settings.
    @Default(false) @StringToBoolC() bool tests,
    @Default(false) @StringToBoolC() bool firebaseMocks,
    @Default(false) @StringToBoolC() bool emulators,
    @Default("127.0.0.1") String emulatorHost,
    @Default(BuildConfigLoggerLevel.all) BuildConfigLoggerLevel loggerLevel,
  }) = _BuildConfigData;

  factory BuildConfigData.fromJson(Map<String, dynamic> json) => _$BuildConfigDataFromJson(json);
}
