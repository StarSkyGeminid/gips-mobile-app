part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeOnInitial extends HomeEvent {
  const HomeOnInitial();
}