part of 'drawing_cubit.dart';

@freezed
class DrawingState with _$DrawingState {
  const factory DrawingState({
    @Default([]) List<DrawingPoint> historyDrawingPoints,
    @Default([]) List<DrawingPoint> drawingPoints,
    @Default(false) bool isFinished,
    GameRoom? gameRoom,
    @Default(false) isDrawing,
    @Default([]) List<AnswerModel> answers,
  }) = _DrawingState;
}
