import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/view/statistics_screen/pieChart.dart';
import 'package:karat_habit_tracker_app/view/statistics_screen/todayState.dart';
import '../error_screen.dart';
import '../../viewmodel/statistics_viewmodel.dart';
import '../components/AppBar.dart';
import '../components/BottomNavigationBar.dart';
import '../components/Sidebar/Sidebar.dart';
import 'barChart.dart';

class StatisticsPage extends StatelessWidget {
  final StatisticsViewModel statisticsViewModel = Get.put(StatisticsViewModel());

  StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(userScore: statisticsViewModel.sideBarController.userScore),
      drawer: SideBar(),
      body: Obx(() {
        if (statisticsViewModel.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (statisticsViewModel.fetchError.value) {
          return FractionallySizedBox(
            widthFactor: 1.0.r,
            heightFactor: 0.9.r,
            child: const Error(),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(16.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TodayStatisticsWidget(
                  totalHabits: statisticsViewModel.statisticsList[0].totalHabits,
                  completedHabits: statisticsViewModel.statisticsList[0].completedHabits,
                ),
                SizedBox(height: 20.0.r,),
                StatisticsBarChart(statistics: statisticsViewModel.statisticsList),
                SizedBox(height: 20.0.r,),
                TagPieChart(statistics: statisticsViewModel.statisticsList),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 0.obs),
    );
  }
}
