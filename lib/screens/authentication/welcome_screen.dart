import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitapp/screens/authentication/sign_in_screen.dart';
import 'package:fitapp/screens/authentication/sign_up_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/sign_in_bloc/sign_in_bloc.dart';

/// A Flutter widget representing the authenication screens of the application.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    // Initialize a TabController with two tabs.
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    // Dispose of the TabController when the screen is no longer in use.
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Display the application logo.
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      'assets/images/dumbel.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Display the application name.
                  Text(
                    'FITAPP',
                    style: GoogleFonts.playfairDisplay(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 52,
                    ),
                  ),
                  const SizedBox(height: kToolbarHeight),
                  // Display tabs for Sign In and Sign Up.
                  TabBar(
                    controller: tabController,
                    unselectedLabelColor:
                        Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                    labelColor: Theme.of(context).colorScheme.onBackground,
                    tabs: const [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        // Display the Sign In screen wrapped in a BlocProvider.
                        BlocProvider<SignInBloc>(
                          create: (context) => SignInBloc(
                            userRepository: context.read<AuthenticationBloc>().userRepository,
                          ),
                          child: const SignInScreen(),
                        ),
                        // Display the Sign Up screen.
                        const SignUpScreen(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
