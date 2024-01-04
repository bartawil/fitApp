import 'package:flutter_demo/components/constants.dart';
import 'package:flutter_test/flutter_test.dart';

String? validateWeight(String val) {
  if (val.isEmpty) {
    return 'Please fill in this field';
  } else if (val.length < 2) {
    return 'Please enter a valid weight';
  } else if (!doubleRexExp.hasMatch(val)) {
    return 'Format must be XX.XX';
  } else {
    try {
      double age = double.parse(val);
      if (age < 30 || age > 250) {
        return 'Please enter a valid weight';
      }
    } catch (e) {
      return 'Please enter a valid number';
    }
  }
  return null;
}

void main () {
  group("Update weight test", () { 
    group('validateWeight', () {
      test('Weight is not empty and within the valid range',() {
        expect(validateWeight('70.5'), null);
      });

      test('Weight is empty', () {
        expect(validateWeight(''), 'Please fill in this field');
      });

      test('Weight is less than 2 characters long', () {
        expect(validateWeight('1'), 'Please enter a valid weight');
      });

      test('Weight must match the format XX.XX', () {
        expect(validateWeight('70'), 'Format must be XX.XX');
        expect(validateWeight('70.55'), null);
      });

      test('Weight is not within the valid range',() {
        expect(validateWeight('29.9'), 'Please enter a valid weight');
        expect(validateWeight('250.1'), 'Please enter a valid weight');
      });

      test('Weight is not a valid number', () {
        expect(validateWeight('abc'), 'Format must be XX.XX');
      });
    });
  });
}