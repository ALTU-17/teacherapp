import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../core/services/LeaveApiService.dart';
import '../../../models/Leave_App_Model.dart';
import 'leaveAppDashBoard.dart';

class EditLeaveApplicationPage extends StatefulWidget {
  final Map<String, dynamic> leaveApplication;

  const EditLeaveApplicationPage({
    super.key,
    required this.leaveApplication,
  });

  @override
  State<EditLeaveApplicationPage> createState() => _EditLeaveApplicationPageState();
}

class _EditLeaveApplicationPageState extends State<EditLeaveApplicationPage> {
  final LeaveApiService _leaveApiService = LeaveApiService(
    // baseUrl: 'YOUR_BASE_URL', // Replace with your actual base URL
  );

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _approverCommentController = TextEditingController();

  String? selectedLeaveType;
  String? leaveTypeId;
  List<LeaveBalance> leaveBalances = [];
  bool isLoading = false;
  String? remainingLeaves;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeForm();
    _fetchLeaveBalances();
  }

  void _initializeForm() {
    // Initialize form with existing leave application data
    _startDateController.text = _formatDate(widget.leaveApplication['leave_start_date']);
    _endDateController.text = _formatDate(widget.leaveApplication['leave_end_date']);
    _daysController.text = widget.leaveApplication['no_of_days']?.toString() ?? '';
    _reasonController.text = widget.leaveApplication['reason'] ?? '';
    _approverCommentController.text = widget.leaveApplication['reason_for_rejection'] ?? '';

    // Set status text based on status code
    final status = widget.leaveApplication['status'] ?? 'A';
    _statusController.text = _getStatusText(status);

    // Set initial leave type
    selectedLeaveType = widget.leaveApplication['name'] ?? '';
    leaveTypeId = widget.leaveApplication['leave_type_id']?.toString();
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '';

    try {
      final inputFormat = DateFormat('yyyy-MM-dd');
      final outputFormat = DateFormat('dd-MM-yyyy');
      final date = inputFormat.parse(dateString);
      return outputFormat.format(date);
    } catch (e) {
      return dateString; // Return as-is if parsing fails
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'A': return 'Applied';
      case 'P': return 'Approved';
      case 'H': return 'Hold';
      case 'R': return 'Rejected';
      default: return status;
    }
  }

  Future<void> _fetchLeaveBalances() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

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

      // Find and set the remaining leaves for the current leave type
      if (leaveTypeId != null) {
        final currentLeave = leaveBalances.firstWhere(
              (item) => item.leaveTypeId == leaveTypeId,
          orElse: () => LeaveBalance(
            leaveTypeId: '',
            name: '',
            leavesAllocated: '0',
            leavesAvailed: '0',
            remainingLeaves: '0',
          ),
        );
        remainingLeaves = currentLeave.remainingLeaves;
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching leave types: $e';
      });
      print('Error fetching leave balances: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _selectDate(bool isStartDate) async {
    final initialDate = isStartDate && _startDateController.text.isNotEmpty
        ? DateFormat('dd-MM-yyyy').parse(_startDateController.text)
        : DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      final formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      if (isStartDate) {
        setState(() => _startDateController.text = formattedDate);
        // Clear end date if it's before the new start date
        if (_endDateController.text.isNotEmpty) {
          final endDate = DateFormat('dd-MM-yyyy').parse(_endDateController.text);
          if (picked.isAfter(endDate)) {
            setState(() {
              _endDateController.clear();
              _daysController.clear();
            });
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

        setState(() {
          _endDateController.text = formattedDate;
          _calculateDays(startDate, picked);
        });
      }
    }
  }

  void _calculateDays(DateTime start, DateTime end) {
    final diff = end.difference(start).inDays + 1;
    setState(() => _daysController.text = diff.toString());

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
      _startDateController.text = _formatDate(widget.leaveApplication['leave_start_date']);
      _endDateController.text = _formatDate(widget.leaveApplication['leave_end_date']);
      _daysController.text = widget.leaveApplication['no_of_days']?.toString() ?? '';
      _reasonController.text = widget.leaveApplication['reason'] ?? '';
      selectedLeaveType = widget.leaveApplication['name'] ?? '';
      leaveTypeId = widget.leaveApplication['leave_type_id']?.toString();
    });
  }

  Future<void> _submitLeaveApplication() async {
    if (!_validateForm()) return;

    setState(() => isLoading = true);

    try {
      // Replace with your actual values from shared preferences
      final academicYear = '2024-2025';
      final shortName = 'SACS';

      final success = await _leaveApiService.updateLeaveApplication(
        leaveAppId: widget.leaveApplication['leave_app_id']?.toString() ?? '',
        leaveTypeId: leaveTypeId!,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
        noOfDays: _daysController.text,
        reason: _reasonController.text,
        shortName: shortName,
        acd_yr: academicYear,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Leave application updated successfully')),
        );
        // Navigator.of(context).pop(true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LeaveApplicationDashBoard()),
        );
      } else {
        throw Exception('Failed to update leave application');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  bool _validateForm() {
    if (selectedLeaveType == null || leaveTypeId == null) {
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
      final days = double.tryParse(_daysController.text) ?? 0;
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
        // toolbarHeight: 70.h,
        title: const Text(
          "Edit Leave Application(2024-2025)",
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
                padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                      SizedBox(height: 70.h),
                      if (errorMessage != null)
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Text(
                            errorMessage!,
                            style: TextStyle(color: Colors.red, fontSize: 14.sp),
                          ),
                        ),

                      if (isLoading && leaveBalances.isEmpty)
                        const Center(child: CircularProgressIndicator())
                      else ...[

                        SizedBox(height: 20.h),
                        ///
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
                                value: type.name,
                                child: Text(
                                  "${type.name} (${type.remainingLeaves} days remaining)",
                                  style: TextStyle(fontSize: 13.5), ),
                                onTap: () {
                                  setState(() {
                                    leaveTypeId = type.leaveTypeId;
                                    remainingLeaves = type.remainingLeaves;
                                  });
                                },
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() => selectedLeaveType = value);
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              border: InputBorder.none,
                            ),
                            validator: (value) => value == null ? 'Required' : null,
                          ),
                        ),
                        SizedBox(height: 10.h),

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
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "No.of Days",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),

                        const Text("*Status",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextField(
                          controller: _statusController,
                          readOnly: true,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: "Status",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),


                        const Text("*Reason",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextField(
                          controller: _reasonController,
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: "Reason of Leave",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),


                        const Text("Approver's Comments",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextField(
                          controller: _approverCommentController,
                          readOnly: true,
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: "Approver's Comments",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 78, 157, 222),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.r),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.h, horizontal: 8.w),
                                ),
                                onPressed: isLoading ? null : _submitLeaveApplication,
                                icon: Icon(Icons.save,
                                    size: 16.sp, color: Colors.white),
                                label: isLoading
                                    ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(color: Colors.white),
                                )
                                    : const Text(
                                  "Update",
                                  style: TextStyle(color: Colors.white, fontSize: 14),
                                ),
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
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.h, horizontal: 8.w),
                                ),
                                onPressed: _resetForm,
                                icon: Icon(Icons.refresh,
                                    size: 16.sp, color: Colors.black),
                                label: const Text("Reset",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isLoading && leaveBalances.isNotEmpty)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}