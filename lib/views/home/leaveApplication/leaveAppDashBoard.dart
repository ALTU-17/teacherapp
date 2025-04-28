import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:teacherapp/views/home/leaveApplication/addLeaveApplication.dart';
import 'package:teacherapp/views/home/leaveApplication/editLeaveApplic.dart';

import '../../../core/services/LeaveApiService.dart';
import '../../../models/Leave_App_Model.dart';
// Make sure to create this screen

class LeaveApplicationDashBoard extends StatefulWidget {
  const LeaveApplicationDashBoard({super.key});

  @override
  State<LeaveApplicationDashBoard> createState() => _LeaveApplicationDashBoardState();
}

class _LeaveApplicationDashBoardState extends State<LeaveApplicationDashBoard> {
  List<LeaveApplication> leaveApplications = [];
  bool isLoading = true;
  String errorMessage = '';
  final LeaveApiService _leaveApiService = LeaveApiService(
    // lbaseUrl: 'https://sms.arnoldcentralschool.org/SACSv4test/index.php/', // Replace with your actual base URL
  );
  @override
  void initState() {
    super.initState();
    fetchLeaveData();
  }

  Future<void> fetchLeaveData() async {
    try {
      // Replace these with your actual values from shared preferences or wherever you store them
      final baseUrl = 'YOUR_BASE_URL'; // Equivalent to newUrl in Java
      final academicYear = '2024-2025'; // Get from shared preferences
      final staffId = '123'; // Get from shared preferences (reg_id in Java)
      final shortName = 'SACS'; // Get from shared preferences (name in Java)

      final applications = await LeaveApiService.fetchLeaveApplications(
        baseUrl: baseUrl,
        academicYear: academicYear,
        staffId: staffId,
        shortName: shortName,
      );

      setState(() {
        leaveApplications = applications;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _deleteLeaveApplication(String leaveAppId) async {
    try {
      // Get shortName from your shared preferences or wherever it's stored
      final shortName = 'SACS'; // Replace with actual value

      final success = await _leaveApiService.deleteLeaveApplication(
        leaveAppId: leaveAppId,
        shortName: shortName,
      );

      if (success) {
        // Refresh the list after successful deletion
        await fetchLeaveData();
      } else {
        throw Exception('Failed to delete leave application');
      }
    } catch (e) {
      throw Exception('Delete error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: 70.h),
            Expanded(
              child: buildContent(),
            ),
          ],
        ),
      ),
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

  Widget buildContent() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }

    if (leaveApplications.isEmpty) {
      return const Center(child: Text('No leave applications found'));
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      itemCount: leaveApplications.length,
      itemBuilder: (context, index) {
        final leaveData = leaveApplications[index];
        return LeaveCard(
          leaveData: {
            'leaveDays': leaveData.noOfDays,
            'leaveAppId': leaveData.leaveAppId,
            'reason': leaveData.reason,
            'status': leaveData.status,
            'leaveType': leaveData.name, // You might want to map this to actual leave type names
            'startDate': formatDate(leaveData.leaveStartDate),
            'endDate': formatDate(leaveData.leaveEndDate),
            // Add other fields if needed
          },
          onDelete: _deleteLeaveApplication,
        );
      },
    );
  }

  String formatDate(String dateString) {
    // Implement your date formatting logic here
    // The Java code shows dates like "02-04-2025" (dd-MM-yyyy)
    // If your API returns dates in a different format, parse and reformat them here
    return dateString; // Return as-is for now, implement proper formatting
  }
}

class LeaveCard extends StatelessWidget {
  final Map<String, dynamic> leaveData;
  final Function(String) onDelete; // Add this callback

  const LeaveCard({
    super.key,
    required this.leaveData,
    required this.onDelete, // Add this parameter
  });

  @override
  Widget build(BuildContext context) {
    // Get status from data (assuming it comes as "A", "P", "H", or "R")
    final status = leaveData['status'] ?? 'A';

    // Convert status code to full name and color
    final statusInfo = _getStatusInfo(status);
    final isApproved = status == 'P';
    final isRejected = status == 'R';
    final isHold = status == 'H';
    final isApplied = status == 'A';
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    // Determine if edit/delete buttons should be visible
    final showEditDeleteButtons = isApplied || isHold;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      elevation: 3,
      color: isApproved
          ? const Color.fromARGB(255, 231, 204, 236)
          : isRejected
          ? const Color.fromARGB(255, 236, 204, 204)
          : Colors.white,
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
                      leaveData['leaveDays']?.toString() ?? '0',
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
                      statusInfo['name'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: statusInfo['color'],
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
                  leaveData['leaveType']?.toString() ?? '',
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
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  leaveData['startDate'] != null
                      ? formatter.format(DateTime.parse(leaveData['startDate'].toString()))
                      : '',
                  style: TextStyle(fontSize: 12.sp, color: Colors.black),
                ),
                SizedBox(width: 15.w),
                Text(
                  "End Date: ",
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  leaveData['endDate'] != null
                      ? formatter.format(DateTime.parse(leaveData['endDate'].toString()))
                      : '',
                  style: TextStyle(fontSize: 12.sp, color: Colors.black),
                ),
              ],
            ),

            /// Show reason if available
            // if (leaveData['reason'] != null && leaveData['reason'].toString().isNotEmpty)
            //   Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       SizedBox(height: 6.h),
            //       Text(
            //         "Reason: ",
            //         style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            //       ),
            //       Text(
            //         leaveData['reason'].toString(),
            //         style: TextStyle(fontSize: 12.sp, color: Colors.black),
            //       ),
            //     ],
            //   ),

            /// Show rejection reason if status is rejected
            if (isRejected && leaveData['reasonForRejection'] != null && leaveData['reasonForRejection'].toString().isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 6.h),
                  Text(
                    "Rejection Reason: ",
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  Text(
                    leaveData['reasonForRejection'].toString(),
                    style: TextStyle(fontSize: 12.sp, color: Colors.red),
                  ),
                ],
              ),

            /// **Edit/Delete Buttons - Only show for Applied (A) or Hold (H) status**
            if (showEditDeleteButtons)
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditLeaveApplicationPage(
                            leaveApplication: {
                              'leave_app_id': leaveData['leaveAppId'],
                              'leave_start_date': leaveData['startDate'],
                              'leave_end_date': leaveData['endDate'],
                              'no_of_days': leaveData['leaveDays'],
                              'reason': leaveData['reason'],
                              'status': leaveData['status'],
                              'name': leaveData['leaveType'],
                              'leave_type_id': leaveData['leaveTypeId'],
                              'reason_for_rejection': leaveData['reasonForRejection'],
                            },
                          ),
                        ),
                      );
                    },

                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _showDeleteConfirmationDialog(context);
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getStatusInfo(String status) {
    switch (status) {
      case "A":
        return {'name': 'Applied', 'color': Colors.blue};
      case "P":
        return {'name': 'Approved', 'color': Colors.green};
      case "H":
        return {'name': 'Hold', 'color': Colors.orange};
      case "R":
        return {'name': 'Rejected', 'color': Colors.red};
      default:
        return {'name': 'Unknown', 'color': Colors.grey};
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this leave application?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final scaffold = ScaffoldMessenger.of(context);

                scaffold.showSnackBar(
                  SnackBar(
                    content: Row(
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(width: 10),
                        Expanded(child: Text("Deleting leave application...")),
                      ],
                    ),
                    duration: const Duration(minutes: 1),
                  ),
                );

                try {
                  await onDelete(leaveData['leaveAppId']);
                  scaffold.hideCurrentSnackBar();
                  scaffold.showSnackBar(
                    const SnackBar(content: Text("Deleted successfully")),
                  );
                } catch (e) {
                  scaffold.hideCurrentSnackBar();
                  scaffold.showSnackBar(
                    SnackBar(content: Text("Delete failed: $e")),
                  );
                }
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

}
