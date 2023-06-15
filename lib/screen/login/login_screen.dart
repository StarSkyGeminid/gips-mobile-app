import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:gips/core/global/constans.dart';
import 'package:gips/formz_models/models.dart';
import 'package:gips/widget/custom_form.dart';

import 'bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginBloc(RepositoryProvider.of<AuthenticationRepository>(context)),
      child: const _LoginScreenView(),
    );
  }
}

class _LoginScreenView extends StatelessWidget {
  const _LoginScreenView();

  void gotoRegister(BuildContext context) {
    Navigator.pushNamed(context, '/register');
  }

  void gotoForgotPassword(BuildContext context) {
    Navigator.pushNamed(context, '/forgot_password');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status.isFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
            }
          },
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Container(
                margin: const EdgeInsets.all(kDefaultSpacing),
                padding: const EdgeInsets.all(kDefaultSpacing),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: kDefaultSpacing),
                    Text(
                      'Masuk',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: kDefaultSpacing),
                    const _EmailTextFormField(),
                    const SizedBox(height: kDefaultSpacing / 2),
                    const _PasswordTextFormField(),
                    const SizedBox(height: kDefaultSpacing),
                    const Flexible(child: _SubmitButton()),
                    const SizedBox(height: kDefaultSpacing * 2),
                    const _NotHavingAccount(),
                    const SizedBox(height: kDefaultSpacing),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.isValidated != current.isValidated,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('LoginScreen_submitButton'),
          onPressed: state.isValidated && !state.status.isInProgress
              ? () => context.read<LoginBloc>().add(const LoginOnSubmitted())
              : null,
          child: state.status.isInProgress
              ? const Padding(
                  padding: EdgeInsets.all(kDefaultSpacing * .45),
                  child: CircularProgressIndicator.adaptive(),
                )
              : Padding(
                  padding: const EdgeInsets.all(kDefaultSpacing * .8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/lock.svg',
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultSpacing),
                        child: Text('Masuk'),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class _PasswordTextFormField extends StatelessWidget {
  const _PasswordTextFormField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return CustomTextFormField(
          key: const Key('LoginScreen_passwordTextFormField'),
          title: 'Kata Sandi',
          hintText: 'Masukkan kata sandi',
          obscureText: true,
          prefixIcon: const Icon(Icons.lock_rounded),
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginOnPasswordChanged(value)),
          errorText: state.password.displayError?.text(),
        );
      },
    );
  }
}

class _EmailTextFormField extends StatelessWidget {
  const _EmailTextFormField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return CustomTextFormField(
          key: const Key('LoginScreen_emailTextFormField'),
          title: 'Username/email',
          hintText: 'Masukkan Username atau email',
          textInputType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.person_rounded),
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginOnEmailChanged(value)),
          errorText: state.username.displayError?.text(),
        );
      },
    );
  }
}

class _NotHavingAccount extends StatelessWidget {
  const _NotHavingAccount();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Belum punya akun? ',
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: 'Daftar',
            style: Theme.of(context).textTheme.titleSmall,
            recognizer: TapGestureRecognizer()
              ..onTap = () => Navigator.pushNamed(context, '/register'),
          ),
        ],
      ),
    );
  }
}
