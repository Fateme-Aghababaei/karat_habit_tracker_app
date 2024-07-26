import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/utils/routes/RouteNames.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final LoginController controller = Get.put(LoginController());
  final RxBool _obscureText = true.obs;
  late bool  _submitted = false;


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
                      'ورود به کارات',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18.sp
                      )
                  ),
                  SizedBox(height: 20.r),
                  Text(
                    'برای ورود به کارات، پست الکترونیک و رمز عبور خود را وارد نمایید.',
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
                          hintText: "حداقل 6 کاراکتر",
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(top: 1.0.r, bottom: 1.0.r),
                            child: IconButton(
                              iconSize: 20.0.r,
                              color: Colors.grey,
                              icon: Icon(
                                _obscureText.value ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                _obscureText.value = !_obscureText.value;
                              },
                            ),
                          ),
                        ),
                        obscureText: _obscureText.value,
                        textInputAction: TextInputAction.next,
                        validator: controller.validatePassword
                    ),
                  ),
                  SizedBox(height: 20.r),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end, // Align to the left
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle forgotten password navigation
                        },
                        child: Text(
                          'فراموشی رمزعبور',
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
                  // Confirm Password TextField

                  SizedBox(height: 50.r),

                  // Sign Up Button
                  ElevatedButton(

                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.maxFinite, 40.0.r)),
                    onPressed: (
                        ) {
                      setState(() {
                        _submitted = true;
                      });
                      formKey.currentState!.validate();
                    },
                    child: Text('ورود'),
                  ),
                  SizedBox(height: 20.r),

                  // Already have an account TextButton
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'حساب کاربری ندارید؟ ',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: 14.sp
                          )
                      ),
                      GestureDetector(
                        onTap: () {
                         Get.offNamed(AppRouteName.signUpScreen);

                        },
                        child: Text(
                          'ثبت‌نام ',
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
