part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

@JsonSerializable()
class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.message = '',
    this.currentTabIndex = 0,
  });

  final HomeStatus status;

  final String message;

  @JsonKey(includeFromJson: false)
  final int currentTabIndex;

  HomeState copyWith({
    HomeStatus? status,
    String? message,
    int? currentTabIndex,
  }) {
    return HomeState(
      status: status ?? this.status,
      message: message ?? this.message,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }

  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);

  Map<String, dynamic> toJson() => _$HomeStateToJson(this);

  @override
  List<Object> get props => [
        status,
        message,
        currentTabIndex,
      ];
}
