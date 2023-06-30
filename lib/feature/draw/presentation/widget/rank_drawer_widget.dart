import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gips/core/theme/app_color.dart';
import 'package:gips/feature/draw/model/game_room.dart';
import 'package:gips/feature/draw/presentation/cubit/drawing_cubit.dart';

class RankDrawerWidget extends StatelessWidget {
  const RankDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawingCubit, DrawingState>(
      builder: (context, state) {
        final orderedList =
            List.of(state.gameRoom?.connectedClients ?? <GamePlayer>[])
              ..sort(
                (a, b) {
                  return b.score?.compareTo(a.score ?? 0) ?? 0;
                },
              );
        return Drawer(
          backgroundColor: AppColor.primaryColor,
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 32,
              bottom: 32,
            ),
            child: Column(
              children: [
                Text(
                  "Ranking",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: AppColor.white),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: orderedList.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final player = orderedList[index];

                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${index + 1}. ",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                          ),
                          Text(
                            player.username ?? "-",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                          ),
                          Text(
                            " (${player.score ?? 0} Skor)",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
