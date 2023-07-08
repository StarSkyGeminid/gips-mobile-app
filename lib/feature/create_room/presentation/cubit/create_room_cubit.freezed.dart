// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_room_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CreateRoomState {
  BlocStatus get status => throw _privateConstructorUsedError;
  BlocStatus get createStatus => throw _privateConstructorUsedError;
  BlocStatus get joinStatus => throw _privateConstructorUsedError;
  SettingsModel get settings => throw _privateConstructorUsedError;
  List<String> get themes => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  int get selectedTimer => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateRoomStateCopyWith<CreateRoomState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateRoomStateCopyWith<$Res> {
  factory $CreateRoomStateCopyWith(
          CreateRoomState value, $Res Function(CreateRoomState) then) =
      _$CreateRoomStateCopyWithImpl<$Res, CreateRoomState>;
  @useResult
  $Res call(
      {BlocStatus status,
      BlocStatus createStatus,
      BlocStatus joinStatus,
      SettingsModel settings,
      List<String> themes,
      String? errorMessage,
      int selectedTimer});

  $SettingsModelCopyWith<$Res> get settings;
}

/// @nodoc
class _$CreateRoomStateCopyWithImpl<$Res, $Val extends CreateRoomState>
    implements $CreateRoomStateCopyWith<$Res> {
  _$CreateRoomStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? createStatus = null,
    Object? joinStatus = null,
    Object? settings = null,
    Object? themes = null,
    Object? errorMessage = freezed,
    Object? selectedTimer = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BlocStatus,
      createStatus: null == createStatus
          ? _value.createStatus
          : createStatus // ignore: cast_nullable_to_non_nullable
              as BlocStatus,
      joinStatus: null == joinStatus
          ? _value.joinStatus
          : joinStatus // ignore: cast_nullable_to_non_nullable
              as BlocStatus,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as SettingsModel,
      themes: null == themes
          ? _value.themes
          : themes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedTimer: null == selectedTimer
          ? _value.selectedTimer
          : selectedTimer // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SettingsModelCopyWith<$Res> get settings {
    return $SettingsModelCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CreateRoomStateCopyWith<$Res>
    implements $CreateRoomStateCopyWith<$Res> {
  factory _$$_CreateRoomStateCopyWith(
          _$_CreateRoomState value, $Res Function(_$_CreateRoomState) then) =
      __$$_CreateRoomStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BlocStatus status,
      BlocStatus createStatus,
      BlocStatus joinStatus,
      SettingsModel settings,
      List<String> themes,
      String? errorMessage,
      int selectedTimer});

  @override
  $SettingsModelCopyWith<$Res> get settings;
}

/// @nodoc
class __$$_CreateRoomStateCopyWithImpl<$Res>
    extends _$CreateRoomStateCopyWithImpl<$Res, _$_CreateRoomState>
    implements _$$_CreateRoomStateCopyWith<$Res> {
  __$$_CreateRoomStateCopyWithImpl(
      _$_CreateRoomState _value, $Res Function(_$_CreateRoomState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? createStatus = null,
    Object? joinStatus = null,
    Object? settings = null,
    Object? themes = null,
    Object? errorMessage = freezed,
    Object? selectedTimer = null,
  }) {
    return _then(_$_CreateRoomState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BlocStatus,
      createStatus: null == createStatus
          ? _value.createStatus
          : createStatus // ignore: cast_nullable_to_non_nullable
              as BlocStatus,
      joinStatus: null == joinStatus
          ? _value.joinStatus
          : joinStatus // ignore: cast_nullable_to_non_nullable
              as BlocStatus,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as SettingsModel,
      themes: null == themes
          ? _value._themes
          : themes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedTimer: null == selectedTimer
          ? _value.selectedTimer
          : selectedTimer // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_CreateRoomState implements _CreateRoomState {
  const _$_CreateRoomState(
      {this.status = BlocStatus.initial,
      this.createStatus = BlocStatus.initial,
      this.joinStatus = BlocStatus.initial,
      this.settings = SettingsModel.empty,
      final List<String> themes = const [],
      this.errorMessage,
      this.selectedTimer = 30})
      : _themes = themes;

  @override
  @JsonKey()
  final BlocStatus status;
  @override
  @JsonKey()
  final BlocStatus createStatus;
  @override
  @JsonKey()
  final BlocStatus joinStatus;
  @override
  @JsonKey()
  final SettingsModel settings;
  final List<String> _themes;
  @override
  @JsonKey()
  List<String> get themes {
    if (_themes is EqualUnmodifiableListView) return _themes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_themes);
  }

  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final int selectedTimer;

  @override
  String toString() {
    return 'CreateRoomState(status: $status, createStatus: $createStatus, joinStatus: $joinStatus, settings: $settings, themes: $themes, errorMessage: $errorMessage, selectedTimer: $selectedTimer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreateRoomState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createStatus, createStatus) ||
                other.createStatus == createStatus) &&
            (identical(other.joinStatus, joinStatus) ||
                other.joinStatus == joinStatus) &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            const DeepCollectionEquality().equals(other._themes, _themes) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.selectedTimer, selectedTimer) ||
                other.selectedTimer == selectedTimer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      createStatus,
      joinStatus,
      settings,
      const DeepCollectionEquality().hash(_themes),
      errorMessage,
      selectedTimer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreateRoomStateCopyWith<_$_CreateRoomState> get copyWith =>
      __$$_CreateRoomStateCopyWithImpl<_$_CreateRoomState>(this, _$identity);
}

abstract class _CreateRoomState implements CreateRoomState {
  const factory _CreateRoomState(
      {final BlocStatus status,
      final BlocStatus createStatus,
      final BlocStatus joinStatus,
      final SettingsModel settings,
      final List<String> themes,
      final String? errorMessage,
      final int selectedTimer}) = _$_CreateRoomState;

  @override
  BlocStatus get status;
  @override
  BlocStatus get createStatus;
  @override
  BlocStatus get joinStatus;
  @override
  SettingsModel get settings;
  @override
  List<String> get themes;
  @override
  String? get errorMessage;
  @override
  int get selectedTimer;
  @override
  @JsonKey(ignore: true)
  _$$_CreateRoomStateCopyWith<_$_CreateRoomState> get copyWith =>
      throw _privateConstructorUsedError;
}
