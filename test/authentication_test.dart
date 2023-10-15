// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:user_repository/user_repository.dart';

// class MockUser extends Mock implements User {}

// class MockFirebaseAuth extends Mock implements FirebaseAuth {
//   @override
//   Stream<User> authStateChanges() {
//     return Stream.fromIterable([MockUser()]);
//   }
// }

// void main() {
//   final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
//   final FirebaseUserRepository firebaseUserRepository =
//       FirebaseUserRepository(firebaseAuth: mockFirebaseAuth);

//   setUp(() {});

//   tearDown(() {});

//   test('emit occurs', () async {
//     expectLater(firebaseUserRepository.user, emitsInOrder([MockUser]));
//   });
// }