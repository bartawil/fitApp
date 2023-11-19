import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutScreen extends StatelessWidget {
  final controller = GifController(autoPlay: false);
  WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: DefaultTabController(
          length: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Choose your workout',
                    style: GoogleFonts.caveat(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn),
                      child: Image.asset('assets/images/dumbel.png',
                          width: 50, height: 50),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TabBar(
                  labelColor: Theme.of(context).colorScheme.onBackground,
                  labelStyle: GoogleFonts.playfairDisplay(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 22,
                  ),
                  
                  tabs: const [
                    Tab(
                      text: 'I',
                    ),
                    Tab(
                      text: 'II',
                    ),
                    Tab(
                      text: 'III',
                    ),
                  ]),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
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
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, left: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    if (controller.status ==
                                        GifStatus.playing) {
                                      controller.pause();
                                    } else {
                                      controller.play();
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
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: GifView.asset(
                                      'assets/images/Barbell-squat.gif',
                                      height: 100,
                                      width: 100,
                                      controller: controller,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
