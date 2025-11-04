import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnalyticsView extends StatelessWidget {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with real analytics data later
    final stats = {
      'Orders': '1,254',
      'Revenue': '\$12,540',
      'Active Users': '3,412',
      'Products': '842',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // TODO: trigger analytics refresh
              Get.snackbar('Info', 'Refreshing analytics...');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Stats grid
            Row(
              children: [
                Expanded(
                  child: _StatCard(title: 'Orders', value: stats['Orders']!),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(title: 'Revenue', value: stats['Revenue']!),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Active Users',
                    value: stats['Active Users']!,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'Products',
                    value: stats['Products']!,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Placeholder for charts
            Expanded(
              child: Card(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.show_chart, size: 56),
                      SizedBox(height: 8),
                      Text(
                        'Charts go here\n(e.g., fl_chart, charts_flutter)',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
