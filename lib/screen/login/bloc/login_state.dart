part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.username = const UserName.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValidated = false,
    this.message = '',
  });

  final UserName username;

  final Password password;

  final FormzSubmissionStatus status;

  final bool isValidated;

  final String message;

  LoginState copyWith({
    UserName? username,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValidated,
    String? message,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      isValidated: isValidated ?? this.isValidated,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        username,
        password,
        status,
        isValidated,
        message,
      ];
}
