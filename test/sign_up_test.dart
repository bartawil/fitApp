import 'package:fitapp/components/constants.dart';
import 'package:flutter_test/flutter_test.dart';

String? validatePassword(String password) {
  if (password.isEmpty) {
    return 'Please fill in this field';
  } else if (!passwordRexExp.hasMatch(password)) {
    return 'Please enter a valid password';
  }
  return null;
}

String? validateEmail(String email) {
  if (email.isEmpty) {
    return 'Please fill in this field';
  } else if (!emailRexExp.hasMatch(email)) {
    return 'Please enter a valid email';
  }
  return null;
}

String? validateConfirmPassword(String password, String confirmPassword) {
  if (confirmPassword.isEmpty) {
    return 'Please fill in this field';
  } else if (password != confirmPassword) {
    return 'Passwords do not match';
  }
  return null;
}

void main() {
  group("SignUp test", () {
    test('Empty confirm password field validation', () {
      String? confirmPasswordValidationResult = validateConfirmPassword('', '');
      expect(confirmPasswordValidationResult, 'Please fill in this field');
    });

    test('Valid confirm password validation', () {
      String? confirmPasswordValidationResult =
          validateConfirmPassword('ValidPassword123@', 'ValidPassword123@');
      expect(confirmPasswordValidationResult, null);
    });

    test('Mismatched password and confirm password validation', () {
      String? passwordValidationResult = validatePassword('Pass123@');
      String? confirmPasswordValidationResult =
          validateConfirmPassword('Pass123@', 'Pass456@');
      expect(passwordValidationResult, null);
      expect(confirmPasswordValidationResult, 'Passwords do not match');
    });

    test('Full sign-up form validation', () {
      String? emailValidationResult = validateEmail('test@example.com');
      String? passwordValidationResult = validatePassword('Pass123@');
      String? confirmPasswordValidationResult =
          validateConfirmPassword('Pass123@', 'Pass123@');

      expect(emailValidationResult, null);
      expect(passwordValidationResult, null);
      expect(confirmPasswordValidationResult, null);
    });

    test('Full sign-up form validation with invalid input', () {
      String? emailValidationResult = validateEmail('invalidemail');
      String? passwordValidationResult = validatePassword('weakpass');
      String? confirmPasswordValidationResult =
          validateConfirmPassword('Pass123@', 'Pass456@');

      expect(emailValidationResult, 'Please enter a valid email');
      expect(passwordValidationResult, 'Please enter a valid password');
      expect(confirmPasswordValidationResult, 'Passwords do not match');
    });
  });
}
