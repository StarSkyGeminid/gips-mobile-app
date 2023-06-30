import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gips/core/bloc/user_cubit/user_cubit.dart';
import 'package:gips/core/theme/app_color.dart';
import 'package:gips/feature/draw/presentation/cubit/drawing_cubit.dart';
import 'package:gips/feature/draw/presentation/widget/rank_drawer_widget.dart';
import 'package:gips/feature/draw/presentation/widget/rank_view.dart';
import 'package:gips/global/constans.dart';

import 'widget/drawing_canvas.dart';

class DrawingRoomScreen extends StatelessWidget {
  const DrawingRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final username = context.read<UserCubit>().state.username;

    return BlocProvider(
      create: (context) => DrawingCubit(
        id: id,
        username: username,
      ),
      child: BlocBuilder<DrawingCubit, DrawingState>(
        buildWhen: (previous, current) =>
            previous.isFinished != current.isFinished,
        builder: (context, state) {
          return state.isFinished
              ? RankView(gameRoom: state.gameRoom!)
              : const DrawingRoom();
        },
      ),
    );
  }
}

class DrawingRoom extends StatefulWidget {
  const DrawingRoom({super.key});

  @override
  State<DrawingRoom> createState() => _DrawingRoomState();
}

class _DrawingRoomState extends State<DrawingRoom> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isPauseDialogOpen = false;
  String username = "";

  Duration defaultDuration = const Duration(seconds: 30);
  Timer? timer;
  Duration currentDuration = Duration.zero;

  @override
  void initState() {
    username = context.read<UserCubit>().state.username;
    super.initState();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  void startTimer({bool startOver = true}) {
    /// only start over if the timer is null
    if (timer != null) return;

    if (startOver) {
      currentDuration = defaultDuration;
    }
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentDuration -= const Duration(seconds: 1);
      context.read<DrawingCubit>().playerTicker(currentDuration.inSeconds);
      if (currentDuration.inSeconds == 0) {
        context.read<DrawingCubit>().playerTimeout();
        stopTimer();
      }
    });
  }

  void stopTimer() {
    /// only stop  if the timer is not null
    if (timer == null) return;

    timer?.cancel();
    timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.read<DrawingCubit>().disconnectWebsocket();
        return Future.value(true);
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<DrawingCubit, DrawingState>(
            listenWhen: (previous, current) {
              return previous.gameRoom?.isPlaying !=
                  current.gameRoom?.isPlaying;
            },
            listener: (context, state) async {
              if (state.gameRoom?.isPlaying == false) {
                stopTimer();
                isPauseDialogOpen = true;
                final result = await showWaitingDialog(
                  context,
                ) as bool?;
                if (result == true) {
                  if (!mounted) return;
                  Navigator.pop(context);
                }
              } else {
                if (state.gameRoom?.currentPlayer?.username == username) {
                  startTimer();
                }
                if (isPauseDialogOpen) {
                  isPauseDialogOpen = false;
                  Navigator.pop(context);
                }
              }
            },
          ),
          BlocListener<DrawingCubit, DrawingState>(
            listenWhen: (previous, current) {
              final currentLength =
                  current.gameRoom?.connectedClients?.length ?? 0;
              final previousLength =
                  previous.gameRoom?.connectedClients?.length ?? 0;
              return currentLength > previousLength;
            },
            listener: (context, state) {
              final username = state.gameRoom?.connectedClients?.last.username;
              context.read<DrawingCubit>().notifyFromSysteminChat(
                  "$username bergabung dalam permainan");
            },
          ),
          BlocListener<DrawingCubit, DrawingState>(
            listenWhen: (previous, current) {
              final currentLength =
                  current.gameRoom?.connectedClients?.length ?? 0;
              final previousLength =
                  previous.gameRoom?.connectedClients?.length ?? 0;
              return currentLength < previousLength;
            },
            listener: (context, state) {
              context
                  .read<DrawingCubit>()
                  .notifyFromSysteminChat("Satu pemain keluar dari permainan");
            },
          ),
          BlocListener<DrawingCubit, DrawingState>(
            listenWhen: (previous, current) {
              return previous.gameRoom?.currentPlayer !=
                  current.gameRoom?.currentPlayer;
            },
            listener: (context, state) {
              context.read<DrawingCubit>().notifyFromSysteminChat(
                    "${state.gameRoom?.currentPlayer?.username} giliran menggambar",
                  );

              if (state.gameRoom?.currentPlayer?.username == username) {
                if (state.gameRoom?.isPlaying == true) {
                  startTimer();
                }
              } else {
                stopTimer();
              }
            },
          ),
        ],
        child: Scaffold(
          key: scaffoldKey,
          endDrawer: const RankDrawerWidget(),
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          body: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const DrawingCanvas(),
              ),
              BlocBuilder<DrawingCubit, DrawingState>(
                builder: (context, state) {
                  return Positioned(
                    top: MediaQuery.of(context).padding.top + 24,
                    left: 16,
                    right: 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FloatingActionButton(
                          heroTag: "Back",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        const Spacer(),
                        if (state.gameRoom?.currentPlayer?.username ==
                            username) ...[
                          FloatingActionButton(
                            heroTag: "Undo",
                            onPressed: context.read<DrawingCubit>().undoDrawing,
                            child: const Icon(Icons.undo),
                          ),
                          const SizedBox(width: 16),
                          FloatingActionButton(
                            heroTag: "Redo",
                            onPressed: context.read<DrawingCubit>().redoDrawing,
                            child: const Icon(Icons.redo),
                          ),
                        ],
                        const SizedBox(width: 16),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                scaffoldKey.currentState?.openEndDrawer();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(32),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  CupertinoIcons.chart_bar_alt_fill,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            BlocBuilder<DrawingCubit, DrawingState>(
                              buildWhen: (previous, current) {
                                return previous.gameRoom?.currentDuration !=
                                    current.gameRoom?.currentDuration;
                              },
                              builder: (context, state) {
                                final duration =
                                    state.gameRoom?.currentDuration ?? 0;
                                final textDuration =
                                    duration < 10 ? "0$duration" : "$duration";
                                return Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    border: Border.all(
                                      color: AppColor.primaryColor,
                                      width: 2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    textDuration,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                );
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<T?> showWaitingDialog<T>(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<DrawingCubit>(context),
          child: WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 8,
                    ),
                    child: Text(
                      "Menunggu Pemain Lain",
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: size.height * 0.3,
                    ),
                    child: BlocBuilder<DrawingCubit, DrawingState>(
                      builder: (context, state) {
                        return ListView.builder(
                          padding: const EdgeInsets.all(kDefaultSpacing),
                          itemCount:
                              state.gameRoom?.connectedClients?.length ?? 0,
                          itemBuilder: (context, index) {
                            final player =
                                state.gameRoom?.connectedClients?[index];
                            return Text(
                              "${index + 1}. ${player?.username ?? "-"}",
                              style: Theme.of(context).textTheme.titleMedium,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: CircularProgressIndicator(),
                  ),
                  BlocBuilder<DrawingCubit, DrawingState>(
                    buildWhen: (previous, current) =>
                        previous.gameRoom != current.gameRoom,
                    builder: (context, state) {
                      String username =
                          state.gameRoom?.connectedClients?[0].username ?? "";
                      bool canStart =
                          username == context.read<UserCubit>().state.username;

                      if (!canStart) {
                        return const SizedBox.shrink();
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultSpacing,
                        ),
                        child: SizedBox(
                          width: size.width,
                          child: ElevatedButton(
                            onPressed: (state.gameRoom?.connectedClients
                                            ?.length ??
                                        0) >
                                    1
                                ? () {
                                    context.read<DrawingCubit>().startGame();
                                  }
                                : null,
                            child: const Padding(
                              padding: EdgeInsets.all(kDefaultSpacing),
                              child: Text("Mulai"),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 8,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text("Batal"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
