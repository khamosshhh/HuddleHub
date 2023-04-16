import 'package:form_field_validator/form_field_validator.dart';

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: '* Required'),
  MinLengthValidator(7, errorText: 'Must be at least 7 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'Must have at least one special character')
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: '* Required'),
  EmailValidator(errorText: 'Enter a valid email address')
]);

final numberValidator = MultiValidator([
  RequiredValidator(errorText: '* Required'),
  MinLengthValidator(10, errorText: 'Enter a valid phone number'),
  MaxLengthValidator(10, errorText: 'Enter a valid phone number'),
]);

final emptyValidator = RequiredValidator(errorText: '* Required');
