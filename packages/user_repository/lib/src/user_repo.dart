import 'package:firebase_auth/firebase_auth.dart';
import '../user_repository.dart';

abstract class UserRepository {

	Stream<User?> get user;
	
	Future<void> signIn(String email, String password);

	Future<void> logOut();

	Future<MyUser> signUp(MyUser myUser, String password);

	Future<void> resetPassword(String email);

	Future<void> setUserData(MyUser user);

	Future<MyUser> getMyUser(String myUserId);

	Future<String> uploadPicture(String file, String userId);

  Future<void> createWeightCollection(String weight, String userId);

  Future<List<Weight>> getWeightList(String userId);

  Future<List<Weight>> deleteWeight(String userId, String weightId);

  Future<void> setWeightData(String userId, Weight weight);
}