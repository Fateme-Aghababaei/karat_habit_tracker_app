import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  final List<FAQItem> _faqItems = [
    FAQItem(
      question: 'چگونه می‌توانم یک عادت جدید در کارات ایجاد کنم؟',
      answer: 'برای ایجاد یک عادت جدید، کافیست به بخش «عادت‌ها» بروید و روی دکمه «افزودن عادت» کلیک کنید. سپس نام عادت، توضیحات، و روزهای تکرار آن را مشخص کنید. پس از ذخیره، عادت جدید به لیست شما اضافه می‌شود و در روزهای تکرار، آن را در لیست کارهای خود مشاهده خواهید کرد.',
    ),
    FAQItem(
      question: 'چطور می‌توانم برای کارهایم تایمر تنظیم کنم؟',
      answer: 'برای تنظیم تایمر، به بخش «ردیابی» بروید. در این صفحه هم می‌توانید یک تایمر جدید را شروع کنید و یا زمان کاری که در گذشته انجام داده‌اید را ثبت کنید. در نهایت با تعیین نام کار، به لیست زمان‌های شما اضافه می‌شود.',
    ),
    FAQItem(
        question: "چگونه می‌توانم گزارش کارهای انجام شده را مشاهده کنم؟",
        answer: "برای مشاهده گزارش‌ها، به بخش «گزارش عملکرد» بروید. در این بخش می‌توانید گزارش‌های روزانه و هفتگی عملکرد خود را مشاهده کنید و بررسی کنید که تا چه حد به عادت‌های خود پایبند بوده‌اید."
    ),
    FAQItem(
        question: "چطور می‌توانم امتیاز بیشتری کسب کنم؟",
        answer: "امتیازها با پایبندی به عادت‌ها و انجام کارها به دست می‌آیند. همچنین، می‌توانید با شرکت در چالش‌ها و دعوت از دوستان خود با استفاده از کد معرف، امتیازهای بیشتری کسب کنید."
    ),
    FAQItem(
        question: "دوستانم چگونه می‌توانند با کد معرف من به برنامه اضافه شوند؟",
        answer: "کد معرف شما، در واقع همان نام کاربری شماست. دوستانتان می‌توانند هنگام ثبت‌نام در برنامه، در قسمت «کد معرف دارم»، نام کاربری شما را وارد کنند تا هر دو از امتیاز بیشتری برخوردار شوید."
    ),
    FAQItem(
        question: "آیا می‌توانم چالش‌های جدید ایجاد کنم؟",
        answer: "بله، شما می‌توانید چالش‌های جدید ایجاد کنید و دوستانتان را به آن دعوت کنید. برای ایجاد چالش، به بخش «چالش‌ها» بروید و روی «ایجاد چالش» کلیک کنید. اطلاعات مورد نیاز چالش را وارد کنید و پس از ساخت چالش، لینک آن را با دوستان خود به اشتراک بگذارید. فراموش نکنید چالش‌هایی که توسط شما ساخته می‌شود توسط دیگر کاربران قابل مشاهده نیست و حتما باید از لینک چالش، برای ثبت‌نام در آن استفاده کنند."
    ),
    FAQItem(
        question: "آیا استفاده از کارات رایگان است؟",
        answer: "بله، کارات رایگان است و می‌توانید از تمام قابلیت‌های آن به صورت رایگان استفاده کنید."
    ),
    FAQItem(
        question: "چطور می‌توانم با تیم پشتیبانی کارات تماس بگیرم؟",
        answer: "اگر سوال یا مشکلی دارید، می‌توانید از طریق ایمیل karatapp@mail.com و یا شبکه‌های اجتماعی با تیم پشتیبانی ما در تماس باشید. ما همیشه آماده پاسخگویی به سوالات و مشکلات شما هستیم."
    ),
    FAQItem(
        question: "آیا می‌توانم عادت‌ها یا کارهایی که ایجاد کرده‌ام را ویرایش کنم؟",
        answer: "بله، شما می‌توانید عادت‌ها یا کارهایی که ایجاد کرده‌اید را در هر زمانی ویرایش یا حذف کنید. کافیست روی عادت یا کار مورد نظر کلیک کرده و صفحه ویرایش برای شما باز خواهد شد."
    ),
    FAQItem(
        question: "چگونه می‌توانم از پیشرفت خود در کارات اطمینان حاصل کنم؟",
        answer: "با استفاده منظم از کارات و پایبندی به عادت‌های خود، می‌توانید به مرور زمان پیشرفت خود را مشاهده کنید. گزارش‌ها و امتیازها به شما کمک می‌کنند تا همیشه در مسیر درست باشید و انگیزه خود را حفظ کنید."
    ),
  ];

  FAQItem? _expandedItem;

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
          "سوالات متداول",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: _buildExpansionPanelList(),
        ),
      ),
    );
  }

  Widget _buildExpansionPanelList() {
    return ExpansionPanelList.radio(
      elevation: 0,
      children: _faqItems.map<ExpansionPanelRadio>((FAQItem item) {
        return ExpansionPanelRadio(
          value: item,
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                item.question,
                style: TextStyle(
                    color: isExpanded ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
                    fontWeight: isExpanded ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          },
          body: ListTile(
              title: Text(
                item.answer,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                ),
              )
          ),
        );
      }).toList(),
      dividerColor: Colors.transparent,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _expandedItem = isExpanded ? null : _faqItems[index];
        });
      },
    );
  }
}

class FAQItem {
  FAQItem({
    required this.question,
    required this.answer,
  });

  final String question;
  final String answer;
}
