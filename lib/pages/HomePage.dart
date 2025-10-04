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
    return ListView.builder(
      itemCount: medicineList.length,
      itemBuilder: (context, index) {
        final item = medicineList[index];
        return ListTile(
          title: Text(item["medicine_name"]),
          subtitle: Text(
            [
              if (item["isMorning"] == true) "Morning",
              if (item["isAfternoon"] == true) "Evening",
              if (item["isNight"] == true) "Night",
            ].join(",  "),
          ),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                ref.read(medicineListProvider).removeAt(index);
              });
            },
            icon: Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
