import 'package:flutter/material.dart';

class Interests extends StatefulWidget {
  final Function(List<String>) onSelectedHobbiesChanged;

  const Interests({Key? key, required this.onSelectedHobbiesChanged})
      : super(key: key);

  @override
  _InterestsState createState() => _InterestsState();
}

class _InterestsState extends State<Interests> {
  final List<String> _hobbies = [
    'Photography',
    'Cooking',
    'Gardening',
    'Music',
    'Reading',
    'Writing',
    'Traveling',
    'Sports',
    'Painting',
    'Dancing',
    'Yoga',
    'Gaming',
  ];
  final List<String> _selectedHobbies = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Interests',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 10.0),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: _hobbies.map(
            (hobby) {
              return CheckboxListTile(
                title: Text(hobby),
                value: _selectedHobbies.contains(hobby),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _selectedHobbies.add(hobby);
                    } else {
                      _selectedHobbies.remove(hobby);
                    }
                    widget.onSelectedHobbiesChanged(_selectedHobbies);
                  });
                },
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
