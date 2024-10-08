import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'add_challenge_controller.dart';

class AddChallengeBottomSheet extends StatelessWidget {
  final AddChallengeController controller;

  const AddChallengeBottomSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 30.0.r,bottom: 16.0.r,left: 16.0.r,right: 16.0.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.83,
                  height: MediaQuery.of(context).size.height * 0.20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0.r),
                    image: DecorationImage(
                      image: controller.selectedImagePath.value.isNotEmpty
                          ? FileImage(File(controller.selectedImagePath.value)) as ImageProvider
                          : const AssetImage('assets/images/challenge.png'),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                );
              }),
              TextButton(
                onPressed: () {
                  controller.showImagePicker(context);
                },
                child: Text(
                  'ویرایش تصویر',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12.sp),
                ),
              ),
              SizedBox(height: 4.0.r,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'نام چالش',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 12.sp),
                  ),
                  SizedBox(height: 4.0.r,),
                  TextField(
                    textInputAction: TextInputAction.next,
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:  BorderSide(
                            color: Theme.of(context).colorScheme.outlineVariant,
                            width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:  BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant,
                          width: 1.0,
                        ),
                      ),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 13.sp,
                        fontFamily: "IRANYekan_number"
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0.r,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'توضیحات',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 12.sp),
                  ),
                  SizedBox(height: 4.0.r,),
                  TextField(
                    maxLines: 2,
                    textInputAction: TextInputAction.done,
                    controller: controller.descriptionController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:  BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:  BorderSide(
                            color: Theme.of(context).colorScheme.outlineVariant,
                            width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:  BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant,
                          width: 1.0,
                        ),
                      ),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 13.sp,
                        fontFamily: "IRANYekan_number"
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0.r,),
              // GestureDetector برای انتخاب تاریخ شروع (شمسی و میلادی)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تاریخ شروع چالش',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12.sp),
                  ),
                  SizedBox(height: 6.0.r),
                  GestureDetector(
                    onTap: () => controller.pickStartDate(context),
                    child: AbsorbPointer(
                      child: Obx(
                            () => TextField(
                          controller: TextEditingController(
                            text: controller.selectedShamsiStartDate.value.isEmpty
                                ? 'انتخاب تاریخ'
                                : controller.selectedShamsiStartDate.value,
                          ),
                          decoration: InputDecoration(
                            hintText: 'انتخاب تاریخ',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0.r),
                              borderSide:  BorderSide(
                                color: Theme.of(context).colorScheme.outlineVariant,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0.r),
                              borderSide:  BorderSide(
                                color: Theme.of(context).colorScheme.outlineVariant,
                                width: 1.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0.r),
                              borderSide:  BorderSide(
                                color: Theme.of(context).colorScheme.outlineVariant,
                                width: 1.0,
                              ),
                            ),
                            suffixIcon: Icon(
                              Icons.calendar_month_outlined,
                              color: Theme.of(context).colorScheme.secondaryFixed,
                            ),
                          ),
                          readOnly: true,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 13.sp, fontFamily: "IRANYekan_number"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0.r),

              // GestureDetector برای انتخاب تاریخ پایان (شمسی و میلادی)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تاریخ پایان چالش',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12.sp),
                  ),
                  SizedBox(height: 6.0.r),
                  GestureDetector(
                    onTap: () => controller.pickEndDate(context),
                    child: AbsorbPointer(
                      child: Obx(
                            () => TextField(
                          controller: TextEditingController(
                            text: controller.selectedShamsiEndDate.value.isEmpty
                                ? 'انتخاب تاریخ'
                                : controller.selectedShamsiEndDate.value,
                          ),
                          decoration: InputDecoration(
                            hintText: 'انتخاب تاریخ',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0.r),
                              borderSide:  BorderSide(
                                color: Theme.of(context).colorScheme.outlineVariant,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0.r),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.outlineVariant,
                                width: 1.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0.r),
                              borderSide:  BorderSide(
                                color: Theme.of(context).colorScheme.outlineVariant,
                                width: 1.0,
                              ),
                            ),
                            suffixIcon: Icon(
                              Icons.calendar_month_outlined,
                              color: Theme.of(context).colorScheme.secondaryFixed,
                            ),
                          ),
                          readOnly: true,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 13.sp, fontFamily: "IRANYekan_number"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.0.r),
              Obx(() => ElevatedButton(
                  onPressed: controller.isSaveButtonEnabled.value
                      ? () => controller.saveChallenge()
                      : null,
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.maxFinite, 40.0.r)),
                  child: const Text('ذخیره')
              )),
            ],
          ),
        ),
      ),
    );
  }
}
