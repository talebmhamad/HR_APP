import 'package:flutter/material.dart';
import 'dashboard_utils.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';

class TrackedHoursCard extends StatelessWidget {
  const TrackedHoursCard({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          buildCardHeader(loc.trackedHours),

          // 1. Top Stats
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildTopStat("-", loc.worked),
                buildTopStat("-", loc.breaks),
                buildTopStat("-", loc.overtime),
              ],
            ),
          ),

          const Divider(height: 1),

          // 2. Histogram Area
          Container(
            height: 250,
            padding: const EdgeInsets.fromLTRB(16, 24, 24, 16),
            child: const HistogramWidget(),
          ),

          // 3. Legend
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildLegendItem(const Color(0xFF63C64D), loc.workedHours),
                    const SizedBox(width: 16),
                    buildLegendItem(const Color(0xFFEEB13E), loc.breaksLabel),
                    const SizedBox(width: 16),
                    buildLegendItem(const Color(0xFFC3304B), loc.overtimeHours),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  loc.payrollNote,
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 11),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTopStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}

class HistogramWidget extends StatelessWidget {
  const HistogramWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.infinite, painter: HistogramPainter(context));
  }
}

class HistogramPainter extends CustomPainter {
  final BuildContext context;

  HistogramPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final loc = AppLocalizations.of(context)!;

    final linePaint = Paint()
      ..color = Colors.grey.withOpacity(0.15)
      ..strokeWidth = 1;

    final textPainter = TextPainter(textDirection: Directionality.of(context));

    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final marks = ['0', '20', '40', '60', '80', '100'];

    double chartLeft = 25;
    double chartTop = 20;
    double chartWidth = size.width - chartLeft;
    double chartHeight = size.height - chartTop;

    // Vertical grid + X labels
    for (int i = 0; i < marks.length; i++) {
      double x = chartLeft + (i * (chartWidth / (marks.length - 1)));

      canvas.drawLine(Offset(x, chartTop), Offset(x, size.height), linePaint);

      textPainter.text = TextSpan(
        text: marks[i],
        style: const TextStyle(color: Colors.grey, fontSize: 10),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, 0));
    }

    // Day labels (Y axis)
    double rowHeight = chartHeight / days.length;
    for (int i = 0; i < days.length; i++) {
      double y = chartTop + (i * rowHeight) + (rowHeight / 2);

      textPainter.text = TextSpan(
        text: days[i],
        style: const TextStyle(color: Colors.black87, fontSize: 12),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, y - textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
