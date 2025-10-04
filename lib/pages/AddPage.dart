import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_app/provider/provider.dart';

class AddPage extends ConsumerStatefulWidget {
  const AddPage({super.key});

  @override
  ConsumerState<AddPage> createState() => _AddPageState();
}

class _AddPageState extends ConsumerState<AddPage> {
  TextEditingController medicine_name = TextEditingController();

  bool? morning = false;
  bool? afternoon = false;
  bool? night = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text("Medicine Name:", style: TextStyle(fontSize: 18)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextField(
                    controller: medicine_name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          Row(
            spacing: 40,
            children: [
              Row(
                children: [
                  Text("Morning"),
                  Checkbox(
                    hoverColor: Colors.red,
                    value: morning,
                    onChanged: (bool? value) {
                      setState(() {
                        morning = value;
                      });
                    },
                  ),
                ],
              ),

              Row(
                children: [
                  Text("Afternoon"),
                  Checkbox(
                    hoverColor: Colors.red,
                    value: afternoon,
                    onChanged: (bool? value) {
                      setState(() {
                        afternoon = value;
                      });
                    },
                  ),
                ],
              ),

              Row(
                children: [
                  Text("Night"),
                  Checkbox(
                    hoverColor: Colors.red,
                    value: night,
                    onChanged: (bool? value) {
                      setState(() {
                        night = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Center(
            child: FilledButton(
              onPressed: () {
                final newList = {
                  "medicine_name": medicine_name.text,
                  "isMorning": morning,
                  "isAfternoon": afternoon,
                  "isNight": night,
                };
                ref.read(medicineListProvider).add(newList);

                if (medicine_name.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text("Check the field"),
                    ),
                  );
                }
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Added Succesfully")));
              },
              child: Text("Add"),
            ),
          ),
        ],
      ),
    );
  }
}
