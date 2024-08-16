import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AboutPage extends StatelessWidget {


  const AboutPage({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () => Get.back()
          ),
        ],
        title: Text(
          "درباره ما",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 15.sp,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.r),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
