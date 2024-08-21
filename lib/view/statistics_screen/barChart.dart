import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../model/entity/statistics_model.dart';

class StatisticsBarChart extends StatefulWidget {
  final List<Statistics> statistics;

  const StatisticsBarChart({super.key, required this.statistics});

  @override
  _StatisticsBarChartState createState() => _StatisticsBarChartState();
}

class _StatisticsBarChartState extends State<StatisticsBarChart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds:800), // مدت زمان انیمیشن را می‌توانید اینجا تغییر دهید
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut, // منحنی انیمیشن را می‌توانید تغییر دهید
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10.0.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 0.5,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("عادت‌ها در هفته‌ای که گذشت", style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 13.sp
                    ),),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 1.5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceEvenly,
                      maxY: _getMaxY(),
                      barTouchData: BarTouchData(enabled: true),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                child: Transform.rotate(
                                  angle: -0.65,
                                  child: Text(
                                    _getPersianWeekdayLabel(value.toInt()),
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                              );
                            },
                            reservedSize: 32,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return Padding(
                                padding: EdgeInsets.only(right: 8.0.w),
                                child: Text(value.toInt().toString(),
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontSize: 10.sp,
                                      fontFamily: "IRANYekan_number",
                                    )),
                              );
                            },
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(
                        show: false,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey.withOpacity(0.3),
                            strokeWidth: 1,
                          );
                        },
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          left: BorderSide(
                            color: Colors.grey.shade600,
                            width: 0.5,
                          ),
                          bottom: BorderSide(
                            color: Colors.grey.shade600,
                            width: 0.5,
                          ),
                          top: BorderSide.none,
                          right: BorderSide.none,
                        ),
                      ),
                      groupsSpace: 32,
                      barGroups: _getStackedBarGroups(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 14.0,
                runSpacing: 4.0,
                alignment: WrapAlignment.center,
                children: _getUniqueTagsLegend(),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }

  double _getMaxY() {
    double maxY = 0;
    for (var stat in widget.statistics) {
      int sum = stat.habits.fold(0, (prev, habit) => prev + habit.completedHabits);
      if (sum > maxY) {
        maxY = sum.toDouble();
      }
    }
    return maxY + 1;
  }

  String _getPersianWeekdayLabel(int index) {
    if (index < widget.statistics.length) {
      final gregorianDate = DateTime.parse(widget.statistics[index].date);
      final jalaliDate = gregorianDate.toJalali();
      return _getPersianWeekday(jalaliDate.weekDay);
    }
    return '';
  }

  String _getPersianWeekday(int weekday) {
    const weekDays = ['شنبه', 'یک‌شنبه', 'دوشنبه', 'سه‌شنبه', 'چهارشنبه', 'پنج‌شنبه', 'جمعه'];
    return weekDays[weekday - 1];
  }

  List<BarChartGroupData> _getStackedBarGroups() {
    return List.generate(widget.statistics.length, (index) {
      final stat = widget.statistics[index];
      double cumulativeY = 0;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(4.0.r),
            ),
            toY: stat.habits.fold(0, (previousValue, habit) => previousValue + habit.completedHabits) * _animation.value,
            rodStackItems: stat.habits.map((habit) {
              final double fromY = cumulativeY * _animation.value;
              final double toY = (cumulativeY + habit.completedHabits.toDouble()) * _animation.value;
              cumulativeY = toY;

              return BarChartRodStackItem(
                fromY,
                toY,
                habit.tag != null
                    ? Color(int.parse('0xFF${habit.tag?.color}'))
                    : Colors.grey,
              );
            }).toList(),
            width: 10,
          ),
        ],
      );
    });
  }

  List<Widget> _getUniqueTagsLegend() {
    final List<String> addedTagIds = [];
    final List<Widget> tags = [];

    for (var stat in widget.statistics) {
      for (var habit in stat.habits) {
        if (habit.tag != null && !addedTagIds.contains(habit.tag!.id.toString())) {
          addedTagIds.add(habit.tag!.id.toString());
          tags.add(
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 5.r, // تنظیم شعاع دایره
                  backgroundColor: Color(int.parse('0xFF${habit.tag!.color}')), // تنظیم رنگ پس‌زمینه
                ),
                SizedBox(width: 4.w),
                Text(habit.tag?.name ?? "تعیین نشده", style: TextStyle(fontSize: 12.sp)),
              ],
            ),
          );
        } else if (habit.tag == null && !addedTagIds.contains('null')) {
          addedTagIds.add('null');
          tags.add(
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 5.r, // تنظیم شعاع دایره
                  backgroundColor: Colors.grey, // تنظیم رنگ پس‌زمینه
                ),
                SizedBox(width: 4.w),
                Text('تعیین نشده', style: TextStyle(fontSize: 12.sp)),
              ],
            ),
          );
        }
      }
    }

    return tags;
  }
}
