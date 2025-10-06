import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_app/provider/provider.dart';

class Historypage extends ConsumerStatefulWidget {
  const Historypage({super.key});

  @override
  ConsumerState<Historypage> createState() => _HistorypageState();
}

class _HistorypageState extends ConsumerState<Historypage> {
  @override
  Widget build(BuildContext context) {
    final historyList = ref.watch(hinstoryListProvider);

    return historyList.isEmpty
        ? Center(child: Text("Add Some Medicines"))
        : ListView.builder(
            itemCount: historyList.length,
            itemBuilder: (context, index) {
              final medItem = historyList[index];
              return InkWell(
                borderRadius: BorderRadius.circular(20),
                splashColor: Colors.lightBlue,

                // onLongPress: () => onHoldToEdit(medItem),
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

                              Icon(Icons.restore, size: 30),
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
                                    // restore item to medicine list
                                    final restore = ref.read(
                                      medicineListProvider,
                                    );
                                    final restoreitem = [...restore]
                                      ..add(medItem);

                                    ref
                                            .read(medicineListProvider.notifier)
                                            .state =
                                        restoreitem;

                                    // delete from history after restore
                                    final removehistory = ref.read(
                                      hinstoryListProvider,
                                    );
                                    final removehistoryAfterRestore = [
                                      ...removehistory,
                                    ]..remove(medItem);

                                    ref
                                            .read(hinstoryListProvider.notifier)
                                            .state =
                                        removehistoryAfterRestore;

                                    setState(() {
                                      medItem["isRestore"] =
                                          !medItem["isRestore"];
                                    });
                                  },
                                  child: Text("Restore"),
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
  }
}
