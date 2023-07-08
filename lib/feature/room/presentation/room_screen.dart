import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gips/core/bloc/status/bloc_status.dart';
import 'package:gips/core/bloc/user_cubit/user_cubit.dart';
import 'package:gips/core/component/dialog/show_loading_dialog.dart';
import 'package:gips/core/component/snackbar/info_snackbar.dart';
import 'package:gips/core/route/app_route_name.dart';
import 'package:gips/core/theme/app_color.dart';
import 'package:gips/feature/room/presentation/cubit/room_cubit.dart';
import 'package:gips/global/constans.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoomCubit(repo: GetIt.I.get())..getRooms(),
      child: const RoomLayout(),
    );
  }
}

class RoomLayout extends StatefulWidget {
  const RoomLayout({super.key});

  @override
  State<RoomLayout> createState() => _RoomLayoutState();
}

class _RoomLayoutState extends State<RoomLayout> {
  final refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.purple,
        centerTitle: true,
        title: Text(
          "Room",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: AppColor.white),
        ),
      ),
      body: BlocConsumer<RoomCubit, RoomState>(
        listener: (context, state) async {
          if (state.status.isSuccess) {
            if (refreshController.isLoading) {
              refreshController.loadComplete();
            }

            if (refreshController.isRefresh) {
              refreshController.refreshCompleted();
            }
          }

          if (state.joinStatus.isLoading) {
            showLoadingDialog(context);
          }

          if (state.joinStatus.isSuccess) {
            Navigator.pop(context);
            await Navigator.pushNamed(
              context,
              AppRouteName.drawingRoom,
              arguments: [state.roomId, state.duration],
            );

            await Future.delayed(const Duration(seconds: 1));
            if (!mounted) return;
            context.read<RoomCubit>().getRooms();
            return;
          }

          if (state.joinStatus.isError) {
            Navigator.pop(context);
            showInfoSnackBar(
              context,
              state.errorMessage ?? "Something wrong, when creating the Room",
            );
          }
        },
        builder: (context, state) {
          if (state.status.isInitial || state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status.isError) {
            return SmartRefresher(
              controller: refreshController,
              enablePullDown: true,
              enablePullUp: false,
              onRefresh: context.read<RoomCubit>().getRooms,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Terjadi kesalahan, harap coba lagi !",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                ),
              ),
            );
          }

          if (state.status.isSuccess && state.rooms.isEmpty) {
            return SmartRefresher(
              controller: refreshController,
              enablePullDown: true,
              enablePullUp: false,
              onRefresh: context.read<RoomCubit>().getRooms,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Flexible(
                      child: Text(
                        "Tidak ada room online tersedia. Coba buat room.",
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

          return SmartRefresher(
            controller: refreshController,
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: context.read<RoomCubit>().getRooms,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              itemCount: state.rooms.length,
              separatorBuilder: (_, __) {
                return const SizedBox(height: 12);
              },
              itemBuilder: (context, index) {
                final room = state.rooms[index];

                return InkWell(
                  onTap: () {
                    final username = context.read<UserCubit>().state.username;
                    context.read<RoomCubit>().joinRoom(room.id ?? "", username);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Room ID : ${room.id?.split("-")[0] ?? "-"}",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "${room.id}",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "${room.totalPlayer}/${room.maxPlayer}",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(kDefaultSpacing),
        child: ElevatedButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRouteName.createRoom),
            child: const Padding(
              padding: EdgeInsets.all(kDefaultSpacing),
              child: Text('Buat Room'),
            )),
      ),
    );
  }
}
