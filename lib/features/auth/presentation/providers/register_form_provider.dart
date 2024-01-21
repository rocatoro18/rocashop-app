import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/shared/infrastructure/inputs/confirmed_password.dart';
import 'package:teslo_shop/features/shared/infrastructure/inputs/username.dart';
import 'package:teslo_shop/features/shared/shared.dart';

// 3 - STATENOTIFIERPROVIDER - CONSUME AFUERA
// AUTODISPOSE PARA LIMPIAR EL LOGIN FORM PROVIDER CUANDO YA NO SE USE
final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  return RegisterFormNotifier();
});

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  // EN EL SUPER VA LA CREACION DEL ESTADO INICIAL, TIENE QUE SER SINCRONO
  RegisterFormNotifier() : super(RegisterFormState());

  onUsernameChanged(String value) {
    final newUsername = Username.dirty(value);
    state = state.copyWith(
        username: newUsername,
        isValid: Formz.validate([
          newUsername,
          state.email,
          state.password,
          state.confirmedPassword
        ]));
  }

  onEmailChanged(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail,
        isValid: Formz.validate([
          newEmail,
          state.username,
          state.password,
          state.confirmedPassword
        ]));
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([
          newPassword,
          state.username,
          state.email,
          state.confirmedPassword
        ]));
  }

  onConfirmedPasswordChanged(String value) {
    // TOMAR CONTRASEÑA ORIGINAL Y CONFIRMACION DE CONTRASEÑA PARA METERLO AL DIRTY Y COMPARAR AMBOS STRINGS CON FORMZ
    final newConfirmedPassword =
        ConfirmedPassword.dirty(originalPassword: state.password, value: value);
    state = state.copyWith(
        confirmedPassword: newConfirmedPassword,
        isValid: Formz.validate([
          newConfirmedPassword,
          state.password,
          state.username,
          state.email
        ]));
  }

  onFormSubmit() {
    _touchEveryField();
    if (!state.isValid) return;
    print(state);
  }

  // ENSUCIAR EL INPUT PARA HACER LA VALIDACION CORRECTAMENTE
  _touchEveryField() {
    final username = Username.dirty(state.username.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final confirmedPassword = ConfirmedPassword.dirty(
        originalPassword: state.password, value: state.confirmedPassword.value);

    state = state.copyWith(
        isFormPosted: true,
        username: username,
        email: email,
        password: password,
        confirmedPassword: confirmedPassword,
        isValid:
            Formz.validate([username, email, password, confirmedPassword]));
  }
}

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Username username;
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  RegisterFormState(
      {this.isPosting = false,
      this.isFormPosted = false,
      this.isValid = false,
      this.username = const Username.pure(),
      this.email = const Email.pure(),
      this.password = const Password.pure(),
      this.confirmedPassword = const ConfirmedPassword.pure()});

  RegisterFormState copyWith(
          {bool? isPosting,
          bool? isFormPosted,
          bool? isValid,
          Username? username,
          Email? email,
          Password? password,
          ConfirmedPassword? confirmedPassword}) =>
      RegisterFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          username: username ?? this.username,
          email: email ?? this.email,
          password: password ?? this.password,
          confirmedPassword: confirmedPassword ?? this.confirmedPassword);

  @override
  String toString() {
    return '''
    RegisterFormState
    isPosting $isPosting
    isFormPosted $isFormPosted
    isValid $isValid
    Username $username
    Email $email
    Password $password
    ConfirmedPassword $confirmedPassword
    ''';
  }
}
