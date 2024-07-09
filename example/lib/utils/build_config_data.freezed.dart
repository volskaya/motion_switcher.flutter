// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'build_config_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BuildConfigData _$BuildConfigDataFromJson(Map<String, dynamic> json) {
  return _BuildConfigData.fromJson(json);
}

/// @nodoc
mixin _$BuildConfigData {
// Reserved props.
//
// Do not edit these in the .settings files, these will be written programatically.
  String get name => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError; // Settings.
  @StringToBoolC()
  bool get tests => throw _privateConstructorUsedError;
  @StringToBoolC()
  bool get firebaseMocks => throw _privateConstructorUsedError;
  @StringToBoolC()
  bool get emulators => throw _privateConstructorUsedError;
  String get emulatorHost => throw _privateConstructorUsedError;
  BuildConfigLoggerLevel get loggerLevel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BuildConfigDataCopyWith<BuildConfigData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BuildConfigDataCopyWith<$Res> {
  factory $BuildConfigDataCopyWith(
          BuildConfigData value, $Res Function(BuildConfigData) then) =
      _$BuildConfigDataCopyWithImpl<$Res, BuildConfigData>;
  @useResult
  $Res call(
      {String name,
      String path,
      @StringToBoolC() bool tests,
      @StringToBoolC() bool firebaseMocks,
      @StringToBoolC() bool emulators,
      String emulatorHost,
      BuildConfigLoggerLevel loggerLevel});
}

/// @nodoc
class _$BuildConfigDataCopyWithImpl<$Res, $Val extends BuildConfigData>
    implements $BuildConfigDataCopyWith<$Res> {
  _$BuildConfigDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? path = null,
    Object? tests = null,
    Object? firebaseMocks = null,
    Object? emulators = null,
    Object? emulatorHost = null,
    Object? loggerLevel = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      tests: null == tests
          ? _value.tests
          : tests // ignore: cast_nullable_to_non_nullable
              as bool,
      firebaseMocks: null == firebaseMocks
          ? _value.firebaseMocks
          : firebaseMocks // ignore: cast_nullable_to_non_nullable
              as bool,
      emulators: null == emulators
          ? _value.emulators
          : emulators // ignore: cast_nullable_to_non_nullable
              as bool,
      emulatorHost: null == emulatorHost
          ? _value.emulatorHost
          : emulatorHost // ignore: cast_nullable_to_non_nullable
              as String,
      loggerLevel: null == loggerLevel
          ? _value.loggerLevel
          : loggerLevel // ignore: cast_nullable_to_non_nullable
              as BuildConfigLoggerLevel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BuildConfigDataImplCopyWith<$Res>
    implements $BuildConfigDataCopyWith<$Res> {
  factory _$$BuildConfigDataImplCopyWith(_$BuildConfigDataImpl value,
          $Res Function(_$BuildConfigDataImpl) then) =
      __$$BuildConfigDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String path,
      @StringToBoolC() bool tests,
      @StringToBoolC() bool firebaseMocks,
      @StringToBoolC() bool emulators,
      String emulatorHost,
      BuildConfigLoggerLevel loggerLevel});
}

/// @nodoc
class __$$BuildConfigDataImplCopyWithImpl<$Res>
    extends _$BuildConfigDataCopyWithImpl<$Res, _$BuildConfigDataImpl>
    implements _$$BuildConfigDataImplCopyWith<$Res> {
  __$$BuildConfigDataImplCopyWithImpl(
      _$BuildConfigDataImpl _value, $Res Function(_$BuildConfigDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? path = null,
    Object? tests = null,
    Object? firebaseMocks = null,
    Object? emulators = null,
    Object? emulatorHost = null,
    Object? loggerLevel = null,
  }) {
    return _then(_$BuildConfigDataImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      tests: null == tests
          ? _value.tests
          : tests // ignore: cast_nullable_to_non_nullable
              as bool,
      firebaseMocks: null == firebaseMocks
          ? _value.firebaseMocks
          : firebaseMocks // ignore: cast_nullable_to_non_nullable
              as bool,
      emulators: null == emulators
          ? _value.emulators
          : emulators // ignore: cast_nullable_to_non_nullable
              as bool,
      emulatorHost: null == emulatorHost
          ? _value.emulatorHost
          : emulatorHost // ignore: cast_nullable_to_non_nullable
              as String,
      loggerLevel: null == loggerLevel
          ? _value.loggerLevel
          : loggerLevel // ignore: cast_nullable_to_non_nullable
              as BuildConfigLoggerLevel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BuildConfigDataImpl implements _BuildConfigData {
  const _$BuildConfigDataImpl(
      {required this.name,
      required this.path,
      @StringToBoolC() this.tests = false,
      @StringToBoolC() this.firebaseMocks = false,
      @StringToBoolC() this.emulators = false,
      this.emulatorHost = "127.0.0.1",
      this.loggerLevel = BuildConfigLoggerLevel.all});

  factory _$BuildConfigDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$BuildConfigDataImplFromJson(json);

// Reserved props.
//
// Do not edit these in the .settings files, these will be written programatically.
  @override
  final String name;
  @override
  final String path;
// Settings.
  @override
  @JsonKey()
  @StringToBoolC()
  final bool tests;
  @override
  @JsonKey()
  @StringToBoolC()
  final bool firebaseMocks;
  @override
  @JsonKey()
  @StringToBoolC()
  final bool emulators;
  @override
  @JsonKey()
  final String emulatorHost;
  @override
  @JsonKey()
  final BuildConfigLoggerLevel loggerLevel;

  @override
  String toString() {
    return 'BuildConfigData(name: $name, path: $path, tests: $tests, firebaseMocks: $firebaseMocks, emulators: $emulators, emulatorHost: $emulatorHost, loggerLevel: $loggerLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BuildConfigDataImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.tests, tests) || other.tests == tests) &&
            (identical(other.firebaseMocks, firebaseMocks) ||
                other.firebaseMocks == firebaseMocks) &&
            (identical(other.emulators, emulators) ||
                other.emulators == emulators) &&
            (identical(other.emulatorHost, emulatorHost) ||
                other.emulatorHost == emulatorHost) &&
            (identical(other.loggerLevel, loggerLevel) ||
                other.loggerLevel == loggerLevel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, path, tests, firebaseMocks,
      emulators, emulatorHost, loggerLevel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BuildConfigDataImplCopyWith<_$BuildConfigDataImpl> get copyWith =>
      __$$BuildConfigDataImplCopyWithImpl<_$BuildConfigDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BuildConfigDataImplToJson(
      this,
    );
  }
}

abstract class _BuildConfigData implements BuildConfigData {
  const factory _BuildConfigData(
      {required final String name,
      required final String path,
      @StringToBoolC() final bool tests,
      @StringToBoolC() final bool firebaseMocks,
      @StringToBoolC() final bool emulators,
      final String emulatorHost,
      final BuildConfigLoggerLevel loggerLevel}) = _$BuildConfigDataImpl;

  factory _BuildConfigData.fromJson(Map<String, dynamic> json) =
      _$BuildConfigDataImpl.fromJson;

  @override // Reserved props.
//
// Do not edit these in the .settings files, these will be written programatically.
  String get name;
  @override
  String get path;
  @override // Settings.
  @StringToBoolC()
  bool get tests;
  @override
  @StringToBoolC()
  bool get firebaseMocks;
  @override
  @StringToBoolC()
  bool get emulators;
  @override
  String get emulatorHost;
  @override
  BuildConfigLoggerLevel get loggerLevel;
  @override
  @JsonKey(ignore: true)
  _$$BuildConfigDataImplCopyWith<_$BuildConfigDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
