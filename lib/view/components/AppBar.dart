import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final RxInt userScore;

  CustomAppBar( {Key? key, required this.userScore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      shadowColor: Colors.transparent,
      titleSpacing: -8,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'کـارات',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Container(
            margin: EdgeInsets.only(left: 22.0.r),
            padding: EdgeInsets.only(left: 1.0.r, right: 6.0.r),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Obx(() {
                  return AnimatedFlipCounter(
                    duration: const Duration(milliseconds: 400),
                    value: userScore.value,
                    padding: EdgeInsets.all(1),
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      fontFamily: "IRANYekan_number",
                    ),
                  );
                }),
                SizedBox(width: 4.0.r),
                Image.asset(
                  'assets/images/coin.png',
                  width: 28.0.r,
                  height: 28.0.r,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
