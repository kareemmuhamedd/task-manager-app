import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart' show FormzInput;

import 'formz_validation_mixin.dart';

/// {@template Name}
/// Form input for a Name. It extends [FormzInput] and uses
/// [NameValidationError] for its validation errors.
/// {@endtemplate}
class Name extends FormzInput<String, NameValidationError>
    with EquatableMixin, FormzValidationMixin {
  /// {@macro Name.pure}
  const Name.pure([super.value = '']) : super.pure();

  /// {@macro Name.dirty}
  const Name.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) {
      return NameValidationError.empty;
    } else if (value.length < 4 || value.length > 200) {
      return NameValidationError.invalid;
    } else {
      return null;
    }
  }

  @override
  Map<NameValidationError?, String?> get validationErrorMessage => {
        NameValidationError.empty: 'This field is required',
        NameValidationError.invalid: value.length > 200
            ? 'Name should contain at most 200 characters'
            : 'Name should contain at least 4 characters',
        null: null,
      };

  @override
  List<Object?> get props => [value, pure];
}

/// Validation errors for [Name]. It can be empty or invalid.
enum NameValidationError {
  /// Empty Name.
  empty,

  /// Invalid Name.
  invalid,
}
