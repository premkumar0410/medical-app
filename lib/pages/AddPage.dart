import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_app/provider/provider.dart';

class AddPage extends ConsumerStatefulWidget {
  const AddPage({super.key});

  @override
  ConsumerState<AddPage> createState() => _AddPageState();
}

class _AddPageState extends ConsumerState<AddPage> {
  TextEditingController medicineName = TextEditingController();

  bool morning = false;
  bool afternoon = false;
  bool night = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        // color: const Color.fromARGB(255, 203, 223, 233),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 100),
            Text("Add Medicine", style: TextStyle(fontSize: 25)),
            SizedBox(height: 50),

            Container(
              constraints: BoxConstraints(minHeight: 400, maxWidth: 350),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Medicine Name", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    TextField(
                      controller: medicineName,
                      decoration: InputDecoration(
                        hintText: "e.g : Paracetamol",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            morning
                                ? Image.asset("images/sun (1).png")
                                : Image.asset("images/sun.png"),

                            Text("Moring"),

                            Switch(
                              value: morning,
                              onChanged: (value) {
                                setState(() {
                                  morning = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            afternoon
                                ? Image.asset("images/cloud.png")
                                : Image.asset("images/sunny.png"),

                            Text("Afternoon"),

                            Switch(
                              value: afternoon,
                              onChanged: (value) {
                                setState(() {
                                  afternoon = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            night
                                ? Image.asset("images/half-moon.png")
                                : Image.asset("images/night-mode.png"),

                            Text("Night"),
                            Switch(
                              value: night,
                              onChanged: (value) {
                                setState(() {
                                  night = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                final newList = {
                  "medicineName": medicineName.text,
                  "isMorning": morning,
                  "isAfternoon": afternoon,
                  "isNight": night,
                  "isTaken": false,
                };

                if (medicineName.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 800),
                      content: Text("Check the field properly"),
                    ),
                  );
                } else {
                  ref.read(medicineListProvider).add(newList);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 800),
                      content: Text("Added sucessfully"),
                    ),
                  );
                  medicineName.clear();
                  setState(() {
                    morning = false;
                    afternoon = false;
                    night = false;
                  });
                }
              },
              child: Text("Add Medicines..."),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
    // Center(
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Container(
    //       height: 250,

    //       decoration: BoxDecoration(
    //         color: const Color.fromARGB(255, 228, 227, 226),
    //         borderRadius: BorderRadius.circular(20),
    //         boxShadow: [BoxShadow(blurRadius: 5, blurStyle: BlurStyle.solid)],
    //       ),

    //       child: Padding(
    //         padding: const EdgeInsets.only(top: 30, left: 10, right: 8),
    //         child: Column(
    //           children: [
    //             Row(
    //               children: [
    //                 Text("Medicine Name:", style: TextStyle(fontSize: 18)),
    //                 Expanded(
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(left: 10),
    //                     child: TextField(
    //                       controller: medicineName,
    //                       decoration: InputDecoration(
    //                         hintText: "Add Medicine",
    //                         border: OutlineInputBorder(
    //                           borderRadius: BorderRadius.circular(20),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             SizedBox(height: 20),

    //             Row(
    //               spacing: 40,
    //               children: [
    //                 Row(
    //                   children: [
    //                     Text("Morning"),
    //                     Checkbox(
    //                       value: morning,
    //                       onChanged: (bool? value) {
    //                         setState(() {
    //                           morning = value;
    //                         });
    //                       },
    //                     ),
    //                   ],
    //                 ),

    //                 Row(
    //                   children: [
    //                     Text("Afternoon"),
    //                     Checkbox(
    //                       value: afternoon,
    //                       onChanged: (bool? value) {
    //                         setState(() {
    //                           afternoon = value;
    //                         });
    //                       },
    //                     ),
    //                   ],
    //                 ),

    //                 Row(
    //                   children: [
    //                     Text("Night"),
    //                     Checkbox(
    //                       value: night,
    //                       onChanged: (bool? value) {
    //                         setState(() {
    //                           night = value;
    //                         });
    //                       },
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //             SizedBox(height: 20),
    //             Center(
    //               child: FilledButton(
    //                 onPressed: () {
    //                   final newList = {
    //                     "medicineName": medicineName.text,
    //                     "isMorning": morning,
    //                     "isAfternoon": afternoon,
    //                     "isNight": night,
    //                     "isTaken": false,
    //                   };

    //                   if (medicineName.text.isEmpty) {
    //                     ScaffoldMessenger.of(context).showSnackBar(
    //                       SnackBar(
    //                         duration: Duration(milliseconds: 800),
    //                         content: Text("Check the field"),
    //                       ),
    //                     );
    //                   } else {
    //                     ref.read(medicineListProvider).add(newList);
    //                     ScaffoldMessenger.of(context).showSnackBar(
    //                       SnackBar(
    //                         duration: Duration(milliseconds: 800),
    //                         content: Text("Added Succesfully"),
    //                       ),
    //                     );
    //                   }
    //                 },
    //                 child: Text("Add"),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
