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
        ? Center(child: Text("Empty"))
        : ListView.builder(
            itemCount: historyList.length,
            itemBuilder: (context, index) {
              final historyItem = historyList[index];
              return Container(
                child: Column(children: [Text(historyItem["medicineName"])]),
              );
            },
          );
  }
}
