import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../model/constant.dart';
import '../../model/entity/badge_model.dart';
import 'badge_detail.dart';

class BadgesGridScreen extends StatelessWidget {
  final List<MyBadge> badges;

  const BadgesGridScreen({super.key, required this.badges});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('جوایز و افتخارات', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15.sp),),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: GridView.builder(
          itemCount: badges.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.r,
            mainAxisSpacing: 10.r,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => BadgeDetailsScreen(badge: badges[index]));
              },
              child: Image.network('$baseUrl${badges[index].image}'),
            );
          },
        ),
      ),
    );
  }
}
