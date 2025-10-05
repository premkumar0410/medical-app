import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_app/provider/provider.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  @override
  Widget build(BuildContext context) {
    final medicineList = ref.watch(medicineListProvider);

    return medicineList.isEmpty
        ? Center(child: Text("Add Some Medicines"))
        : ListView.builder(
            itemCount: medicineList.length,
            itemBuilder: (context, index) {
              final medItem = medicineList[index];
              return InkWell(
                borderRadius: BorderRadius.circular(20),
                splashColor: Colors.lightBlue,
                onLongPress: () => onHoldToEdit(medItem),

                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 500),
                      content: Text("Hold To Edit The Data"),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 198, 237, 247),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    constraints: BoxConstraints(minHeight: 150),

                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  medItem["medicineName"],
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              medItem["isTaken"]
                                  ? Icon(Icons.timelapse_outlined, size: 30)
                                  : Icon(Icons.done_all_rounded, size: 30),
                            ],
                          ),
                          SizedBox(height: 30),
                          Container(
                            height: 35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    medItem["isMorning"]
                                        ? Image.asset("images/sun (1).png")
                                        : SizedBox(width: 20),
                                    SizedBox(width: 20),
                                    medItem["isAfternoon"]
                                        ? Image.asset("images/cloud.png")
                                        : SizedBox(width: 20),
                                    SizedBox(width: 20),
                                    medItem["isNight"]
                                        ? Image.asset("images/half-moon.png")
                                        : SizedBox(width: 20),

                                    SizedBox(width: 20),
                                  ],
                                ),

                                FilledButton(
                                  onPressed: () {
                                    setState(() {
                                      medItem["isTaken"] = !medItem["isTaken"];
                                    });
                                  },
                                  child: medItem["isTaken"]
                                      ? Text(
                                          "Mark as Taken",
                                          style: TextStyle(fontSize: 15),
                                        )
                                      : Text("Taken"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
    // Container(
    //     child: ListView.builder(
    //       itemCount: medicineList.length,
    //       itemBuilder: (context, index) {
    //         final item = medicineList[index];
    //         return Column(
    //           children: [
    //             SizedBox(height: 10),

    //             SizedBox(height: 20),
    //             GestureDetector(
    //               onTap: () {
    //                 onTapToEdit(item);
    //                 print(index);
    //                 setState(() {});
    //               },
    //               child: Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                   horizontal: 10,
    //                   vertical: 5,
    //                 ),
    //                 child: Container(
    //                   constraints: BoxConstraints(minHeight: 150),
    //                   decoration: BoxDecoration(
    //                     color: const Color.fromARGB(255, 223, 221, 221),
    //                     borderRadius: BorderRadius.circular(20),
    //                   ),
    //                   child: Padding(
    //                     padding: const EdgeInsets.symmetric(
    //                       horizontal: 20,
    //                       vertical: 10,
    //                     ),
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Center(
    //                           child: Text(
    //                             item["medicineName"],
    //                             style: TextStyle(fontSize: 20),
    //                           ),
    //                         ),
    //                         Row(
    //                           mainAxisAlignment:
    //                               MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             Checkbox(
    //                               value: item["isTaken"],
    //                               onChanged: (value) {
    //                                 setState(() {
    //                                   item["isTaken"] = !item["isTaken"];
    //                                 });
    //                               },
    //                             ),
    //                             Text(
    //                               [
    //                                 if (item["isMorning"] == true)
    //                                   "Morning",
    //                                 if (item["isAfternoon"] == true)
    //                                   "Afternoon",
    //                                 if (item["isNight"] == true) "Night",
    //                               ].join(",  "),
    //                             ),
    //                             IconButton(
    //                               onPressed: () {
    //                                 showDialog(
    //                                   context: context,
    //                                   builder: (context) {
    //                                     return AlertDialog(
    //                                       content: Text(
    //                                         "Are you Sure? Do you want to remove",
    //                                       ),
    //                                       actions: [
    //                                         FilledButton(
    //                                           onPressed: () {
    //                                             Navigator.pop(context);
    //                                           },
    //                                           child: Text("cancel"),
    //                                         ),
    //                                         FilledButton(
    //                                           onPressed: () {
    //                                             setState(() {
    //                                               ref
    //                                                   .read(
    //                                                     hinstoryListProvider,
    //                                                   )
    //                                                   .add(item);

    //                                               ref
    //                                                   .read(
    //                                                     medicineListProvider,
    //                                                   )
    //                                                   .remove(item);
    //                                             });
    //                                             Navigator.pop(context);

    //                                             ScaffoldMessenger.of(
    //                                               context,
    //                                             ).showSnackBar(
    //                                               SnackBar(
    //                                                 duration: Duration(
    //                                                   milliseconds: 800,
    //                                                 ),
    //                                                 content: Text(
    //                                                   "Removed Successfully",
    //                                                 ),
    //                                               ),
    //                                             );
    //                                           },
    //                                           child: Text("Yes"),
    //                                         ),
    //                                       ],
    //                                     );
    //                                   },
    //                                 );
    //                               },
    //                               icon: Icon(Icons.delete),
    //                             ),
    //                           ],
    //                         ),
    //                         ElevatedButton(
    //                           onPressed: () {
    //                             setState(() {
    //                               item["isTaken"] = !item["isTaken"];
    //                             });
    //                           },
    //                           child: item["isTaken"]
    //                               ? Text("Not Taken")
    //                               : Text("Taken"),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         );
    //       },
    //     ),
    //   );
  }

  void onHoldToEdit(Map<String, dynamic> item) {
    TextEditingController editMedicineName = TextEditingController(
      text: item["medicineName"],
    );
    bool isMorning = item["isMorning"];
    bool isAfternoon = item["isAfternoon"];
    bool isNight = item["isNight"];

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SafeArea(
          child: StatefulBuilder(
            builder: (BuildContext context, setState) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Edit Medicine",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Medicine Name", style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    TextField(
                      controller: editMedicineName,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 10),

                    Text("Scedule Time", style: TextStyle(fontSize: 20)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              isMorning
                                  ? Image.asset(
                                      "images/sun (1).png",
                                      height: 30,
                                    )
                                  : Image.asset("images/sun.png", height: 30),

                              Text("Moring"),

                              Switch(
                                value: isMorning,
                                onChanged: (value) {
                                  setState(() {
                                    isMorning = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              isAfternoon
                                  ? Image.asset("images/cloud.png", height: 30)
                                  : Image.asset("images/sunny.png", height: 30),

                              Text("Afternoon"),

                              Switch(
                                value: isAfternoon,
                                onChanged: (value) {
                                  setState(() {
                                    isAfternoon = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              isNight
                                  ? Image.asset(
                                      "images/half-moon.png",
                                      height: 30,
                                    )
                                  : Image.asset(
                                      "images/night-mode.png",
                                      height: 30,
                                    ),

                              Text("Night"),
                              Switch(
                                value: isNight,
                                onChanged: (value) {
                                  setState(() {
                                    isNight = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                        FilledButton(
                          onPressed: () {
                            item["medicineName"] = editMedicineName.text;
                            item["isMorning"] = isMorning;
                            item["isAfternoon"] = isAfternoon;
                            item["isNight"] = isNight;

                            final list = [...ref.read(medicineListProvider)];

                            final index = list.indexOf(item);

                            list[index] = item;

                            ref.read(medicineListProvider.notifier).state =
                                list;

                            Navigator.pop(context);
                          },
                          child: Text("Save"),
                        ),
                      ],
                    ),
                  ],
                ),
              );
              // AlertDialog(

              //   title: Text("Edit Medicine"),
              //   content: Container(
              //     height: 210,
              //     child: Column(
              //       children: [
              //         Row(
              //           children: [
              //             Text("Edit Name :"),
              //             SizedBox(width: 10),
              //             Expanded(
              //               child: TextField(
              //                 controller: editMedicineName,
              //                 decoration: InputDecoration(
              //                   border: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(20),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //         SizedBox(height: 10),
              //         Row(
              //           children: [
              //             Text("Morning"),
              //             Checkbox(
              //               value: isMorning,
              //               onChanged: (value) {
              //                 setState(() {
              //                   isMorning = value!;
              //                 });
              //               },
              //             ),
              //           ],
              //         ),
              //         Row(
              //           children: [
              //             Text("AfterNoon"),
              //             Checkbox(
              //               value: isAfternoon,
              //               onChanged: (value) {
              //                 setState(() {
              //                   isAfternoon = value!;
              //                 });
              //               },
              //             ),
              //           ],
              //         ),
              //         Row(
              //           children: [
              //             Text("Night"),
              //             Checkbox(
              //               value: isNight,
              //               onChanged: (value) {
              //                 setState(() {
              //                   isNight = value!;
              //                 });
              //               },
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              //   actions: [
              //     ElevatedButton(
              //       onPressed: () {
              //         Navigator.pop(context);
              //       },
              //       child: Text("Cancel"),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {
              //         item["medicineName"] = editMedicineName.text;
              //         item["isMorning"] = isMorning;
              //         item["isAfternoon"] = isAfternoon;
              //         item["isNight"] = isNight;

              //         // ✅ If using Riverpod, update the whole list here
              //         final list = [...ref.read(medicineListProvider)];
              //         final index = list.indexOf(item);
              //         list[index] = item;

              //         ref.read(medicineListProvider.notifier).state = list;

              //         Navigator.pop(context);
              //       },
              //       child: Text("ok"),
              //     ),
              //   ],
              // );
            },
          ),
        );
      },
    );
  }
}
