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
  final textController = TextEditingController();
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
          child: BlocBuilder<DrawingCubit, DrawingState>(
            builder: (context, state) {
              return GestureDetector(
                onPanStart: (details) {
                  if (state.gameRoom?.currentPlayer?.username == username) {
                    context
                        .read<DrawingCubit>()
                        .onPanStart(offset: details.localPosition);
                  }
                },
                onPanUpdate: (details) {
                  if (state.gameRoom?.currentPlayer?.username == username) {
                    context
                        .read<DrawingCubit>()
                        .onPanUpdate(offset: details.localPosition);
                  }
                },
                onPanEnd: (_) {
                  if (state.gameRoom?.currentPlayer?.username == username) {
                    context.read<DrawingCubit>().onPanEnd();
                  }
                },
                child: CustomPaint(
                  painter: DrawingPainter(
                    drawingPoints: state.drawingPoints,
                  ),
                  child: Container(),
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 35,
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: AppColor.purple,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: BlocBuilder<DrawingCubit, DrawingState>(
                      buildWhen: (previous, current) {
                        return previous.answers.length !=
                            current.answers.length;
                      },
                      builder: (context, state) {
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
                    if (state.gameRoom?.currentPlayer?.username == username) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
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
                            ?.firstWhere((e) => e.username == username)
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
          ),
        )
      ],
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
