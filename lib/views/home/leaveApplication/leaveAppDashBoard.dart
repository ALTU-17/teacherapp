import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacherapp/views/home/leaveApplication/addLeaveApplication.dart';
import 'package:teacherapp/views/home/leaveApplication/editLeaveApplic.dart';
// Make sure to create this screen

class LeaveApplicationDashBoard extends StatelessWidget {
  const LeaveApplicationDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> leaveApplications = [
      {
        'leaveDays': '1.0',
        'status': 'Applied',
        'leaveType': 'Casual Leave',
        'startDate': '02-04-2025',
        'endDate': '01-04-2025',
      },
      {
        'leaveDays': '2.0',
        'status': 'Applied',
        'leaveType': 'Casual Leave',
        'startDate': '02-03-2025',
        'endDate': '03-03-2025',
      },
      {
        'leaveDays': '0.5',
        'status': 'Approved',
        'leaveType': 'Casual Leave',
        'startDate': '10-01-2025',
        'endDate': '10-01-2025',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 50.h,
        title: Text(
          "Leave Application (2024-2025)",
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
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
            SizedBox(height: 110.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                itemCount: leaveApplications.length,
                itemBuilder: (context, index) {
                  final leaveData = leaveApplications[index];
                  return LeaveCard(leaveData: leaveData);
                },
              ),
            ),
          ],
        ),
      ),

      /// ✅ Floating Action Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddLeaveApplicationPage()),
          );
        },
        child: const Icon(Icons.add, color: Colors.black, size: 30),
      ),
    );
  }
}

class LeaveCard extends StatelessWidget {
  final Map<String, String> leaveData;
  const LeaveCard({super.key, required this.leaveData});

  @override
  Widget build(BuildContext context) {
    bool isApproved = leaveData['status'] == 'Approved';

    return Card(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      elevation: 3,
      color:
          isApproved ? const Color.fromARGB(255, 231, 204, 236) : Colors.white,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Leave Days: ",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      leaveData['leaveDays']!,
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Status: ",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      leaveData['status']!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isApproved ? Colors.green : Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 6.h),

            /// **Leave Type**
            Row(
              children: [
                Text(
                  "Leave Type: ",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  leaveData['leaveType']!,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 6.h),

            /// **Start Date & End Date**
            Row(
              children: [
                Text(
                  "Start Date: ",
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  leaveData['startDate']!,
                  style: TextStyle(fontSize: 12.sp, color: Colors.black),
                ),
                SizedBox(width: 15.w),
                Text(
                  "End Date: ",
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  leaveData['endDate']!,
                  style: TextStyle(fontSize: 12.sp, color: Colors.black),
                ),
              ],
            ),

            /// **Edit/Delete Buttons if not approved**
            if (!isApproved)
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditLeaveApplicationPage(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Delete action triggered")),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
