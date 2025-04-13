import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeTablePage extends StatefulWidget {
  const TimeTablePage({super.key});

  @override
  _TimeTablePageState createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  final List<String> days = ["MON", "TUE", "WED", "THU", "FRI", "SAT"];
  int selectedIndex = 0;
  late PageController _pageController;

  /// *Dummy Timetable Data*
  final Map<String, List<Period>> timetable = {
    "MON": [
      Period(period: "1", subject: "English", className: "5 D"),
      Period(period: "2", subject: "Hindi", className: "5 D"),
      Period(period: "3", subject: "SST", className: "4 D"),
      Period(period: "4", subject: "--", className: "--"),
      Period(period: "5", subject: "English", className: "5 C"),
      Period(period: "6", subject: "SST", className: "--"),
      Period(period: "7", subject: "English", className: "--"),
    ],
    "TUE": [
      Period(period: "1", subject: "Mathematics", className: "5 D"),
      Period(period: "2", subject: "Science", className: "5 D"),
    ],
    "WED": [
      Period(period: "1", subject: "English", className: "5 C"),
      Period(period: "2", subject: "History", className: "4 D"),
    ],
    "THU": [
      Period(period: "1", subject: "Physics", className: "5 B"),
      Period(period: "2", subject: "Chemistry", className: "5 C"),
    ],
    "FRI": [
      Period(period: "1", subject: "Computer", className: "5 A"),
      Period(period: "2", subject: "Music", className: "5 D"),
    ],
    "SAT": [
      Period(period: "1", subject: "Art", className: "5 C"),
    ],
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    DateTime now = DateTime.now();
    selectedIndex = now.weekday - 1;
    if (selectedIndex > 5) selectedIndex = 0;
    _pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 60.h,
        title: Text(
           "Time Table(2024-2025)",
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
     
        child: Column(
          children: [
            SizedBox(height: 120.h),
          //  _buildTitleBar(),
            //SizedBox(height: 5),
            _buildDaySelector(),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final day = days[index];
                  final periods = timetable[day] ?? [];

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildTableHeader(),
                        Column(
                          children: periods.map((period) => _buildPeriodRow(period)).toList(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// *Day Selector (Mon - Sat)*
  Widget _buildDaySelector() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(days.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                _pageController.jumpToPage(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(vertical:5.h, horizontal: 11.w),
                decoration: BoxDecoration(
                  color: selectedIndex == index ? const Color.fromARGB(255, 244, 107, 10) : Color(0xFFE4DADA),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  days[index],
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: selectedIndex == index ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  /// *Table Header*
  Widget _buildTableHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 206, 225, 224),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _tableHeaderCell("Period"),
              _tableHeaderCell("Subject"),
              _tableHeaderCell("Class"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tableHeaderCell(String title) {
    return Expanded(
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }

  /// *Table Row (Period Entry)*
  Widget _buildPeriodRow(Period period) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _tableCell(period.period),
              _tableCell(period.subject),
              _tableCell(period.className),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tableCell(String text) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}

/// *Period Model*
class Period {
  final String period;
  final String subject;
  final String className;

  Period({required this.period, required this.subject, required this.className});
}