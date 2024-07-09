// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alert_service_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AlertServiceState {
  List<AlertEntry> get alerts => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AlertServiceStateCopyWith<AlertServiceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertServiceStateCopyWith<$Res> {
  factory $AlertServiceStateCopyWith(
          AlertServiceState value, $Res Function(AlertServiceState) then) =
      _$AlertServiceStateCopyWithImpl<$Res, AlertServiceState>;
  @useResult
  $Res call({List<AlertEntry> alerts});
}

/// @nodoc
class _$AlertServiceStateCopyWithImpl<$Res, $Val extends AlertServiceState>
    implements $AlertServiceStateCopyWith<$Res> {
  _$AlertServiceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alerts = null,
  }) {
    return _then(_value.copyWith(
      alerts: null == alerts
          ? _value.alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as List<AlertEntry>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlertServiceStateImplCopyWith<$Res>
    implements $AlertServiceStateCopyWith<$Res> {
  factory _$$AlertServiceStateImplCopyWith(_$AlertServiceStateImpl value,
          $Res Function(_$AlertServiceStateImpl) then) =
      __$$AlertServiceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<AlertEntry> alerts});
}

/// @nodoc
class __$$AlertServiceStateImplCopyWithImpl<$Res>
    extends _$AlertServiceStateCopyWithImpl<$Res, _$AlertServiceStateImpl>
    implements _$$AlertServiceStateImplCopyWith<$Res> {
  __$$AlertServiceStateImplCopyWithImpl(_$AlertServiceStateImpl _value,
      $Res Function(_$AlertServiceStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alerts = null,
  }) {
    return _then(_$AlertServiceStateImpl(
      alerts: null == alerts
          ? _value._alerts
          : alerts // ignore: cast_nullable_to_non_nullable
              as List<AlertEntry>,
    ));
  }
}

/// @nodoc

class _$AlertServiceStateImpl extends _AlertServiceState {
  _$AlertServiceStateImpl({final List<AlertEntry> alerts = const []})
      : _alerts = alerts,
        super._();

  final List<AlertEntry> _alerts;
  @override
  @JsonKey()
  List<AlertEntry> get alerts {
    if (_alerts is EqualUnmodifiableListView) return _alerts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alerts);
  }

  @override
  String toString() {
    return 'AlertServiceState(alerts: $alerts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertServiceStateImpl &&
            const DeepCollectionEquality().equals(other._alerts, _alerts));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_alerts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertServiceStateImplCopyWith<_$AlertServiceStateImpl> get copyWith =>
      __$$AlertServiceStateImplCopyWithImpl<_$AlertServiceStateImpl>(
          this, _$identity);
}

abstract class _AlertServiceState extends AlertServiceState {
  factory _AlertServiceState({final List<AlertEntry> alerts}) =
      _$AlertServiceStateImpl;
  _AlertServiceState._() : super._();

  @override
  List<AlertEntry> get alerts;
  @override
  @JsonKey(ignore: true)
  _$$AlertServiceStateImplCopyWith<_$AlertServiceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AlertEntry {
  String get key => throw _privateConstructorUsedError;
  Alert get alert => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AlertEntryCopyWith<AlertEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertEntryCopyWith<$Res> {
  factory $AlertEntryCopyWith(
          AlertEntry value, $Res Function(AlertEntry) then) =
      _$AlertEntryCopyWithImpl<$Res, AlertEntry>;
  @useResult
  $Res call({String key, Alert alert});

  $AlertCopyWith<$Res> get alert;
}

/// @nodoc
class _$AlertEntryCopyWithImpl<$Res, $Val extends AlertEntry>
    implements $AlertEntryCopyWith<$Res> {
  _$AlertEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? alert = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      alert: null == alert
          ? _value.alert
          : alert // ignore: cast_nullable_to_non_nullable
              as Alert,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AlertCopyWith<$Res> get alert {
    return $AlertCopyWith<$Res>(_value.alert, (value) {
      return _then(_value.copyWith(alert: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AlertEntryImplCopyWith<$Res>
    implements $AlertEntryCopyWith<$Res> {
  factory _$$AlertEntryImplCopyWith(
          _$AlertEntryImpl value, $Res Function(_$AlertEntryImpl) then) =
      __$$AlertEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String key, Alert alert});

  @override
  $AlertCopyWith<$Res> get alert;
}

/// @nodoc
class __$$AlertEntryImplCopyWithImpl<$Res>
    extends _$AlertEntryCopyWithImpl<$Res, _$AlertEntryImpl>
    implements _$$AlertEntryImplCopyWith<$Res> {
  __$$AlertEntryImplCopyWithImpl(
      _$AlertEntryImpl _value, $Res Function(_$AlertEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? alert = null,
  }) {
    return _then(_$AlertEntryImpl(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      alert: null == alert
          ? _value.alert
          : alert // ignore: cast_nullable_to_non_nullable
              as Alert,
    ));
  }
}

/// @nodoc

class _$AlertEntryImpl extends _AlertEntry {
  const _$AlertEntryImpl({required this.key, required this.alert}) : super._();

  @override
  final String key;
  @override
  final Alert alert;

  @override
  String toString() {
    return 'AlertEntry(key: $key, alert: $alert)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertEntryImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.alert, alert) || other.alert == alert));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key, alert);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertEntryImplCopyWith<_$AlertEntryImpl> get copyWith =>
      __$$AlertEntryImplCopyWithImpl<_$AlertEntryImpl>(this, _$identity);
}

abstract class _AlertEntry extends AlertEntry {
  const factory _AlertEntry(
      {required final String key,
      required final Alert alert}) = _$AlertEntryImpl;
  const _AlertEntry._() : super._();

  @override
  String get key;
  @override
  Alert get alert;
  @override
  @JsonKey(ignore: true)
  _$$AlertEntryImplCopyWith<_$AlertEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Alert {
  Duration? get duration => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, String caption, Duration? duration)
        error,
    required TResult Function(String title, String caption, Duration? duration)
        message,
    required TResult Function(Duration? duration) unimplementedTemplate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, String caption, Duration? duration)? error,
    TResult? Function(String title, String caption, Duration? duration)?
        message,
    TResult? Function(Duration? duration)? unimplementedTemplate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, String caption, Duration? duration)? error,
    TResult Function(String title, String caption, Duration? duration)? message,
    TResult Function(Duration? duration)? unimplementedTemplate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AlertError value) error,
    required TResult Function(_AlertMessage value) message,
    required TResult Function(_AlertUnimplementedTemplate value)
        unimplementedTemplate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AlertError value)? error,
    TResult? Function(_AlertMessage value)? message,
    TResult? Function(_AlertUnimplementedTemplate value)? unimplementedTemplate,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AlertError value)? error,
    TResult Function(_AlertMessage value)? message,
    TResult Function(_AlertUnimplementedTemplate value)? unimplementedTemplate,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AlertCopyWith<Alert> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlertCopyWith<$Res> {
  factory $AlertCopyWith(Alert value, $Res Function(Alert) then) =
      _$AlertCopyWithImpl<$Res, Alert>;
  @useResult
  $Res call({Duration? duration});
}

/// @nodoc
class _$AlertCopyWithImpl<$Res, $Val extends Alert>
    implements $AlertCopyWith<$Res> {
  _$AlertCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? duration = freezed,
  }) {
    return _then(_value.copyWith(
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlertErrorImplCopyWith<$Res> implements $AlertCopyWith<$Res> {
  factory _$$AlertErrorImplCopyWith(
          _$AlertErrorImpl value, $Res Function(_$AlertErrorImpl) then) =
      __$$AlertErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String caption, Duration? duration});
}

/// @nodoc
class __$$AlertErrorImplCopyWithImpl<$Res>
    extends _$AlertCopyWithImpl<$Res, _$AlertErrorImpl>
    implements _$$AlertErrorImplCopyWith<$Res> {
  __$$AlertErrorImplCopyWithImpl(
      _$AlertErrorImpl _value, $Res Function(_$AlertErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? caption = null,
    Object? duration = freezed,
  }) {
    return _then(_$AlertErrorImpl(
      null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      null == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc

class _$AlertErrorImpl extends _AlertError {
  const _$AlertErrorImpl(this.title, this.caption,
      {this.duration = Alert.defaultDuration})
      : super._();

  @override
  final String title;
  @override
  final String caption;
  @override
  @JsonKey()
  final Duration? duration;

  @override
  String toString() {
    return 'Alert.error(title: $title, caption: $caption, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertErrorImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, caption, duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertErrorImplCopyWith<_$AlertErrorImpl> get copyWith =>
      __$$AlertErrorImplCopyWithImpl<_$AlertErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, String caption, Duration? duration)
        error,
    required TResult Function(String title, String caption, Duration? duration)
        message,
    required TResult Function(Duration? duration) unimplementedTemplate,
  }) {
    return error(title, caption, duration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, String caption, Duration? duration)? error,
    TResult? Function(String title, String caption, Duration? duration)?
        message,
    TResult? Function(Duration? duration)? unimplementedTemplate,
  }) {
    return error?.call(title, caption, duration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, String caption, Duration? duration)? error,
    TResult Function(String title, String caption, Duration? duration)? message,
    TResult Function(Duration? duration)? unimplementedTemplate,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(title, caption, duration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AlertError value) error,
    required TResult Function(_AlertMessage value) message,
    required TResult Function(_AlertUnimplementedTemplate value)
        unimplementedTemplate,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AlertError value)? error,
    TResult? Function(_AlertMessage value)? message,
    TResult? Function(_AlertUnimplementedTemplate value)? unimplementedTemplate,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AlertError value)? error,
    TResult Function(_AlertMessage value)? message,
    TResult Function(_AlertUnimplementedTemplate value)? unimplementedTemplate,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _AlertError extends Alert {
  const factory _AlertError(final String title, final String caption,
      {final Duration? duration}) = _$AlertErrorImpl;
  const _AlertError._() : super._();

  String get title;
  String get caption;
  @override
  Duration? get duration;
  @override
  @JsonKey(ignore: true)
  _$$AlertErrorImplCopyWith<_$AlertErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AlertMessageImplCopyWith<$Res>
    implements $AlertCopyWith<$Res> {
  factory _$$AlertMessageImplCopyWith(
          _$AlertMessageImpl value, $Res Function(_$AlertMessageImpl) then) =
      __$$AlertMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String caption, Duration? duration});
}

/// @nodoc
class __$$AlertMessageImplCopyWithImpl<$Res>
    extends _$AlertCopyWithImpl<$Res, _$AlertMessageImpl>
    implements _$$AlertMessageImplCopyWith<$Res> {
  __$$AlertMessageImplCopyWithImpl(
      _$AlertMessageImpl _value, $Res Function(_$AlertMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? caption = null,
    Object? duration = freezed,
  }) {
    return _then(_$AlertMessageImpl(
      null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      null == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc

class _$AlertMessageImpl extends _AlertMessage {
  const _$AlertMessageImpl(this.title, this.caption,
      {this.duration = Alert.defaultDuration})
      : super._();

  @override
  final String title;
  @override
  final String caption;
  @override
  @JsonKey()
  final Duration? duration;

  @override
  String toString() {
    return 'Alert.message(title: $title, caption: $caption, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertMessageImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, caption, duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertMessageImplCopyWith<_$AlertMessageImpl> get copyWith =>
      __$$AlertMessageImplCopyWithImpl<_$AlertMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, String caption, Duration? duration)
        error,
    required TResult Function(String title, String caption, Duration? duration)
        message,
    required TResult Function(Duration? duration) unimplementedTemplate,
  }) {
    return message(title, caption, duration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, String caption, Duration? duration)? error,
    TResult? Function(String title, String caption, Duration? duration)?
        message,
    TResult? Function(Duration? duration)? unimplementedTemplate,
  }) {
    return message?.call(title, caption, duration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, String caption, Duration? duration)? error,
    TResult Function(String title, String caption, Duration? duration)? message,
    TResult Function(Duration? duration)? unimplementedTemplate,
    required TResult orElse(),
  }) {
    if (message != null) {
      return message(title, caption, duration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AlertError value) error,
    required TResult Function(_AlertMessage value) message,
    required TResult Function(_AlertUnimplementedTemplate value)
        unimplementedTemplate,
  }) {
    return message(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AlertError value)? error,
    TResult? Function(_AlertMessage value)? message,
    TResult? Function(_AlertUnimplementedTemplate value)? unimplementedTemplate,
  }) {
    return message?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AlertError value)? error,
    TResult Function(_AlertMessage value)? message,
    TResult Function(_AlertUnimplementedTemplate value)? unimplementedTemplate,
    required TResult orElse(),
  }) {
    if (message != null) {
      return message(this);
    }
    return orElse();
  }
}

abstract class _AlertMessage extends Alert {
  const factory _AlertMessage(final String title, final String caption,
      {final Duration? duration}) = _$AlertMessageImpl;
  const _AlertMessage._() : super._();

  String get title;
  String get caption;
  @override
  Duration? get duration;
  @override
  @JsonKey(ignore: true)
  _$$AlertMessageImplCopyWith<_$AlertMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AlertUnimplementedTemplateImplCopyWith<$Res>
    implements $AlertCopyWith<$Res> {
  factory _$$AlertUnimplementedTemplateImplCopyWith(
          _$AlertUnimplementedTemplateImpl value,
          $Res Function(_$AlertUnimplementedTemplateImpl) then) =
      __$$AlertUnimplementedTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Duration? duration});
}

/// @nodoc
class __$$AlertUnimplementedTemplateImplCopyWithImpl<$Res>
    extends _$AlertCopyWithImpl<$Res, _$AlertUnimplementedTemplateImpl>
    implements _$$AlertUnimplementedTemplateImplCopyWith<$Res> {
  __$$AlertUnimplementedTemplateImplCopyWithImpl(
      _$AlertUnimplementedTemplateImpl _value,
      $Res Function(_$AlertUnimplementedTemplateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? duration = freezed,
  }) {
    return _then(_$AlertUnimplementedTemplateImpl(
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc

class _$AlertUnimplementedTemplateImpl extends _AlertUnimplementedTemplate {
  const _$AlertUnimplementedTemplateImpl(
      {this.duration = Alert.defaultDuration})
      : super._();

  @override
  @JsonKey()
  final Duration? duration;

  @override
  String toString() {
    return 'Alert.unimplementedTemplate(duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlertUnimplementedTemplateImpl &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlertUnimplementedTemplateImplCopyWith<_$AlertUnimplementedTemplateImpl>
      get copyWith => __$$AlertUnimplementedTemplateImplCopyWithImpl<
          _$AlertUnimplementedTemplateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, String caption, Duration? duration)
        error,
    required TResult Function(String title, String caption, Duration? duration)
        message,
    required TResult Function(Duration? duration) unimplementedTemplate,
  }) {
    return unimplementedTemplate(duration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, String caption, Duration? duration)? error,
    TResult? Function(String title, String caption, Duration? duration)?
        message,
    TResult? Function(Duration? duration)? unimplementedTemplate,
  }) {
    return unimplementedTemplate?.call(duration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, String caption, Duration? duration)? error,
    TResult Function(String title, String caption, Duration? duration)? message,
    TResult Function(Duration? duration)? unimplementedTemplate,
    required TResult orElse(),
  }) {
    if (unimplementedTemplate != null) {
      return unimplementedTemplate(duration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AlertError value) error,
    required TResult Function(_AlertMessage value) message,
    required TResult Function(_AlertUnimplementedTemplate value)
        unimplementedTemplate,
  }) {
    return unimplementedTemplate(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AlertError value)? error,
    TResult? Function(_AlertMessage value)? message,
    TResult? Function(_AlertUnimplementedTemplate value)? unimplementedTemplate,
  }) {
    return unimplementedTemplate?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AlertError value)? error,
    TResult Function(_AlertMessage value)? message,
    TResult Function(_AlertUnimplementedTemplate value)? unimplementedTemplate,
    required TResult orElse(),
  }) {
    if (unimplementedTemplate != null) {
      return unimplementedTemplate(this);
    }
    return orElse();
  }
}

abstract class _AlertUnimplementedTemplate extends Alert {
  const factory _AlertUnimplementedTemplate({final Duration? duration}) =
      _$AlertUnimplementedTemplateImpl;
  const _AlertUnimplementedTemplate._() : super._();

  @override
  Duration? get duration;
  @override
  @JsonKey(ignore: true)
  _$$AlertUnimplementedTemplateImplCopyWith<_$AlertUnimplementedTemplateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
