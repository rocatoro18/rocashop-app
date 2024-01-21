import 'package:formz/formz.dart';

// Define input validation errors
enum UsernameError { empty, format }

// Extend FormzInput and provide the input type and error type.
class Username extends FormzInput<String, UsernameError> {
  // MODIFICAR
  static final RegExp usernameRegExp = RegExp(
    r'^[a-zA-Z0-9_]{3,16}$',
  );

  // Call super.pure to represent an unmodified form input.
  const Username.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Username.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == UsernameError.empty) return 'El campo es requerido';
    if (displayError == UsernameError.format) {
      return 'No tiene formato de nombre de usuario';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  UsernameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return UsernameError.empty;
    if (!usernameRegExp.hasMatch(value)) return UsernameError.format;

    return null;
  }
}
