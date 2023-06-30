import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gips/core/bloc/user_cubit/user_cubit.dart';
import 'package:gips/core/component/snackbar/info_snackbar.dart';
import 'package:gips/core/route/app_route_name.dart';
import 'package:gips/global/constans.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.all(kDefaultSpacing * 2),
              padding: const EdgeInsets.fromLTRB(kDefaultSpacing,
                  kDefaultSpacing * 5, kDefaultSpacing, kDefaultSpacing),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Username',
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Flexible(
                        child: TextField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: 'Masukkan username',
                            prefixIcon: const Icon(
                              CupertinoIcons.at,
                            ),
                          ),
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          onChanged: context.read<UserCubit>().setUsername,
                        ),
                      ),
                    ],
                  ),
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
                      child: Padding(
                        padding: const EdgeInsets.all(kDefaultSpacing * .8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/lock.svg',
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: kDefaultSpacing),
                              child: Text('Masuk'),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        final username =
                            context.read<UserCubit>().state.username;
                        if (username.isEmpty) {
                          showInfoSnackBar(
                              context, "Username tidak boleh kosong");
                        } else {
                          Navigator.pushNamedAndRemoveUntil(
                              context, AppRouteName.listRoom, (route) => false);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -250,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(kDefaultSpacing * 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/gips_logo_small.png',
                width: 60,
                height: 80,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
