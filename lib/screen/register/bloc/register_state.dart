part of 'register_bloc.dart';

enum RegisterPage { first, second }

class RegisterState extends Equatable {
  const RegisterState({
    this.username = const UserName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValidated = false,
    this.page = RegisterPage.first,
    this.message = '',
  });

  final UserName username;

  final Email email;

  final Password password;

  final ConfirmPassword confirmPassword;

  final FormzSubmissionStatus status;

  final bool isValidated;

  final RegisterPage page;

  final String message;

  RegisterState copyWith({
    UserName? username,
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    FormzSubmissionStatus? status,
    bool? isValidated,
    RegisterPage? page,
    String? message,
  }) {
    return RegisterState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      isValidated: isValidated ?? this.isValidated,
      page: page ?? this.page,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        username,
        email,
        password,
        confirmPassword,
        status,
        isValidated,
        page,
        message,
      ];
}
