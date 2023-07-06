import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gips/core/bloc/user_cubit/user_cubit.dart';
import 'package:gips/core/theme/app_color.dart';

import '../../model/drawing_point.dart';
import '../cubit/drawing_cubit.dart';

class DrawingCanvas extends StatefulWidget {
  const DrawingCanvas({super.key});

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  String username = "";

  @override
  void initState() {
    username = context.read<UserCubit>().state.username;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 65,
          child: _DrawingBox(username: username),
        ),
        Expanded(
          flex: 35,
          child: BlocBuilder<DrawingCubit, DrawingState>(
            buildWhen: (previous, current) =>
                previous.isDrawing != current.isDrawing ||
                previous.gameRoom?.currentAnswer !=
                    current.gameRoom?.currentAnswer,
            builder: (context, state) {
              return state.isDrawing
                  ? const _HintBox()
                  : _AnswerBox(username: username);
            },
          ),
        )
      ],
    );
  }
}

class _ProggressIndicator extends StatefulWidget {
  const _ProggressIndicator();

  @override
  State<_ProggressIndicator> createState() => _ProggressIndicatorState();
}

class _ProggressIndicatorState extends State<_ProggressIndicator> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BlocBuilder<DrawingCubit, DrawingState>(
        buildWhen: (previous, current) =>
            previous.gameRoom?.currentDuration !=
            current.gameRoom?.currentDuration,
        builder: (context, state) => LinearProgressIndicator(
          value: (state.gameRoom?.currentDuration?.toDouble() ?? 60) / 60,
          minHeight: 5,
          backgroundColor: AppColor.grey,
          valueColor: const AlwaysStoppedAnimation<Color>(AppColor.yellow),
          semanticsLabel: 'Linear progress indicator',
        ),
      ),
    );
  }
}

class _HintBox extends StatefulWidget {
  const _HintBox();

  @override
  State<_HintBox> createState() => _HintBoxState();
}

class _HintBoxState extends State<_HintBox> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColor.purple,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const _ProggressIndicator(),
          const Spacer(),
          BlocBuilder<DrawingCubit, DrawingState>(
            builder: (context, state) {
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    state.gameRoom?.currentAnswer ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: AppColor.primaryColor),
                  ),
                ),
              );
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _AnswerBox extends StatefulWidget {
  const _AnswerBox({
    required this.username,
  });

  final String username;

  @override
  State<_AnswerBox> createState() => _AnswerBoxState();
}

class _AnswerBoxState extends State<_AnswerBox> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColor.purple,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: _ProggressIndicator(),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                border: Border.all(),
                borderRadius: BorderRadius.circular(16),
              ),
              child: BlocBuilder<DrawingCubit, DrawingState>(
                buildWhen: (previous, current) {
                  return previous.answers.length != current.answers.length ||
                      previous.isDrawing != current.isDrawing;
                },
                builder: (context, state) {
                  if (state.isDrawing) {
                    return const SizedBox.shrink();
                  }

                  return ListView.separated(
                    reverse: true,
                    padding: const EdgeInsets.all(16),
                    itemCount: state.answers.length,
                    separatorBuilder: (_, __) {
                      return const Divider(
                        height: 2,
                        thickness: 1,
                      );
                    },
                    itemBuilder: (context, index) {
                      final data = state.answers[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${data.username} : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              TextSpan(
                                text: data.answer,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: data.isSystem
                                          ? Colors.blue
                                          : data.isCorrect
                                              ? Colors.green
                                              : null,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          BlocBuilder<DrawingCubit, DrawingState>(
            builder: (context, state) {
              if (state.isDrawing) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: AppColor.purple,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      state.gameRoom?.currentAnswer ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColor.white),
                    ),
                  ),
                );
              }

              if (state.gameRoom?.connectedClients
                      ?.firstWhere((e) => e.username == widget.username)
                      .isAnswered ==
                  true) {
                return const SizedBox();
              }

              return Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: textController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    hintText: "Jawab disini",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    textController.clear();
                    context.read<DrawingCubit>().sendAnswer(value);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class _DrawingBox extends StatelessWidget {
  const _DrawingBox({
    required this.username,
  });

  final String username;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawingCubit, DrawingState>(
      builder: (context, state) {
        return Stack(
          children: [
            Center(child: Image.asset('assets/images/gips_background.png')),
            GestureDetector(
              onPanStart: (details) {
                if (state.isDrawing) {
                  context
                      .read<DrawingCubit>()
                      .onPanStart(offset: details.localPosition);
                }
              },
              onPanUpdate: (details) {
                if (state.isDrawing) {
                  context
                      .read<DrawingCubit>()
                      .onPanUpdate(offset: details.localPosition);
                }
              },
              onPanEnd: (_) {
                if (state.isDrawing) {
                  context.read<DrawingCubit>().onPanEnd();
                }
              },
              child: CustomPaint(
                painter: DrawingPainter(
                  drawingPoints: state.drawingPoints,
                ),
                child: Container(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<DrawingPoint> drawingPoints;

  DrawingPainter({required this.drawingPoints});

  final _paint = Paint()
    ..color = Colors.black
    ..isAntiAlias = true
    ..strokeWidth = 2
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    for (var drawingPoint in drawingPoints) {
      for (var i = 0; i < drawingPoint.offsets.length; i++) {
        var notLastOffset = i != drawingPoint.offsets.length - 1;

        if (notLastOffset) {
          final current = drawingPoint.offsets[i];
          final next = drawingPoint.offsets[i + 1];
          canvas.drawLine(
            Offset(current.dx, current.dy),
            Offset(next.dx, next.dy),
            _paint,
          );
        } else {
          // do Nothing
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
