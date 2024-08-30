import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => Get.back(),
          ),
        ],
        title: Text(
          "درباره ما",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 15.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "درباره کارات",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 5.r),
            Text(
              "کارات یک برنامه جامع برای پیگیری عادت‌ها و کارهاست که به شما کمک می‌کند با ایجاد عادت‌های مثبت، بهره‌وری خود را افزایش دهید و به اهداف شخصی‌تان نزدیک‌تر شوید.",
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 20.r),
            Text(
              "مأموریت ما",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 5.r),
            Text(
              "هدف ما در کارات این است که به شما ابزاری کارآمد ارائه دهیم تا بتوانید زندگی خود را بهبود بخشید. ما معتقدیم که با تمرکز بر روی عادت‌های کوچک و تکرار روزانه آنها، می‌توانید تغییرات بزرگ و ماندگاری در زندگی‌تان ایجاد کنید.",
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 20.r),
            Text(
              "ویژگی‌های کارات",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            buildFeature(context, "ایجاد عادت‌ها و کارهای جدید", "در کارات شما می‌توانید به سادگی عادت‌ها و کارهای جدیدی ایجاد کنید و روزهای تکرار آنها را تعریف کنید. این امکان به شما کمک می‌کند تا برنامه‌ریزی دقیقی برای رسیدن به اهداف‌تان داشته باشید."),
            buildFeature(context, "امتیازدهی به پایبندی", "با هر بار پایبند ماندن به عادت‌هایتان، امتیاز دریافت می‌کنید. این امتیازها به شما انگیزه می‌دهند تا به مسیر خود ادامه دهید و پیشرفت خود را با هر قدم ببینید."),
            buildFeature(context, "گزارش‌گیری از عملکرد", "شما می‌توانید در هر زمانی که خواستید، گزارش‌های دقیقی از عملکرد خود و میزان پایبندی به عادت‌هایتان را مشاهده کنید. این گزارش‌ها به شما کمک می‌کنند تا روند پیشرفت خود را بهتر درک کنید و در صورت نیاز تغییرات لازم را در برنامه‌تان اعمال کنید."),
            buildFeature(context, "ردیابی زمان", "اگر نیاز دارید تا برای کارهای خود تایمری داشته باشید و زمان دقیق انجام آنها را ثبت کنید، کارات این امکان را برای شما فراهم کرده است. با این قابلیت می‌توانید بهره‌وری خود را به طور دقیق‌تر اندازه‌گیری کنید."),
            buildFeature(context, "چالش‌ها و رقابت‌", "در کارات شما می‌توانید در چالش‌های مختلف شرکت کنید یا چالش‌های جدیدی ایجاد کرده و دوستان خود را به آن دعوت کنید. این قابلیت به شما انگیزه می‌دهد تا با دیگران رقابت کنید و در عین حال از یکدیگر بیاموزید."),
            buildFeature(context, "امتیاز بیشتر با معرفی دوستان", "با معرفی کارات به دوستان خود و استفاده از کد معرف، می‌توانید امتیازهای بیشتری دریافت کنید. این امتیازها به شما کمک می‌کنند تا در چالش‌های بیشتری شرکت کنید و سریع‌تر به اهداف خود برسید. هرچه تعداد دوستان بیشتری به کارات بپیوندند، شما امتیازات بیشتری کسب خواهید کرد و به علاوه، به آنها نیز فرصت می‌دهید تا عملکرد خود را بهبود ببخشند."),
            SizedBox(height: 20.h),

            Text(
              "با کارات، هر روز یک قدم به سمت بهتر شدن خودتان بردارید. ما اینجا هستیم تا به شما کمک کنیم تا از زمان خود بهترین استفاده را ببرید و به اهداف‌تان برسید.",
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 20.r),
          ],
        ),
      ),
    );
  }

  Widget buildFeature(BuildContext context, String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.check,color: Theme.of(context).colorScheme.secondary),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.r),
          Text(
            description,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
