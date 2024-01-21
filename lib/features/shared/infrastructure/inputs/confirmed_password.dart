import 'package:formz/formz.dart';
import 'package:teslo_shop/features/shared/shared.dart';

// Define input validation errors
enum ConfirmedPasswordError { empty, length, format, mismatch }

// Extend FormzInput and provide the input type and error type.
class ConfirmedPassword extends FormzInput<String, ConfirmedPasswordError> {
  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
  );

  // Call super.pure to represent an unmodified form input.
  const ConfirmedPassword.pure()
      : originalPassword = const Password.pure(),
        super.pure('');

  // Call super.dirty to represent a modified form input.
  const ConfirmedPassword.dirty(
      {required this.originalPassword, String value = ''})
      : super.dirty(value);

  final Password originalPassword;

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == ConfirmedPasswordError.mismatch) {
      return 'Las contraseñas no coinciden';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  ConfirmedPasswordError? validator(String value) {
    final confirmedPassword = stringToPassword(value);
    if (originalPassword != confirmedPassword) {
      return ConfirmedPasswordError.mismatch;
    }
    return null;
  }

  Password stringToPassword(String value) {
    return Password.fromString(value);
  }
}
