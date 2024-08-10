import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/utils/routes/RouteNames.dart';
import 'package:karat_habit_tracker_app/view/signup_screen/signup_controller.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final SignUpController controller = Get.put(SignUpController());
  final RxBool _obscureText1 = true.obs;
  final RxBool _obscureText2 = true.obs;
  late bool  _submitted = false;

  void showReferralCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0.r),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(milliseconds: 300),
            child: AnimatedScale(
              scale: 1.0,
              duration: Duration(milliseconds: 300),
              child: Container(
                padding: EdgeInsets.all(20.0.r),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(12.0.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'کد معرف خود را وارد کنید',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.r),
                    TextField(
                      controller: controller.referralCodeController,
                      decoration: InputDecoration(
                        labelText: 'کد معرف',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0.r),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 8.r),
                      ),
                    ),
                    SizedBox(height: 20.r),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {Get.back();},
                          child: const Text('تایید'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void dispose() {
    // پاک کردن مقادیر کنترلرها
    controller.emailController.clear();
    controller.passwordController.clear();
    controller.confirmPasswordController.clear();
    controller.referralCodeController.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(32.0.r),
            child: Form(
              key: formKey,
              autovalidateMode: _submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'assets/logo/carrot.png',
                    height: 0.2.sh,
                    width: 0.4.sw,
                  ),
                  SizedBox(height: 20.r),

                  // Description Text
                  Text(
                      'ثبت نام در کارات',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 18.sp
                      )
                  ),
                  SizedBox(height: 20.r),
                  Text(
                    'برای ثبت‌نام در کارات، پست الکترونیک و رمز عبور خود را وارد نمایید.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp
                    ),
                  ),
                  SizedBox(height: 20.r),

                  // Email TextField
                   TextFormField(
                     controller:  controller.emailController,
                    decoration: const InputDecoration(
                      labelText: 'پست الکترونیک',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                     validator: controller.validateEmail
                  ),
                  SizedBox(height: 20.r),

                  // Password TextField
                  Obx(
                        () => TextFormField(
                          controller: controller.passwordController,
                      decoration: InputDecoration(
                        labelText: 'رمز عبور',
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(top: 1.0.r, bottom: 1.0.r),
                          child: IconButton(
                            iconSize: 20.0.r,
                            color: Colors.grey,
                            icon: Icon(
                              _obscureText1.value ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              _obscureText1.value = !_obscureText1.value;
                            },
                          ),
                        ),
                      ),
                      obscureText: _obscureText1.value,
                      textInputAction: TextInputAction.next,
                            validator: controller.validatePassword
                    ),
                  ),
                  SizedBox(height: 20.r),

                  // Confirm Password TextField
                  Obx(
                        () => TextFormField(
                          controller: controller.confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'تکرار رمز',
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(top: 1.0.r, bottom: 1.0.r),
                          child: IconButton(
                            iconSize: 20.0.r,
                            color: Colors.grey,
                            icon: Icon(
                              _obscureText2.value ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              _obscureText2.value = !_obscureText2.value;
                            },
                          ),
                        ),
                      ),
                      obscureText: _obscureText2.value,
                      textInputAction: TextInputAction.done,
                          validator: controller.validateConfirmPassword,
                    ),
                  ),
                SizedBox(height: 20.r),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end, // Align to the left
                    children: [
                      GestureDetector(
                        onTap: () {
                          showReferralCodeDialog(context);

                        },
                        child: Text(
                          'کد معرف دارم',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Theme.of(context).colorScheme.secondaryFixed,
                            fontFamily: "IRANYekan",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.secondaryFixed,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30.r),

                  // Sign Up Button
                  ElevatedButton(

                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.maxFinite, 40.0.r)),
                    onPressed: () {
                      setState(() {
                        _submitted = true;
                      });
                      if (formKey.currentState!.validate()) {
                        controller.registerUser();
                      }
                    },
                      child: Obx(() {
                        return controller.isLoading.value
                            ? SizedBox(
                          height: 20.0.r,
                          width: 20.0.r,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.0,
                          ),
                        )
                            : const Text('ثبت‌نام');
                      }),
                  ),
                  SizedBox(height: 20.r),

                  // Already have an account TextButton
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'قبلا ثبت‌نام کرده‌اید؟ ',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 14.sp
                          )
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offNamed(AppRouteName.loginScreen);
                        },
                        child: Text(
                          'وارد شوید ',
                          style: TextStyle(
                            //decoration: TextDecoration.underline,
                            fontFamily: "IRANYekan",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.secondaryFixed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
