import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';

class WorkoutScreen extends StatelessWidget {
  final controller = GifController(autoPlay: false);
  WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              await Future.delayed(const Duration(milliseconds: 150));
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            },
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            TabBar(
              indicatorColor: Theme.of(context).colorScheme.secondary,
              labelColor: Theme.of(context).colorScheme.secondary,
              unselectedLabelColor: Theme.of(context).colorScheme.onBackground,
              tabs: const [
                Tab(
                  text: "Workout 1",
                ),
                Tab(
                  text: "Workout 2",
                ),
                Tab(
                  text: "Workout 3",
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                if (controller.status == GifStatus.playing) {
                  controller.pause();
                } else {
                  controller.play();
                }
              },
              child: GifView.asset(
                'assets/images/Barbell-squat.gif',
                height: 200,
                width: 200,
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
