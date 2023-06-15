import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'drawing_event.dart';
part 'drawing_state.dart';

class DrawingBloc extends Bloc<DrawingEvent, DrawingState> {
  DrawingBloc() : super(DrawingInitial()) {
    on<DrawingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
