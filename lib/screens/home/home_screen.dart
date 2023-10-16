import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/components/pick_image.dart';
import 'package:flutter_demo/components/post_list.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_demo/blocs/create_post_bloc/create_post_bloc.dart';
import 'package:flutter_demo/blocs/get_post_bloc/get_post_bloc.dart';
import 'package:flutter_demo/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_demo/screens/home/create_post_screen.dart';
import 'package:post_repository/post_repository.dart';
import '../../blocs/my_user_bloc/my_user_bloc.dart';
import '../../blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:intl/intl.dart';

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
				if(state is UploadPictureSuccess) {
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
                      builder: (BuildContext context) => BlocProvider<CreatePostBloc>(
                        create: (context) => CreatePostBloc(
                          postRepository: FirebasePostRepository()
                        ),
                        child: CreatePostScreen(
                          state.user!
                        ),
                      ),
                    ),
                  );
                },
                child: const Icon(
                  CupertinoIcons.add
                ),
              );
            } else {
              return const FloatingActionButton(
                onPressed: null,
                child: Icon(
                  CupertinoIcons.clear
                ),
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
                                shape: BoxShape.circle
                              ),
                              child: Icon(
                                CupertinoIcons.person, 
                                color: Colors.grey.shade400
                              ),
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
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                        ),
                    const SizedBox(width: 10),
                    Text(
                      "Welcome ${state.user!.firstName}"
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Posts",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 100
                      ),
                    ),
                  ),
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