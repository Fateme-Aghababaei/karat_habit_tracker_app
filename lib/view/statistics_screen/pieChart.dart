import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/entity/statistics_model.dart';
import '../../model/entity/tag_model.dart';

class TagPieChart extends StatefulWidget {
  final List<Statistics> statistics;

  const TagPieChart({super.key, required this.statistics});

  @override
  _TagPieChartState createState() => _TagPieChartState();
}

class _TagPieChartState extends State<TagPieChart> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCirc,
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
    Map<int, Map<String, dynamic>> tagDurations = _aggregateTagData();

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("ردیابی در هفته‌ای که گذشت", style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp,
            )),
          ),
          tagDurations.isEmpty
              ? Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0.r),
              child: Text(
                "هنوز رکوردی را ثبت نکردید",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12.sp,
                ),
              ),
            ),
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1.1,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return PieChart(
                        PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: 36,
                          sections: _showingSections(tagDurations),
                          startDegreeOffset: 110 * _animation.value,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _getTagWidgets(tagDurations),
              ),
              SizedBox(width: 28.0.r),
            ],
          ),
          SizedBox(height: 8.0.r),
        ],
      ),
    );
  }

  Map<int, Map<String, dynamic>> _aggregateTagData() {
    Map<int, Map<String, dynamic>> tagDurationMap = {};

    for (var stat in widget.statistics) {
      for (var track in stat.tracks) {
        final tag = track.tag ?? Tag(id: -1, name: "تعیین نشده", color: Colors.grey.value.toRadixString(16).substring(2));

        if (tagDurationMap.containsKey(tag.id)) {
          tagDurationMap[tag.id]!['duration'] += track.totalTrackDuration;
        } else {
          tagDurationMap[tag.id!] = {
            'duration': track.totalTrackDuration,
            'name': tag.name,
            'color': tag.color,
          };
        }
      }
    }

    tagDurationMap.removeWhere((key, value) => value['duration'] == 0);

    return tagDurationMap;
  }

  List<PieChartSectionData> _showingSections(Map<int, Map<String, dynamic>> tagDurations) {
    final num totalDuration = tagDurations.values.fold(0, (num sum, Map<String, dynamic> entry) => sum + entry['duration']);

    return tagDurations.entries.map((entry) {
      final double sectionValue = (entry.value['duration'] / totalDuration) * 100 * _animation.value;
      return PieChartSectionData(
        color: Color(int.parse('0xFF${entry.value['color']}')),
        value: sectionValue,
        title: '',
        radius: 36,
      );
    }).toList();
  }

  List<Widget> _getTagWidgets(Map<int, Map<String, dynamic>> tagDurations) {
    return tagDurations.entries.map((entry) {
      return Row(
        children: [
          CircleAvatar(
            radius: 6.r,
            backgroundColor: Color(int.parse('0xFF${entry.value['color']}')),
          ),
          SizedBox(width: 8.w),
          Text(
            ' ${_formatDuration(entry.value['duration'])} : ${entry.value['name']}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontFamily: "IRANYekan_number",
              fontSize: 12.5.sp,
            ),
          ),
        ],
      );
    }).toList();
  }

  String _formatDuration(int totalSeconds) {
    final hours = (totalSeconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((totalSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }
}
