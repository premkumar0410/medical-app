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
              final item = medicineList[index];
              return GestureDetector(
                onTap: () {
                  onTapToEdit(item);
                  print(index);
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Container(
                    constraints: BoxConstraints(minHeight: 150),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 223, 221, 221),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Text(
                              item["medicineName"],
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Checkbox(
                                value: item["isTaken"],
                                onChanged: (value) {
                                  setState(() {
                                    item["isTaken"] = !item["isTaken"];
                                  });
                                },
                              ),
                              Text(
                                [
                                  if (item["isMorning"] == true) "Morning",
                                  if (item["isAfternoon"] == true) "Afternoon",
                                  if (item["isNight"] == true) "Night",
                                ].join(",  "),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(
                                          "Are you Sure? Do you want to remove",
                                        ),
                                        actions: [
                                          FilledButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("cancel"),
                                          ),
                                          FilledButton(
                                            onPressed: () {
                                              setState(() {
                                                ref
                                                    .read(medicineListProvider)
                                                    .remove(item);
                                              });
                                              Navigator.pop(context);

                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  duration: Duration(
                                                    milliseconds: 800,
                                                  ),
                                                  content: Text(
                                                    "Removed Successfully",
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text("Yes"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                item["isTaken"] = !item["isTaken"];
                              });
                            },
                            child: item["isTaken"]
                                ? Text("Not Taken")
                                : Text("Taken"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }

  void onTapToEdit(Map<String, dynamic> item) {
    TextEditingController editMedicineName = TextEditingController(
      text: item["medicineName"],
    );
    bool isMorning = item["isMorning"];
    bool isAfternoon = item["isAfternoon"];
    bool isNight = item["isNight"];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text("Edit Medicine"),
              content: Container(
                height: 210,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Edit Name :"),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: editMedicineName,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Morning"),
                        Checkbox(
                          value: isMorning,
                          onChanged: (value) {
                            setState(() {
                              isMorning = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("AfterNoon"),
                        Checkbox(
                          value: isAfternoon,
                          onChanged: (value) {
                            setState(() {
                              isAfternoon = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Night"),
                        Checkbox(
                          value: isNight,
                          onChanged: (value) {
                            setState(() {
                              isNight = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    item["medicineName"] = editMedicineName.text;
                    item["isMorning"] = isMorning;
                    item["isAfternoon"] = isAfternoon;
                    item["isNight"] = isNight;

                    // ✅ If using Riverpod, update the whole list here
                    final list = [...ref.read(medicineListProvider)];
                    final index = list.indexOf(item);
                    list[index] = item;

                    ref.read(medicineListProvider.notifier).state = list;

                    Navigator.pop(context);
                  },
                  child: Text("ok"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
