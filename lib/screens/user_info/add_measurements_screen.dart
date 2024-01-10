import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_demo/blocs/measurements_bloc/measurements_bloc.dart';
import 'package:flutter_demo/screens/user_info/measurements_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_repository/user_repository.dart';

/// A screen that allows a user to add a new measurements record.
// ignore: must_be_immutable
class AddMeasurementsScreen extends StatefulWidget {
  String userId;

  /// Constructs a new [AddMeasurementsScreen].
  /// Requires the current user's [userId].
  AddMeasurementsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<AddMeasurementsScreen> createState() => _AddMeasurementsScreenState();
}

class _AddMeasurementsScreenState extends State<AddMeasurementsScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController weightController = TextEditingController();
  final TextEditingController bodyFatController = TextEditingController();
  final TextEditingController neckController = TextEditingController();
  final TextEditingController armController = TextEditingController();
  final TextEditingController waistController = TextEditingController();
  final TextEditingController hipController = TextEditingController();
  final TextEditingController thighController = TextEditingController();
  final TextEditingController backHandController = TextEditingController();
  final TextEditingController abdomenController = TextEditingController();
  final TextEditingController lowerBackController = TextEditingController();
  final TextEditingController legController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    weightController.dispose();
    bodyFatController.dispose();
    neckController.dispose();
    armController.dispose();
    waistController.dispose();
    hipController.dispose();
    thighController.dispose();
    backHandController.dispose();
    abdomenController.dispose();
    lowerBackController.dispose();
    legController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeasurementsBloc, MeasurementsState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: GestureDetector(
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
              backgroundColor: Theme.of(context).colorScheme.background,
              body: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        // Title
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'NEW',
                                style: GoogleFonts.playfairDisplay(
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontSize: 42,
                                ),
                              ),
                              Text(
                                'MEASUREMENTS',
                                style: GoogleFonts.playfairDisplay(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 42,
                                ),
                              ),
                              Text(
                                'RECORD',
                                style: GoogleFonts.playfairDisplay(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontSize: 42,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 45),
                        Row(
                          children: [
                            // Weight field
                            Expanded(
                              child: TextFormField(
                                controller: weightController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  labelText: "Weight",
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please fill in this field';
                                  } else if (value.length < 2) {
                                    return 'Please enter a valid weight';
                                  } else {
                                    try {
                                      double weight = double.parse(value);
                                      if (weight < 30 || weight > 250) {
                                        return 'Please enter a valid weight';
                                      }
                                    } catch (e) {
                                      return 'Please enter a valid input';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            // Body Fat field
                            Expanded(
                              child: TextFormField(
                                controller: bodyFatController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  labelText: "Body Fat %",
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please fill in this field';
                                  } else {
                                    try {
                                      double fat = double.parse(value);
                                      if (fat < 3 || fat > 50) {
                                        return 'Please enter a valid body fat %';
                                      }
                                    } catch (e) {
                                      return 'Please enter a valid input';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                            height: 16.0), // Add spacing between the rows
                        Row(
                          children: [
                            // Neck field
                            Expanded(
                              child: TextFormField(
                                controller: neckController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  labelText: "Neck",
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please fill in this field';
                                  } else {
                                    try {
                                      double neck = double.parse(value);
                                      if (neck < 10 || neck > 50) {
                                        return 'Please enter a valid neck circumference';
                                      }
                                    } catch (e) {
                                      return 'Please enter a valid input';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                                width: 16.0), // Add spacing between the fields
                            // Arm field
                            Expanded(
                              child: TextFormField(
                                controller: armController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  labelText: "Arm",
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please fill in this field';
                                  } else {
                                    try {
                                      double arm = double.parse(value);
                                      if (arm < 10 || arm > 200) {
                                        return 'Please enter a valid arm circumference';
                                      }
                                    } catch (e) {
                                      return 'Please enter a valid input';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                                width: 16.0), // Add spacing between the fields
                            // Waist field
                            Expanded(
                              child: TextFormField(
                                controller: waistController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  labelText: "Waist",
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please fill in this field';
                                  } else {
                                    try {
                                      double waist = double.parse(value);
                                      if (waist < 20 || waist > 200) {
                                        return 'Please enter a valid waist circumference';
                                      }
                                    } catch (e) {
                                      return 'Please enter a valid input';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            // Hip field
                            Expanded(
                              child: TextFormField(
                                controller: hipController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  labelText: "Hip",
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please fill in this field';
                                  } else {
                                    try {
                                      double hip = double.parse(value);
                                      if (hip < 50 || hip > 200) {
                                        return 'Please enter a valid hip circumference';
                                      }
                                    } catch (e) {
                                      return 'Please enter a valid input';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                            height: 16.0), // Add spacing between the rows
                        Row(
                          children: [
                            // Thigh field
                            Expanded(
                              child: TextFormField(
                                controller: thighController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  labelText: "Thigh",
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please fill in this field';
                                  } else {
                                    try {
                                      double thigh = double.parse(value);
                                      if (thigh < 10 || thigh > 100) {
                                        return 'Please enter a valid arm circumference';
                                      }
                                    } catch (e) {
                                      return 'Please enter a valid input';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                                width: 16.0), // Add spacing between the fields
                            // Back Hand field
                            Expanded(
                              child: TextFormField(
                                controller: backHandController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  labelText: "Back Hand",
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please fill in this field';
                                  } else {
                                    try {
                                      double hand = double.parse(value);
                                      if (hand < 0 || hand > 100) {
                                        return 'Please enter a valid hand measurement';
                                      }
                                    } catch (e) {
                                      return 'Please enter a valid input';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                                width: 16.0), // Add spacing between the fields
                            //
                            Expanded(
                              child: TextFormField(
                                controller: abdomenController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  labelText: "Abdomen",
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please fill in this field';
                                  } else {
                                    try {
                                      double abs = double.parse(value);
                                      if (abs < 0 || abs > 100) {
                                        return 'Please enter a valid abs measurement';
                                      }
                                    } catch (e) {
                                      return 'Please enter a valid input';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            // Lower Back field
                            Expanded(
                              child: TextFormField(
                                controller: lowerBackController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  labelText: "Lower Back",
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please fill in this field';
                                  } else {
                                    try {
                                      double back = double.parse(value);
                                      if (back < 0 || back > 100) {
                                        return 'Please enter a valid back measurement';
                                      }
                                    } catch (e) {
                                      return 'Please enter a valid input';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                                width: 16.0), // Add spacing between the fields
                            // Leg field
                            Expanded(
                              child: TextFormField(
                                controller: legController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  labelText: "Leg Pinch",
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please fill in this field';
                                  } else {
                                    try {
                                      double leg = double.parse(value);
                                      if (leg < 0 || leg > 100) {
                                        return 'Please enter a valid leg measurement';
                                      }
                                    } catch (e) {
                                      return 'Please enter a valid input';
                                    }
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                            height: 35.0), // Add spacing between the rows
                        Row(
                          children: [
                            // Save records changes
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  minimumSize: const Size(double.infinity, 55),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.error,
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Create a record from the form values
                                    Measurements newRecord = Measurements.empty;
                                    newRecord = newRecord.copyWith(
                                      weight: weightController.text,
                                      bodyFat: bodyFatController.text,
                                      neckCircumference: neckController.text,
                                      armCircumference: armController.text,
                                      waistCircumference: waistController.text,
                                      hipCircumference: hipController.text,
                                      thighCircumference: thighController.text,
                                      backHand: backHandController.text,
                                      abdomen: abdomenController.text,
                                      lowerBack: lowerBackController.text,
                                      leg: legController.text,
                                    );
                                    setState(() {
                                      context.read<MeasurementsBloc>().add(
                                          AddMeasurements(
                                              measurement: newRecord,
                                              userId: widget.userId));
                                    });
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                            create: (context) => MeasurementsBloc(
                                                userRepository: context
                                                    .read<AuthenticationBloc>()
                                                    .userRepository)
                                              ..add(GetMeasurementsList(
                                                  userId: context
                                                      .read<
                                                          AuthenticationBloc>()
                                                      .state
                                                      .user!
                                                      .uid)),
                                          ),
                                        ],
                                        child: MeasurementsScreen(
                                            userId: context
                                                .read<AuthenticationBloc>()
                                                .state
                                                .user!
                                                .uid),
                                      );
                                    }));
                                  }
                                },
                                child: Text(
                                  "SAVE",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
