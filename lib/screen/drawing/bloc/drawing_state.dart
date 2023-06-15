part of 'drawing_bloc.dart';

abstract class DrawingState extends Equatable {
  const DrawingState();
  
  @override
  List<Object> get props => [];
}

class DrawingInitial extends DrawingState {}
