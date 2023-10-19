import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_demo/components/menu_button.dart';
import 'package:flutter_demo/components/pick_image.dart';
import 'package:flutter_demo/components/post_list.dart';
import 'package:flutter_demo/blocs/create_post_bloc/create_post_bloc.dart';
import 'package:flutter_demo/blocs/get_post_bloc/get_post_bloc.dart';
import 'package:flutter_demo/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_demo/screens/home/create_post_screen.dart';
import 'package:flutter_demo/screens/weight/update_weight_screen.dart';
import 'package:post_repository/post_repository.dart';
import '../../blocs/my_user_bloc/my_user_bloc.dart';
import '../../blocs/update_user_info_bloc/update_user_info_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
      listener: (context, state) {
        if (state is UploadPictureSuccess) {
          setState(() {
            context.read<MyUserBloc>().state.user!.picture = state.userImage;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        // add post button
        floatingActionButton: BlocBuilder<MyUserBloc, MyUserState>(
          builder: (context, state) {
            if (state.status == MyUserStatus.success) {
              return FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          BlocProvider<CreatePostBloc>(
                        create: (context) => CreatePostBloc(
                            postRepository: FirebasePostRepository()),
                        child: CreatePostScreen(state.user!),
                      ),
                    ),
                  );
                },
                backgroundColor: Theme.of(context).colorScheme.background,
                child: const Icon(CupertinoIcons.add),
              );
            } else {
              return const FloatingActionButton(
                onPressed: null,
                child: Icon(CupertinoIcons.clear),
              );
            }
          },
        ),
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          // Profile image and title
          title: BlocBuilder<MyUserBloc, MyUserState>(
            builder: (context, state) {
              if (state.status == MyUserStatus.success) {
                return Row(
                  children: [
                    state.user!.picture == ""
                        ? GestureDetector(
                            onTap: () async {
                              await pickAndCropImage(context);
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  shape: BoxShape.circle),
                              child: Icon(CupertinoIcons.person,
                                  color: Colors.grey.shade400),
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              await pickAndCropImage(context);
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        state.user!.picture!,
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                    const SizedBox(width: 10),
                    Text("Welcome ${state.user!.firstName}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      )
                    )
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
          // Sign-Out button
          actions: [
            IconButton(
              onPressed: () {
                context.read<SignInBloc>().add(const SignOutRequired());
              },
              icon: Icon(
                CupertinoIcons.square_arrow_right,
                color: Theme.of(context).colorScheme.onBackground,
              )
            )
          ],
        ),
        body: BlocBuilder<GetPostBloc, GetPostState>(
          builder: (context, state) {
            if (state is GetPostSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: Image.asset(
                      'assets/images/chart.png',
                      width: 250, height: 250
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyMenuButton(
                        title: "Metrics", 
                        icon: 'assets/images/weight.png',
                        onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider<MyUserBloc>(
                                    create: (context) => MyUserBloc(
                                        myUserRepository: context
                                            .read<AuthenticationBloc>()
                                            .userRepository)
                                      ..add(GetMyUser(
                                          myUserId: context
                                              .read<AuthenticationBloc>()
                                              .state
                                              .user!
                                              .uid)),
                                  ),
                                  BlocProvider(
                                    create: (context) => UpdateUserInfoBloc(
                                      userRepository: context.read<AuthenticationBloc>().userRepository
                                    ),
                                  ),
                                ],
                                child: const UpdateWeightScreen(),
                              );
                            }));
                          },
                        ),
                      const SizedBox(width: 30),
                      MyMenuButton(title: "Nutrintion", icon: 'assets/images/nutritional.png'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyMenuButton(title: "Workouts", icon: 'assets/images/fitness.png'),
                      const SizedBox(width: 30),
                      MyMenuButton(title: "settings", icon: 'assets/images/settings.png', iconColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.5), backgroundColor: Theme.of(context).colorScheme.primary, fontColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Show posts list
                  Expanded(child: PostList(posts: state.posts))
                ],
              );
            } else if (state is GetPostLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text("An error has occured"),
              );
            }
          },
        ),
      ),
    );
  }
}
