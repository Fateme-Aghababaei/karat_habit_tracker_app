import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:karat_habit_tracker_app/view/setting_screen/setting_controller.dart';
import '../../model/constant.dart';
import '../../utils/theme/controller.dart';
import '../../utils/theme/theme.dart';
import '../error_screen.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // کنترلرهای GetX
  final SettingsController settingsController = Get.put(SettingsController());
  final ThemeController themeController = Get.put(ThemeController());
  late TextEditingController nameController;
  late TextEditingController usernameController;
  final box = GetStorage();
  final formKey = GlobalKey<FormState>();
  late final RxBool notifEnabled;
  RxBool isEdited = false.obs;  // بولی برای ردیابی تغییرات


  @override
  void initState() {
    super.initState();
    String? myUsername = box.read('username');
    usernameController = TextEditingController(text: myUsername);
    print(settingsController.userViewModel.userProfile.value.notif_enabled);
    notifEnabled = (settingsController.userViewModel.userProfile.value.notif_enabled ?? true).obs;

    usernameController.addListener(() {
      if (usernameController.text != myUsername) {
        isEdited.value = true;
      }
     });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  return TextButton(
                    style: ButtonStyle(
                      overlayColor: WidgetStateProperty.all(Colors.transparent), // تنظیم هاور به صورت شفاف
                    ),
                    onPressed: isEdited.value
                        ? () {
                      if (formKey.currentState!.validate()) {
                        settingsController.userViewModel.editProfile(
                          firstName: nameController.text,
                          username: usernameController.text,
                          notifEnabled: notifEnabled.value,
                        );
                        isEdited.value = false;
                      }
                    }
                        : null,
                    child: Text(
                      'ذخیره',
                      style: TextStyle(
                        fontFamily: "IRANYekan",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: isEdited.value
                            ? Theme.of(context).colorScheme.secondaryFixed
                            : Theme.of(context).disabledColor,
                      ),
                    ),
                  );
                }),
                Text(
                  'تنظیمات  ',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15.sp),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () => Get.back(result: true),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (settingsController.userViewModel.isLoadingUserProfile.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (settingsController.userViewModel.userProfile.value.id == null) {
          return const Error();
        } else {
          nameController = TextEditingController(text: settingsController.userViewModel.userProfile.value.firstName);
          nameController.addListener(() {
            if (nameController.text != settingsController.userViewModel.userProfile.value.firstName) {
              isEdited.value = true;
            }
          });
          return _buildSettingContent(context);
        }
      }),
    );
  }

  Widget _buildSettingContent(
      BuildContext context) {
     return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0.r),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Obx(() {
                      return CircleAvatar(
                        radius: 46.0.r,
                        backgroundImage: settingsController.userViewModel.userProfile.value.photo != null
                            ? NetworkImage('$baseUrl${settingsController.userViewModel.userProfile.value.photo!}')
                            : const AssetImage('assets/images/profile.png') as ImageProvider,
                        backgroundColor: settingsController.userViewModel.userProfile.value.photo != null
                            ? Colors.transparent
                            : const Color(0xffFFB2A7),
                      );
                    }),
                    SizedBox(height: 4.0.r),
                    TextButton(
                      onPressed: () {
                        settingsController.showImagePicker(context);
                      },
                      child: Text(
                        'ویرایش تصویر',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0.r),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'نام',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(height: 6.0.r), // فاصله بین عنوان و TextField
                    TextFormField(
                      controller: nameController,
                      validator: settingsController.validateName,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Color(0XFFCAC5CD),
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Color(0XFFCAC5CD),
                            width: 1.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Colors.redAccent,
                          ),),
                        filled: true,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 15.sp,
                        decoration: TextDecoration.none,
                        decorationThickness: 0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0.r),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'نام کاربری',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(height: 6.0.r),
                    TextFormField(
                      controller: usernameController,
                      validator: settingsController.validateUsername,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Color(0XFFCAC5CD),
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Color(0XFFCAC5CD),
                            width: 1.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Colors.redAccent,
                          ),),
                        filled: true,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 15.sp,
                        decoration: TextDecoration.none,
                        decorationThickness: 0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 26.0.r),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text(
                    'سایر تنظیمات',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 14.sp,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),

              Obx(() => ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                title: Text(
                  'حالت تاریک',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14.sp),
                ),
                trailing: Transform.scale(
                  scale: 0.75,  // تغییر اندازه سوئیچ
                  child: Switch(
                    value: themeController.currentTheme.value == AppTheme.darkTheme,
                    onChanged: (bool value) {
                      themeController.changeTheme(value);
                    },
                  ),
                ),
                onTap: () {
                  //themeController.changeTheme(!themeController.currentTheme.value);
                },
              )),
              Divider(color: Colors.grey, thickness: 0.5),
              Obx(() => ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                title: Text(
                  'صدا',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14.sp),
                ),
                trailing: Transform.scale(
                  scale: 0.75,  // تغییر اندازه سوئیچ
                  child: Switch(
                    value: settingsController.isSoundOn.value,
                    onChanged: (bool value) {
                      settingsController.toggleSound(value);
                    },
                  ),
                ),
              )),
              Divider(color: Colors.grey, thickness: 0.5),
              Obx(() => ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                title: Text(
                  'اعلان ها',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14.sp),
                ),
                trailing: Transform.scale(
                  scale: 0.75,  // تغییر اندازه سوئیچ
                  child: Switch(
                    value: settingsController.isNotifEnabled.value,
                    onChanged: (bool value) {
                     // isEdited.value = true;
                      notifEnabled.value = value;
                      settingsController.toggleNotifEnabled(value);

                    },
                  ),
                ),

              )),


              SizedBox(height: 30.0.r),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await settingsController.userViewModel.logout();},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.exit_to_app_rounded, // آیکون خروج از حساب
                        color: Colors.redAccent,
                      ),
                      SizedBox(width: 8.0.r), // فاصله بین آیکون و متن
                      Text(
                        'خروج از حساب کاربری',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.redAccent,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
