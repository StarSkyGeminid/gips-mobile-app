import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:gips/core/global/constans.dart';
import 'package:gips/formz_models/models.dart';
import 'package:gips/widget/custom_form.dart';

import 'bloc/register_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
          RepositoryProvider.of<AuthenticationRepository>(context)),
      child: const RegisterScreenView(),
    );
  }
}

class RegisterScreenView extends StatelessWidget {
  const RegisterScreenView({super.key});

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
        body: BlocListener<RegisterBloc, RegisterState>(
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
                      'Daftar',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: kDefaultSpacing),
                    const _UsernameTextFormField(),
                    const SizedBox(height: kDefaultSpacing),
                    const _EmailTextFormField(),
                    const SizedBox(height: kDefaultSpacing / 2),
                    const _PasswordTextFormField(),
                    const SizedBox(height: kDefaultSpacing),
                    const _ConfirmPasswordTextFormField(),
                    const SizedBox(height: kDefaultSpacing),
                    const Flexible(child: _SubmitButton()),
                    const SizedBox(height: kDefaultSpacing * 2),
                    const _AlreadyHavingAccount(),
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
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.isValidated != current.isValidated,
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('RegisterScreen_submitButton'),
          onPressed: state.isValidated && !state.status.isInProgress
              ? () =>
                  context.read<RegisterBloc>().add(const RegisterOnSubmitted())
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
                        'assets/svg/user-add.svg',
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultSpacing),
                        child: Text('Daftar'),
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
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return CustomTextFormField(
          key: const Key('RegisterScreen_passwordTextFormField'),
          title: 'Kata Sandi',
          hintText: 'Masukkan kata sandi',
          obscureText: true,
          prefixIcon: const Icon(Icons.lock_rounded),
          onChanged: (value) => context
              .read<RegisterBloc>()
              .add(RegisterOnPasswordChanged(value)),
          errorText: state.password.displayError?.text(),
        );
      },
    );
  }
}

class _ConfirmPasswordTextFormField extends StatelessWidget {
  const _ConfirmPasswordTextFormField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return CustomTextFormField(
          key: const Key('RegisterScreen_confirmPasswordTextFormField'),
          title: 'Konfirmasi Kata Sandi',
          hintText: 'Masukkan kata sandi',
          obscureText: true,
          prefixIcon: const Icon(Icons.lock_rounded),
          onChanged: (value) => context
              .read<RegisterBloc>()
              .add(RegisterOnConfirmPasswordChanged(value)),
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
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return CustomTextFormField(
          key: const Key('RegisterScreen_emailTextFormField'),
          title: 'Email',
          hintText: 'Masukkan email',
          textInputType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.alternate_email_rounded),
          onChanged: (value) =>
              context.read<RegisterBloc>().add(RegisterOnEmailChanged(value)),
          errorText: state.email.displayError?.text(),
        );
      },
    );
  }
}

class _UsernameTextFormField extends StatelessWidget {
  const _UsernameTextFormField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return CustomTextFormField(
          key: const Key('RegisterScreen_usernameTextFormField'),
          title: 'Username',
          hintText: 'Masukkan username',
          textInputType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.person_rounded),
          onChanged: (value) => context
              .read<RegisterBloc>()
              .add(RegisterOnUsernameChanged(value)),
          errorText: state.username.displayError?.text(),
        );
      },
    );
  }
}

class _AlreadyHavingAccount extends StatelessWidget {
  const _AlreadyHavingAccount();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Sudah punya akun? ',
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: 'Masuk',
            style: Theme.of(context).textTheme.titleSmall,
            recognizer: TapGestureRecognizer()
              ..onTap = () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
