import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:teacherapp/core/services/LeaveApiService.dart';

import '../../../models/Leave_App_Model.dart';
import 'leaveAppDashBoard.dart';

class AddLeaveApplicationPage extends StatefulWidget {
  const AddLeaveApplicationPage({super.key});

  @override
  State<AddLeaveApplicationPage> createState() => _AddLeaveApplicationPageState();
}

class _AddLeaveApplicationPageState extends State<AddLeaveApplicationPage> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  final LeaveApiService _leaveApiService = LeaveApiService(
    // lbaseUrl: 'https://sms.arnoldcentralschool.org/SACSv4test/index.php/', // Replace with your actual base URL
  );

  String? selectedLeaveType;
  String? leaveTypeId;
  List<Map<String, dynamic>> leaveTypes = [];
  List<LeaveBalance> leaveBalances = [];
  bool isLoading = false;
  String? remainingLeaves;

  String? selectedSubject;
  final List<String> subjects = ["Casual Leave ", "Sick Leave ", ];

  @override
  void initState() {
    super.initState();
    _fetchLeaveBalances();
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _daysController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _fetchLeaveBalances() async {
    setState(() => isLoading = true);
    try {
      // Replace with your actual values from shared preferences
      final academicYear = '2024-2025';
      final regId = '123';
      final shortName = 'SACS';

      leaveBalances = await _leaveApiService.getBalanceLeave(
        academicYear: academicYear,
        regId: regId,
        shortName: shortName,
      );

      // If we get empty list, show message
      if (leaveBalances.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No leave types allocated yet by admin')),
        );
      }
    } on Exception catch (e) {
      print('Error fetching leave balances: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString().replaceAll('Exception: ', '')}')),
      );
      // Set empty list to prevent null errors
      leaveBalances = [];
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _submitLeaveApplication() async {
    if (!_validateForm()) return;

    setState(() => isLoading = true);
    try {
      // Replace with your actual values from shared preferences
      final academicYear = '2024-2025';
      final regId = '123';
      final shortName = 'SACS';

      final success = await _leaveApiService.createLeaveApplication(
        leaveTypeId: leaveTypeId!,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
        noOfDays: _daysController.text,
        staffId: regId,
        academicYear: academicYear,
        reason: _reasonController.text,
        shortName: shortName,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Leave Applied Successfully')),
        );
        // Navigator.of(context).pop(true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LeaveApplicationDashBoard()),
        );

      } else {
        throw Exception('Failed to apply leave');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }


  Future<void> _selectDate(bool isStartDate) async {
    final initialDate = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      final formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      if (isStartDate) {
        _startDateController.text = formattedDate;
        // Clear end date if it's before start date
        if (_endDateController.text.isNotEmpty) {
          final endDate = DateFormat('dd-MM-yyyy').parse(_endDateController.text);
          if (picked.isAfter(endDate)) {
            _endDateController.clear();
            _daysController.clear();
          }
        }
      } else {
        if (_startDateController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select start date first')),
          );
          return;
        }

        final startDate = DateFormat('dd-MM-yyyy').parse(_startDateController.text);
        if (picked.isBefore(startDate)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('End date cannot be before start date')),
          );
          return;
        }

        _endDateController.text = formattedDate;
        _calculateDays(startDate, picked);
      }
    }
  }

  void _calculateDays(DateTime start, DateTime end) {
    final diff = end.difference(start).inDays + 1;
    _daysController.text = diff.toString();

    // Validate against remaining leaves
    if (remainingLeaves != null) {
      final remaining = double.parse(remainingLeaves!);
      if (diff > remaining) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You only have $remainingLeaves days remaining')),
        );
      }
    }
  }

  void _resetForm() {
    setState(() {
      selectedLeaveType = null;
      leaveTypeId = null;
      remainingLeaves = null;
      _startDateController.clear();
      _endDateController.clear();
      _daysController.clear();
      _reasonController.clear();
    });
  }



  bool _validateForm() {
    if (selectedLeaveType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select leave type')),
      );
      return false;
    }
    if (_startDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select start date')),
      );
      return false;
    }
    if (_endDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select end date')),
      );
      return false;
    }
    if (_daysController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter leave days')),
      );
      return false;
    }
    if (_reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter reason')),
      );
      return false;
    }

    // Validate leave days against remaining leaves
    if (remainingLeaves != null) {
      final days = double.parse(_daysController.text);
      final remaining = double.parse(remainingLeaves!);
      if (days > remaining) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You only have $remainingLeaves days remaining')),
        );
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Create Leave Application (2024-2025)",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 208, 28, 127),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink, Colors.blue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isLoading && leaveTypes.isEmpty)
                        const Center(child: CircularProgressIndicator())
                      else ...[
                        /// Leave Type Dropdown
                        const Text("*Leave Type",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: DropdownButtonFormField<String>(
                            value: selectedLeaveType,
                            hint: const Text("Select Leave Type"),
                            items: leaveBalances.map<DropdownMenuItem<String>>((type) {
                              return DropdownMenuItem<String>(
                                value: type.name, // Use the name as the value
                                child: Text(
                                  "${type.name} (${type.remainingLeaves} days remaining)",
                                style: TextStyle(fontSize: 14),),
                                onTap: () {
                                  setState(() {
                                    leaveTypeId = type.leaveTypeId;
                                    remainingLeaves = type.remainingLeaves;
                                  });
                                },
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                selectedLeaveType = value;
                              });
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              border: InputBorder.none,
                            ),
                            validator: (value) => value == null ? 'Required' : null,
                          ),
                        ),
                        SizedBox(height: 10.h),

                        /// Start Date Picker
                        const Text("*Select Start Date",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextFormField(
                          controller: _startDateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Select Date",
                            prefixIcon: const Icon(Icons.calendar_today),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          onTap: () => _selectDate(true),
                        ),
                        SizedBox(height: 10.h),

                        /// End Date Picker
                        const Text("*Select End Date",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextFormField(
                          controller: _endDateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: "Select End Date",
                            prefixIcon: const Icon(Icons.calendar_today),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          onTap: () => _selectDate(false),
                        ),
                        SizedBox(height: 10.h),

                        /// Days
                        const Text("*Days",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextField(
                          controller: _daysController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "No. of Days",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),

                        /// Reason
                        const Text("*Reason",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextField(
                          controller: _reasonController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: "Reason for Leave",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        /// Save & Reset Buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 78, 157, 222),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.r),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
                                ),
                                onPressed: isLoading ? null : _submitLeaveApplication,
                                icon: Icon(Icons.save, size: 16.sp, color: Colors.white),
                                label: isLoading
                                    ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(color: Colors.white),
                                )
                                    : const Text("Save",
                                    style: TextStyle(color: Colors.white, fontSize: 14)),
                              ),
                            ),
                            SizedBox(width: 20.w),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade400,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.r),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
                                ),
                                onPressed: _resetForm,
                                icon: Icon(Icons.refresh, size: 16.sp, color: Colors.black),
                                label: const Text("Reset",
                                    style: TextStyle(color: Colors.black, fontSize: 14)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isLoading && leaveTypes.isNotEmpty)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}