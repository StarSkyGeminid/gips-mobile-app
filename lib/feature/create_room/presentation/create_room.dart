import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gips/core/bloc/status/bloc_status.dart';
import 'package:gips/core/bloc/user_cubit/user_cubit.dart';
import 'package:gips/core/component/snackbar/info_snackbar.dart';
import 'package:gips/core/route/app_route_name.dart';
import 'package:gips/global/constans.dart';
import 'package:get_it/get_it.dart';

import 'cubit/create_room_cubit.dart';

class CreateRoomScreen extends StatelessWidget {
  const CreateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateRoomCubit(repo: GetIt.I.get())..getThemes(),
      child: const CreateRoomLayout(),
    );
  }
}

class CreateRoomLayout extends StatefulWidget {
  const CreateRoomLayout({super.key});

  @override
  State<CreateRoomLayout> createState() => _CreateRoomLayoutState();
}

class _CreateRoomLayoutState extends State<CreateRoomLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<CreateRoomCubit, CreateRoomState>(
          listenWhen: (previous, current) =>
              previous.joinStatus != current.joinStatus,
          listener: (context, state) {
            if (state.joinStatus.isSuccess) {
              Navigator.pushReplacementNamed(context, AppRouteName.drawingRoom,
                  arguments: [
                    context.read<CreateRoomCubit>().state.settings.id,
                    context.read<CreateRoomCubit>().state.selectedTimer
                  ]);
            }
          },
          child: Container(
            margin: const EdgeInsets.all(kDefaultSpacing * 2),
            padding: const EdgeInsets.all(kDefaultSpacing),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'Buat Room',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const _TotalPlayerForm(),
                  const SizedBox(height: 16),
                  const _TotalRoundForm(),
                  const SizedBox(height: 16),
                  const _ThemeSelector(),
                  const SizedBox(height: 16),
                  const _DurationSelector(),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 56,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(kDefaultSpacing * .8),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: kDefaultSpacing),
                          child: Text('Buat'),
                        ),
                      ),
                      onPressed: () {
                        final username =
                            context.read<UserCubit>().state.username;
                        if (username.isEmpty) {
                          showInfoSnackBar(
                              context, "Username tidak boleh kosong");
                          return;
                        }

                        final totalPlayer = context
                            .read<CreateRoomCubit>()
                            .state
                            .settings
                            .maxPlayer;
                        if (totalPlayer < 2) {
                          showInfoSnackBar(
                              context, "Jumlah pemain minimal 2 orang");
                          return;
                        } else if (totalPlayer > 25) {
                          showInfoSnackBar(
                              context, "Jumlah pemain maksimal 25 orang");
                          return;
                        }

                        final totalRound = context
                            .read<CreateRoomCubit>()
                            .state
                            .settings
                            .maxRound;

                        if (totalRound < 1) {
                          showInfoSnackBar(context, "Jumlah ronde minimal 1");
                          return;
                        } else if (totalRound > 10) {
                          showInfoSnackBar(context, "Jumlah ronde maksimal 10");
                          return;
                        }

                        context.read<CreateRoomCubit>().createRoom(username);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TotalPlayerForm extends StatelessWidget {
  const _TotalPlayerForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Maksimal Pemain', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Flexible(
          child: TextField(
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                hintText: 'Masukkan maksimal pemain',
                prefixIcon: const Icon(
                  CupertinoIcons.person_2_alt,
                ),
                suffixText: '/25'),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            maxLines: 1,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            onChanged: (String? value) {
              if (value != null && value.isNotEmpty) {
                context
                    .read<CreateRoomCubit>()
                    .setTotalPlayer(int.parse(value));
              }
            },
          ),
        ),
      ],
    );
  }
}

class _TotalRoundForm extends StatelessWidget {
  const _TotalRoundForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Total Permainan', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Flexible(
          child: TextField(
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              hintText: 'Masukkan total permainan',
              prefixIcon: const Icon(
                CupertinoIcons.game_controller_solid,
              ),
              suffixText: '/10',
            ),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            maxLines: 1,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            onChanged: (String? value) {
              if (value != null && value.isNotEmpty) {
                context.read<CreateRoomCubit>().setTotalRound(int.parse(value));
              }
            },
          ),
        ),
      ],
    );
  }
}

class _ThemeSelector extends StatelessWidget {
  const _ThemeSelector();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tema Permainan', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Flexible(
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 40,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: Row(
              children: [
                Icon(CupertinoIcons.bookmark_fill,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Flexible(
                  child: BlocBuilder<CreateRoomCubit, CreateRoomState>(
                    buildWhen: (previous, current) =>
                        previous.themes != current.themes ||
                        previous.settings.theme != current.settings.theme ||
                        previous.status != current.status,
                    builder: (context, state) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          value: state.themes.isNotEmpty &&
                                  state.settings.theme.isEmpty
                              ? state.themes[0]
                              : state.settings.theme,
                          onChanged: (String? value) {
                            if (value != null) {
                              context.read<CreateRoomCubit>().setTheme(value);
                            }
                          },
                          borderRadius: BorderRadius.circular(12),
                          items: state.themes.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DurationSelector extends StatefulWidget {
  const _DurationSelector();

  @override
  State<_DurationSelector> createState() => _DurationSelectorState();
}

class _DurationSelectorState extends State<_DurationSelector> {
  Map<int, String> timer = {
    30: '30 Detik',
    45: '45 Detik',
    60: '1 Menit',
    120: '2 Menit',
    180: '3 Menit',
  };

  int currentTimer = 30;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Waktu Menggambar',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Flexible(
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 40,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: Row(
              children: [
                Icon(CupertinoIcons.timer_fill,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Flexible(
                  child: BlocBuilder<CreateRoomCubit, CreateRoomState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          value: timer[currentTimer],
                          onChanged: (String? dropDownValue) {
                            if (dropDownValue != null) {
                              timer.forEach((key, value) {
                                if (value == dropDownValue) {
                                  setState(() {
                                    currentTimer = key;
                                  });
                                }
                              });
                              context
                                  .read<CreateRoomCubit>()
                                  .setDuration(currentTimer);
                            }
                          },
                          borderRadius: BorderRadius.circular(12),
                          items: timer.entries.map((entry) {
                            return DropdownMenuItem(
                              value: entry.value,
                              child: Text(entry.value),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
