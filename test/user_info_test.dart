import 'package:fitapp/components/constants.dart';
import 'package:flutter_test/flutter_test.dart';

String? validateName(String name) {
  if (name.isEmpty) {
    return 'Please fill in this field';
  } else if (name.length > 30) {
    return 'Name too long';
  }
  return null;
}

String? validatePhone(String phone) {
  if (phone.isEmpty) {
    return 'Please fill in this field';
  } else if (!israeliPhoneNumberRexExp.hasMatch(phone)) {
    return 'Please enter a valid phone number';
  } else if (phone.length < 10 || phone.length > 10) {
    return 'Please enter a valid phone number';
  }
  return null;
}

String? validateAge(String val) {
  if (val.isEmpty) {
    return 'Please fill in this field';
  } else {
    try {
      double age = double.parse(val);
      if (age < 16 || age > 120) {
        return 'Age must be between 16 and 120';
      }
    } catch (e) {
      return 'Please enter a valid number';
    }
  }
  return null;
}

String? validateHeight(String val) {
  if (val.isEmpty) {
    return 'Please fill in this field';
  } else {
    try {
      double height = double.parse(val);
      if (height < 120 || height > 250) {
        return 'Please enter a valid height';
      }
    } catch (e) {
      return 'Please enter a valid number';
    }
  }
  return null;
}


void main() {
  group("Add user info test", () {
    group("Name field", () {
      test('Empty name', () {
        String? validationResult = validateName('');
        expect(validationResult, 'Please fill in this field');
      });

      test('Name with more than 30 characters', () {
        String? validationResult =
            validateName('This name is too long to be valid');
        expect(validationResult, 'Name too long');
      });

      test('Name with exactly 30 characters', () {
        String? validationResult =
            validateName('This name has exactly 30 chars');
        expect(validationResult, null);
      });

      test('Valid name', () {
        String? validationResult = validateName('Valid name');
        expect(validationResult, null);
      });
    });

    group("Phone field", () {
      test('Empty phone', () {
        String? validationResult = validatePhone('');
        expect(validationResult, 'Please fill in this field');
      });

      test('Phone with less than 10 characters', () {
        String? validationResult = validatePhone('123456789');
        expect(validationResult, 'Please enter a valid phone number');
      });

      test('Phone with more than 10 characters', () {
        String? validationResult = validatePhone('12345678901');
        expect(validationResult, 'Please enter a valid phone number');
      });

      test('Invalid Phone with exactly 10 characters', () {
        String? validationResult = validatePhone('1234567890');
        expect(validationResult, 'Please enter a valid phone number');
      });

      test('Phone with invalid characters', () {
        String? validationResult = validatePhone('123456789a');
        expect(validationResult, 'Please enter a valid phone number');
      });

      test('Valid phone', () {
        String? validationResult = validatePhone('0501234567');
        expect(validationResult, null);
      });

      test('Phone with leading zeros', () {
        String? validationResult = validatePhone('0012345678');
        expect(validationResult, 'Please enter a valid phone number');
      });
    });

    group("Age field", () {
      test('Empty age', () {
        String? validationResult = validateAge('');
        expect(validationResult, 'Please fill in this field');
      });

      test('Age with invalid characters', () {
        String? validationResult = validateAge('abc');
        expect(validationResult, 'Please enter a valid number');
      });

      test('Age with decimal point', () {
        String? validationResult = validateAge('20.5');
        expect(validationResult, null);
      });

      test('Age with negative number', () {
        String? validationResult = validateAge('-20');
        expect(validationResult, 'Age must be between 16 and 120');
      });

      test('Age with valid number', () {
        String? validationResult = validateAge('20');
        expect(validationResult, null);
      });

      test('Age with minimum valid age', () {
        String? validationResult = validateAge('16');
        expect(validationResult, null);
      });

      test('Age with maximum valid age', () {
        String? validationResult = validateAge('120');
        expect(validationResult, null);
      });

      test('Age with age below minimum', () {
        String? validationResult = validateAge('15');
        expect(validationResult, 'Age must be between 16 and 120');
      });

      test('Age with age above maximum', () {
        String? validationResult = validateAge('121');
        expect(validationResult, 'Age must be between 16 and 120');
      });

      test('Age with decimal age below minimum', () {
        String? validationResult = validateAge('15.5');
        expect(validationResult, 'Age must be between 16 and 120');
      });

      test('Age with decimal age above maximum', () {
        String? validationResult = validateAge('120.5');
        expect(validationResult, 'Age must be between 16 and 120');
      });
    });

    group('Height field', () {
      test('Empty height', () {
        String? validationResult = validateHeight('');
        expect(validationResult, 'Please fill in this field');
      });

      test('Height with invalid characters', () {
        String? validationResult = validateHeight('abc');
        expect(validationResult, 'Please enter a valid number');
      });

      test('Height with decimal point', () {
        String? validationResult = validateHeight('180.5');
        expect(validationResult, null);
      });

      test('Height with negative number', () {
        String? validationResult = validateHeight('-180');
        expect(validationResult, 'Please enter a valid height');
      });

      test('Height with valid number', () {
        String? validationResult = validateHeight('180');
        expect(validationResult, null);
      });

      test('Height with minimum valid height', () {
        String? validationResult = validateHeight('120');
        expect(validationResult, null);
      });

      test('Height with maximum valid height', () {
        String? validationResult = validateHeight('250');
        expect(validationResult, null);
      });

      test('Height with height below minimum', () {
        String? validationResult = validateHeight('119');
        expect(validationResult, 'Please enter a valid height');
      });

      test('Height with height above maximum', () {
        String? validationResult = validateHeight('251');
        expect(validationResult, 'Please enter a valid height');
      });

      test('Height with decimal height below minimum', () {
        String? validationResult = validateHeight('119.5');
        expect(validationResult, 'Please enter a valid height');
      });

      test('Height with decimal height above maximum', () {
        String? validationResult = validateHeight('250.5');
        expect(validationResult, 'Please enter a valid height');
      });
    });

    
  });
}
