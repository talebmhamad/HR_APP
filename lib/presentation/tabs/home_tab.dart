import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/widgets/chart_card.dart';
import 'package:flutter_application_1/presentation/widgets/page_appbar.dart';
import 'package:flutter_application_1/presentation/widgets/trackedhours_card.dart';
import 'package:flutter_application_1/presentation/widgets/who_in_out_card.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/providers/attendance_provider.dart';
import 'package:flutter_application_1/providers/employee_provider.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final provider = context.read<AttendanceProvider>();

      final employeeId =
          context.read<EmployeeProvider>().employee?.employeeId ?? 0;

      provider.loadTodayCount(employeeId);
      provider.GetTotalWorkHours(employeeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppPageAppBar(title: loc.menuHome, hasback: false),
      body: ListView.builder(
        padding: EdgeInsets.all(w * 0.04),
        itemCount: 4,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return const WhoInOutCard();
            case 1:
              return const TrackedHoursCard();
            case 2:
              return ChartCard(title: loc.projects);
            case 3:
              return ChartCard(title: loc.activities);
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
