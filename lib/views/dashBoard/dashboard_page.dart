
import 'package:flutter/material.dart';
import 'package:teacherapp/common/styles.dart';
import 'package:teacherapp/views/home/dailyAttendance/dailyAttendDashBoard.dart';
import 'package:teacherapp/views/home/homework/homeworkDashBoard.dart';
import 'package:teacherapp/views/home/leaveApplication/leaveAppDashBoard.dart';
import 'package:teacherapp/views/home/remark/remarkDashBoard.dart';
import 'package:teacherapp/views/home/techerNote/techerNoteDashBoard.dart';
import 'package:teacherapp/views/home/timeTable/timeTableTecaher.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  /// **Activity List with Navigation**
  static final List<Map<String, dynamic>> _activities = [
    {'icon': 'assets/teacherNote.png', 'label': 'Teacher Note', 'page': const TeacherNoteDashBoard()},
   
    {'icon': 'assets/homeWork.png', 'label': 'HomeWork', 'page': const HomeWorkDashBoard()},
    {'icon': 'assets/remarkPng.png', 'label': 'Remark', 'page': const RemarkDashBoard()},
    {'icon': 'assets/timeTable.png', 'label': 'Time Table', 'page':  TimeTablePage()},
    {'icon': 'assets/calendar.png', 'label': 'Daily Attendance', 'page':  DailyAttendDashboard()},
    {'icon': 'assets/leaveApp.png', 'label': 'Leave Application', 'page':  LeaveApplicationDashBoard()},
   // {'icon': 'assets/chat.png', 'label': 'Smart Chat', 'page': const SmartChatScreen(), 'isNew': true},
   // {'icon': 'assets/curriculum.png', 'label': 'Curriculum', 'page': const CurriculumScreen()},
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        /// **Background Image**
        Image.asset(
          'assets/img.png',
          fit: BoxFit.cover,
        ),

        /// **Main Content**
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// **Teacher Profile Card**
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/boy.png',
                        width: 50,
                        height: 60,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'KAVITA RAVIKUMAR DESHPANDE',
                               style: AppStyles.boldb15
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Class Teacher of: 5 D',
                              style: AppStyles.font14b14
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: const [
                                Text(
                                  'Punch In: ',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '07:43',
                                  style: TextStyle(color: Colors.green),
                                ),
                                SizedBox(width: 25),
                                Text(
                                  'Last Punch: ',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '12:05',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                /// **Section Title**
                Center(
                  child: const Text(
                    'My Activity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                /// **Grid View for Activities**
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _activities.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => _activities[index]['page']),
                        );
                      },
                      child: _buildActivityCard(
                        _activities[index]['icon'],
                        _activities[index]['label'],
                        _activities[index].containsKey('isNew') ? _activities[index]['isNew'] : false,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// **Build Activity Card**
  Widget _buildActivityCard(String icon, String label, bool isNew) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Image.asset(icon, width: 40, height: 40), // Activity Icon
              if (isNew)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'New',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
