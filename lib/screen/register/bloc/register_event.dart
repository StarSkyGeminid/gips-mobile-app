part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterOnUsernameChanged extends RegisterEvent {
  const RegisterOnUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class RegisterOnEmailChanged extends RegisterEvent {
  const RegisterOnEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class RegisterOnPasswordChanged extends RegisterEvent {
  const RegisterOnPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class RegisterOnConfirmPasswordChanged extends RegisterEvent {
  const RegisterOnConfirmPasswordChanged(this.confirmPassword);

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

class RegisterOnSubmitted extends RegisterEvent {
  const RegisterOnSubmitted();
}

class RegisterPageChanged extends RegisterEvent {
  const RegisterPageChanged(this.page);

  final RegisterPage page;

  @override
  List<Object> get props => [page];
}
