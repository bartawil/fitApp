import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';

class ExerciseList extends StatelessWidget {
  final List<GifController> controllers = []; // Create a list of controllers
  final int numOfExercises;

  ExerciseList({Key? key, required this.numOfExercises}) : super(key: key) {
    // Initialize the list of controllers
    for (int i = 0; i < numOfExercises; i++) {
      controllers.add(GifController(autoPlay: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: numOfExercises,
        itemBuilder: (context, int i) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[300]!,
                    width: 0.5,
                  ),
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 0.0,
                    vertical: 0.0), // Increase the vertical padding.
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, left: 10),
                      child: GestureDetector(
                        onTap: () {
                          for (int j = 0; j < controllers.length; j++) {
                            if (j == i) {
                              if (controllers[j].status == GifStatus.playing) {
                                controllers[j].pause();
                              } else {
                                controllers[j].play();
                              }
                            } else {
                              controllers[j].pause();
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: GifView.asset(
                            'assets/images/Barbell-squat.gif',
                            height: 100,
                            width: 100,
                            controller: controllers[
                                i], // Use the corresponding controller
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 20.0,
                          bottom:
                              8.0), // Add padding to the bottom of the title.
                      child: Text(
                        'Name of exercise\n\nReps: 10\nSets: 3',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
