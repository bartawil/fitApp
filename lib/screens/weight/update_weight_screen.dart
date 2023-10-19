import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/my_user_bloc/my_user_bloc.dart';
import 'package:flutter_demo/blocs/update_user_info_bloc/update_user_info_bloc.dart';
import 'package:user_repository/user_repository.dart';

class UpdateWeightScreen extends StatefulWidget {
  const UpdateWeightScreen({super.key});

  @override
  State<UpdateWeightScreen> createState() => _UpdateWeightScreenState();
}

class _UpdateWeightScreenState extends State<UpdateWeightScreen> {
  final weightController = TextEditingController();
  String? prvWeight;
  String? newWeight;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserInfoBloc, UpdateUserInfoState>(
      listener: (context, state) {
        if (state is UpdateUserSuccess) {
          prvWeight = newWeight;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Weight'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BlocBuilder<MyUserBloc, MyUserState>(builder: (context, state) {
          prvWeight = state.user?.weight;
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Weight: ${prvWeight ?? ''}"),
                  Text("Height: ${state.user?.height ?? ''}"),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: weightController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your text here',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      MyUser? user = state.user;
                      user = user!.copyWith(
                        weight: weightController.text,
                      );
                      setState(() {
                        context.read<UpdateUserInfoBloc>().add(UpdateUser(
                          user!,
                        ));
                      });
                    },
                    color: Colors.blue,
                    child: const Text("Update Weight"),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
