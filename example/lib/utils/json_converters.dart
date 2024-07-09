import 'package:freezed_annotation/freezed_annotation.dart';

class StringToBoolC extends JsonConverter<bool, String> {
  const StringToBoolC();

  @override
  bool fromJson(String json) => switch (json) {
        "true" => true,
        "false" => false,
        _ => throw Exception("Incorrect string passed to be converted to bool: $json."),
      };

  @override
  String toJson(bool object) => switch (object) {
        true => "true",
        false => "false",
      };
}
