import 'package:expense_tracker/views/dashboard/revenue_history_view.dart';
import 'package:flutter/material.dart';

class AllRevenueView extends StatelessWidget {
  const AllRevenueView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Income List",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: const [
            Expanded(child: RevenueHistoryView(showAll: true)),
          ],
        ),
      ),
    );
  }
}
