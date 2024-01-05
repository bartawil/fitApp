import 'package:flutter_demo/components/constants.dart';
import 'package:flutter_test/flutter_test.dart';

String? validateText(String value) {
  if (value.isEmpty) {
    return 'Please fill in this field';
  } else if (value.length > 30) {
    return 'Please enter a shorter title';
  } else if (specialCharRexExp.hasMatch(value)) {
    return 'Please enter a valid text';
  }
  return null;
}

void main() {
  group("Notification text field test", () {
    test('Empty text', () {
      String? validationResult = validateText('');
      expect(validationResult, 'Please fill in this field');
    });

    test('Text with more than 30 characters', () {
      String? validationResult = validateText(
          'This is a very long title that has more than 30 characters');
      expect(validationResult, 'Please enter a shorter title');
    });

    test('Text with special characters', () {
      String? validationResult = validateText('Title with special characters>');
      expect(validationResult, 'Please enter a valid text');
    });

    test('Text with 30 characters and no special characters', () {
      String? validationResult = validateText('This is a title with 30 chars');
      expect(validationResult, null);
    });

    test('Text with exactly 30 characters and special characters', () {
      String? validationResult =
          validateText('1111111111222222222212456789^');
      expect(validationResult, 'Please enter a valid text');
    });

    test('Text with ! special character', () {
      String? validationResult = validateText('Title with ! special character');
      expect(validationResult, null);
    });

    test('Text with special characters and more than 30 characters', () {
      String? validationResult =
          validateText('This is a very long title with special characters*');
      expect(validationResult, 'Please enter a shorter title');
    });
  });
}
