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

void main() {
  group("SignIn test", () {
    group("Password field", () {
      test('Empty password', () {
        String? validationResult = validatePassword('');
        expect(validationResult, 'Please fill in this field');
      });

      test('Password with less than 8 characters', () {
        String? validationResult = validatePassword('pass');
        expect(validationResult, 'Please enter a valid password');
      });

      test('Password without any uppercase letter', () {
        String? validationResult = validatePassword('password123!');
        expect(validationResult, 'Please enter a valid password');
      });

      test('Password without any lowercase letter', () {
        String? validationResult = validatePassword('PASSWORD123!');
        expect(validationResult, 'Please enter a valid password');
      });

      test('Password without any digit', () {
        String? validationResult = validatePassword('Password!');
        expect(validationResult, 'Please enter a valid password');
      });

      test('Password without any special character', () {
        String? validationResult = validatePassword('Password123');
        expect(validationResult, 'Please enter a valid password');
      });

      test('Password with 8 characters and valid symbols',
          () {
        String? validationResult = validatePassword('Pass123@');
        expect(validationResult, null);
      });

      test('Password with more than 8 characters', () {
        String? validationResult =
            validatePassword('Pass123@ExtraLongPassword');
        expect(validationResult, null);
      });

      test('Password with special characters and spaces', () {
        String? validationResult = validatePassword('P@ss word 123!');
        expect(validationResult, 'Please enter a valid password');
      });

      test('Password with only special characters', () {
        String? validationResult = validatePassword('!@#I_%^&*()');
        expect(validationResult, 'Please enter a valid password');
      });

      test('Password with only digits', () {
        String? validationResult = validatePassword('12345678');
        expect(validationResult, 'Please enter a valid password');
      });

      test('Password with valid combination', () {
        String? validationResult = validatePassword('Pass123@');
        expect(validationResult, null);
      });

    });

    group("Email field", () {
      test('Empty email', () {
        String? validationResult = validateEmail('');
        expect(validationResult, 'Please fill in this field');
      });

      test('Email without the @ symbol', () {
        String? validationResult = validateEmail('testexample.com');
        expect(validationResult, 'Please enter a valid email');
      });

      test('Email without a domain', () {
        String? validationResult = validateEmail('test@');
        expect(validationResult, 'Please enter a valid email');
      });

      test('Email without a username', () {
        String? validationResult = validateEmail('@example.com');
        expect(validationResult, 'Please enter a valid email');
      });

      test('Valid email', () {
        String? validationResult = validateEmail('test@example.com');
        expect(validationResult, null);
      });

      test('Email with mixed-case local part', () {
        String? validationResult = validateEmail('TesT@example.com');
        expect(validationResult, null);
      });

      test('Email with mixed-case domain part', () {
        String? validationResult = validateEmail('test@ExAmPle.COM');
        expect(validationResult, 'Please enter a valid email');
      });

      test('Email with multiple "@" symbols', () {
        String? validationResult = validateEmail('test@ex@ample.com');
        expect(validationResult, 'Please enter a valid email');
      });

      test('Email with consecutive dots in domain', () {
        String? validationResult = validateEmail('test@example..com');
        expect(validationResult, 'Please enter a valid email');
      });

      test('Email with valid subdomain', () {
        String? validationResult = validateEmail('test@sub.example.com');
        expect(validationResult, 'Please enter a valid email');
      });

      test('Email with invalid subdomain', () {
        String? validationResult = validateEmail('test@.example.com');
        expect(validationResult, 'Please enter a valid email');
      });

      test('Email with a long local part and domain part',
          () {
        String? validationResult =
            validateEmail('${'a' * 256}@${'b' * 256}.com');
        expect(validationResult, 'Please enter a valid email');
      });
    });
  });
}
