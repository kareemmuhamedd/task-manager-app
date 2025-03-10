import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart' show FormzInput;

import 'formz_validation_mixin.dart';

/// {@template password}
/// Form input for a password. It extends [FormzInput] and uses
/// [PasswordValidationError] for its validation errors.
/// {@endtemplate}
class Password extends FormzInput<String, PasswordValidationError>
    with EquatableMixin, FormzValidationMixin {
  /// {@macro password.pure}
  const Password.pure([super.value = '']) : super.pure();

  /// {@macro password.dirty}
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      print('your password is empty');
      return PasswordValidationError.empty;
    } else if (value.length < 6 || value.length > 120) {
      return PasswordValidationError.invalid;
    } else {
      return null;
    }
  }

  @override
  Map<PasswordValidationError?, String?> get validationErrorMessage => {
        PasswordValidationError.empty: 'This field is required',
        PasswordValidationError.invalid:
            'Password should contain at least 6 characters',
        null: null,
      };

  @override
  List<Object?> get props => [value, pure];
}

/// Validation errors for [Password]. It can be empty or invalid.
enum PasswordValidationError {
  /// Empty password.
  empty,

  /// Invalid password.
  invalid,
}
