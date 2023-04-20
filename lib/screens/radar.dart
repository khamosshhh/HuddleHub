import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/models/navbar_model.dart';
import '../utils/widgets/reusable_widgets.dart';
import 'radar/marker.dart';
import 'radar/radar_display.dart';

double range = 100;

class RadarSearch extends StatefulWidget {
  static String routeName = "/radar";
  const RadarSearch({super.key});

  @override
  _RadarSearchState createState() => _RadarSearchState();
}

class _RadarSearchState extends State<RadarSearch> {
  // Define variables to store user input
  String? location;
  List<String> interests = [];
  List<String> genders = [];
  bool isInterestDropdownOpen = false;
  bool isGenderDropdownOpen = false;

  // Define interest options
  final List<String> interestOptions = [
    'Reading',
    'Traveling',
    'Music',
    'Dancing',
    'Cooking',
    'Photography',
    'Sports',
    'Art',
    'Writing',
    'Fashion',
    'Gaming',
    'Fitness',
    'Programming',
    'Movies',
    'Animals',
    'Food',
    'Politics',
    'Business',
    'Education',
    'Environment',
  ];
  final List<String> genderOptions = [
    'Male',
    'Female',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: myAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Interest Filter
              const SizedBox(height: 16.0),
              const Text('Interests'),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isInterestDropdownOpen = !isInterestDropdownOpen;
                  });
                },
                child: AbsorbPointer(
                  absorbing: true,
                  child: TextFormField(
                    controller: TextEditingController(
                      text: interests.isNotEmpty ? interests.join(", ") : null,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Select your interests (Optional)',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                    //validator: emptyValidator,
                  ),
                ),
              ),
              if (isInterestDropdownOpen)
                SizedBox(
                  height: 100,
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio: 2.8,
                    children: interestOptions.map((interest) {
                      return CheckboxListTile(
                        title: Text(interest),
                        value: interests.contains(interest),
                        onChanged: (selected) {
                          setState(() {
                            if (selected!) {
                              interests.add(interest);
                            } else {
                              interests.remove(interest);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),

              // Gender Filter
              const SizedBox(height: 16.0),
              const Text('Gender'),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isGenderDropdownOpen = !isGenderDropdownOpen;
                  });
                },
                child: AbsorbPointer(
                  absorbing: true,
                  child: TextFormField(
                    controller: TextEditingController(
                      text: genders.isNotEmpty ? genders.join(", ") : null,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Select preferred gender (Optional)',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                    //validator: emptyValidator,
                  ),
                ),
              ),
              if (isGenderDropdownOpen)
                SizedBox(
                  height: 130,
                  child: GridView.count(
                    crossAxisCount: 1,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                    childAspectRatio: 7,
                    children: genderOptions.map((gender) {
                      return CheckboxListTile(
                        title: Text(gender),
                        value: genders.contains(gender),
                        onChanged: (selected) {
                          setState(() {
                            if (selected!) {
                              genders.add(gender);
                            } else {
                              genders.remove(gender);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),

              // Distance Filter
              const SizedBox(height: 16.0),
              Text('Range: ' '${range.toInt()} m'),
              Slider(
                value: range,
                min: 100,
                max: 1000,
                divisions: 9,
                onChanged: (value) {
                  setState(() {
                    range = value;
                    Range(range: value.toInt());
                  });
                },
                label: '${range.toInt()} m',
              ),

              // Search Button
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Perform search using user input
                  Get.to(() => const RadarDisplay());
                },
                child: const Text('Search'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: myNavBar(MenuState.radar),
    );
  }
}
