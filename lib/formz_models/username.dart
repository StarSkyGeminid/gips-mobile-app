import 'package:formz/formz.dart';

enum UserNameValidationError { empty, tooShort }

class UserName extends FormzInput<String, UserNameValidationError> {
  const UserName.pure() : super.pure('');
  const UserName.dirty([super.value = '']) : super.dirty();

  @override
  UserNameValidationError? validator(String value) {
    if (value.isEmpty) return UserNameValidationError.empty;

    if (value.length < 4) return UserNameValidationError.tooShort;

    return null;
  }
}

extension UserNameValidationErrorToText on UserNameValidationError {
  String text() {
    switch (this) {
      case UserNameValidationError.empty:
        return '''Username tidak boleh kosong''';
      case UserNameValidationError.tooShort:
        return '''Username minimum 4 karakter''';
    }
  }
}
