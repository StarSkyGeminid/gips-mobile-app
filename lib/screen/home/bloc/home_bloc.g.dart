// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeState _$HomeStateFromJson(Map<String, dynamic> json) => HomeState(
      status: $enumDecodeNullable(_$HomeStatusEnumMap, json['status']) ??
          HomeStatus.initial,
      message: json['message'] as String? ?? '',
    );

Map<String, dynamic> _$HomeStateToJson(HomeState instance) => <String, dynamic>{
      'status': _$HomeStatusEnumMap[instance.status]!,
      'message': instance.message,
    };

const _$HomeStatusEnumMap = {
  HomeStatus.initial: 'initial',
  HomeStatus.loading: 'loading',
  HomeStatus.success: 'success',
  HomeStatus.failure: 'failure',
};
