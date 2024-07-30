import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/BottomNavigationBar.dart';
import '../components/PersianHorizontalDatePicker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

final ThemeData androidTheme = new ThemeData(
  fontFamily: 'IRANYekan_number',
);

class HabitPage extends StatefulWidget {
  const HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  Jalali? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Any initialization code goes here, if necessary
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.calendar_today_outlined,color: Theme.of(context).colorScheme.secondaryFixed,),
                onPressed: () async {
                  Jalali? picked = await showPersianDatePicker(
                    context: context,
                    initialDate: Jalali.now(),
                    firstDate: Jalali(1385, 8),
                    lastDate: Jalali(1450, 9),
                  );
                  if (picked != null && picked != _selectedDate) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
              ),
            ),
           // SizedBox(height: 4.r), // فاصله بین آیکون و تقویم افقی
            buildPersianHorizontalDatePicker(
              startDate: DateTime.now().subtract(Duration(days: 2)),
              endDate: DateTime.now().add(Duration(days: 7)),
              initialSelectedDate: DateTime.now(),
              onDateSelected: (date) {},
              context: context,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
