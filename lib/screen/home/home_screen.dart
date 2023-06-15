import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gips/core/global/constans.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: const _HomeScreenView(),
    );
  }
}

class _HomeScreenView extends StatefulWidget {
  const _HomeScreenView();

  @override
  State<_HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<_HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 1));
      },
      child: ListView(
        children: const [],
      ),
    );
  }
}

class _JoinRoomButton extends StatelessWidget {
  const _JoinRoomButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('HomeScreen_submitButton'),
          onPressed: () => Navigator.of(context).pushNamed('/join-room'),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultSpacing),
            child: Text('Join Room'),
          ),
        );
      },
    );
  }
}

class _CreateRoomButton extends StatelessWidget {
  const _CreateRoomButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('HomeScreen_submitButton'),
          onPressed: () => Navigator.of(context).pushNamed('/create-room'),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultSpacing),
            child: Text('Buat Room'),
          ),
        );
      },
    );
  }
}
