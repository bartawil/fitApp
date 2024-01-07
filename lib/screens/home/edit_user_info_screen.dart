import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_demo/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:flutter_demo/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:flutter_demo/screens/home/update_user_info_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_repository/user_repository.dart';
/// A screen for editing user information.
///
/// This screen allows users to view and edit their basic information such as
/// first name, last name, email, phone number, birthday, gender, height, and weight.
///
/// Users can tap on any of the information sections to navigate to the
/// [UpdateUserInfoScreen] where they can make changes to their information.
class EditUserInfoScreen extends StatefulWidget {
  const EditUserInfoScreen({super.key});

  @override
  State<EditUserInfoScreen> createState() => _EditUserInfoScreenState();
}

class _EditUserInfoScreenState extends State<EditUserInfoScreen> {
  /// Navigates to the [UpdateUserInfoScreen] for editing user information.
  ///
  /// [user] - The user whose information is being edited.
  void navigateToUpdateUserInfoScreen(MyUser user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<MyUserBloc>(
              create: (context) => MyUserBloc(
                  myUserRepository:
                      context.read<AuthenticationBloc>().userRepository)
                ..add(GetMyUser(
                    myUserId:
                        context.read<AuthenticationBloc>().state.user!.uid)),
            ),
            BlocProvider(
              create: (context) => UpdateUserInfoBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository),
            ),
          ],
          child: UpdateUserInfoScreen(user),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        body: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Container(
            margin: const EdgeInsets.all(20.0),
            child: BlocBuilder<MyUserBloc, MyUserState>(
              builder: (context, state) {
                if (state.user != null) {
                  return Column(
                    children: [
                      const SizedBox(height: 50.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Baseline(
                            baselineType: TextBaseline.alphabetic,
                            baseline: 0.0,
                            child: Text(
                              'FITAPP',
                              style: GoogleFonts.playfairDisplay(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 45,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          Baseline(
                            baselineType: TextBaseline.alphabetic,
                            baseline: 0.0,
                            child: Text(
                              'Basic Info',
                              style: GoogleFonts.playfairDisplay(
                                color:
                                    Theme.of(context).colorScheme.secondary,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // User information sections
                      const SizedBox(height: 50.0),
                      GestureDetector(
                        onTap: () {
                          navigateToUpdateUserInfoScreen(state.user!);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 25,
                            ),
                            const SizedBox(width: 12.0),
                            Text(
                              'First Name',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              state.user!.firstName,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 45.0),
                      GestureDetector(
                        onTap: () {
                          navigateToUpdateUserInfoScreen(state.user!);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_2_outlined,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 25,
                            ),
                            const SizedBox(width: 12.0),
                            Text(
                              'Last Name',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              state.user!.lastName,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 45.0),
                      GestureDetector(
                        onTap: () {
                          navigateToUpdateUserInfoScreen(state.user!);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 25,
                            ),
                            const SizedBox(width: 12.0),
                            Text(
                              'Email',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              state.user!.email,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 45.0),
                      GestureDetector(
                        onTap: () {
                          navigateToUpdateUserInfoScreen(state.user!);
                        },
                        child: Row(
                          children: [
                            Transform.rotate(
                              angle: pi / 12.0,
                              child: Icon(
                                Icons.phone_iphone,
                                color:
                                    Theme.of(context).colorScheme.secondary,
                                size: 25,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              state.user!.phoneNumber,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 45.0),
                      GestureDetector(
                        onTap: () {
                          navigateToUpdateUserInfoScreen(state.user!);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.cake_outlined,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 25,
                            ),
                            const SizedBox(width: 12.0),
                            Text(
                              'Birthday',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              state.user!.age,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 45.0),
                      GestureDetector(
                        onTap: () {
                          navigateToUpdateUserInfoScreen(state.user!);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.male,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 25,
                            ),
                            const SizedBox(width: 12.0),
                            Text(
                              'Gender',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              state.user!.gender,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 45.0),
                      GestureDetector(
                        onTap: () {
                          navigateToUpdateUserInfoScreen(state.user!);
                        },
                        child: Row(
                          children: [
                            Transform.rotate(
                              angle: -pi / 4.0,
                              child: Icon(
                                Icons.straighten_outlined,
                                color:
                                    Theme.of(context).colorScheme.secondary,
                                size: 25,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Text(
                              'Height',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              state.user!.height,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 45.0),
                      GestureDetector(
                        onTap: () {
                          navigateToUpdateUserInfoScreen(state.user!);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.scale_outlined,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 25,
                            ),
                            const SizedBox(width: 12.0),
                            Text(
                              'Weight',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              state.user!.weight,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
