import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final RxBool _obscureText1 = true.obs;
  final RxBool _obscureText2 = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(32.0.r),
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
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'پست الکترونیک',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 20.r),

                // Password TextField
                Obx(
                      () => TextField(
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
                  ),
                ),
                SizedBox(height: 20.r),

                // Confirm Password TextField
                Obx(
                      () => TextField(
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
                  ),
                ),
                SizedBox(height: 50.r),

                // Sign Up Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.maxFinite, 40.0.r)),
                  onPressed: () {
                    // Add sign up logic here
                  },
                  child: Text('ثبت‌نام'),
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
                        // Handle login navigation
                      },
                      child: Text(
                        'وارد شوید ',
                        style: TextStyle(
                          //decoration: TextDecoration.underline,
                          fontFamily: "IRANYekan",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.secondary,
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
    );
  }
}
