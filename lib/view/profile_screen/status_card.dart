import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const StatusCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12.0.r),
         // border: Border.all(color: Colors.grey.shade300)
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 0.5,
            offset: const Offset(0, 0.5),
          ),
        ],
      ),
      padding: EdgeInsets.all(8.0.r),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Image.asset(
              '${item['image']}',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 12.0.r),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${item['value']}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontFamily: "IRANYekan_number",
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 4.0.r),
                Text(
                  item['label'],
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
