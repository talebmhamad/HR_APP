import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/employee_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/timesheet_provider.dart';
import '../../l10n/app_localizations.dart';

class TimesheetsPage extends StatefulWidget {
  const TimesheetsPage({super.key});

  @override
  State<TimesheetsPage> createState() => _TimesheetsPageState();
}

class _TimesheetsPageState extends State<TimesheetsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final employeeId =
          context.read<EmployeeProvider>().employee?.employeeId ?? 0;

      if (employeeId > 0) {
        context.read<TimesheetProvider>().loadTimesheet(employeeId: employeeId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final employeeId =
        context.read<EmployeeProvider>().employee?.employeeId ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.menuTimesheets),
        centerTitle: true,
      ),
      body: Consumer<TimesheetProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.summary == null) {
            return const Center(child: Text('No data available'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PERIOD SELECTOR
                DropdownButton<String>(
                  value: provider.period,
                  items: const [
                    DropdownMenuItem(value: 'week', child: Text('This Week')),
                    DropdownMenuItem(value: 'month', child: Text('This Month')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      provider.changePeriod(
                        employeeId: employeeId,
                        value: value,
                      );
                    }
                  },
                ),

                const SizedBox(height: 16),

                // SUMMARY CARD
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _row(
                          'Worked Hours',
                          '${provider.summary!.totalHours}h',
                        ),
                        _row(
                          'Days Worked',
                          provider.summary!.daysWorked.toString(),
                        ),
                        _row(
                          'Missing Days',
                          provider.summary!.missingDays.toString(),
                        ),
                        _row('Overtime', '${provider.summary!.overtimeHours}h'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // DAILY LIST
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.dailyList.length,
                    itemBuilder: (context, index) {
                      final day = provider.dailyList[index];

                      return ListTile(
                        title: Text('${day.date.day}/${day.date.month}'),
                        subtitle: Text('${day.hours}h'),
                        trailing: _statusIcon(day.status),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(value)],
      ),
    );
  }

  Widget _statusIcon(String status) {
    switch (status) {
      case 'Complete':
        return const Icon(Icons.check_circle, color: Colors.green);
      case 'Missing':
        return const Icon(Icons.warning, color: Colors.orange);
      default:
        return const Icon(Icons.cancel, color: Colors.red);
    }
  }
}
