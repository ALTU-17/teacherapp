import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditLeaveApplicationPage extends StatefulWidget {
  const EditLeaveApplicationPage({super.key});

  @override
  State<EditLeaveApplicationPage> createState() =>
      _EditLeaveApplicationPage();
}

class _EditLeaveApplicationPage extends State<EditLeaveApplicationPage> {
  // Text controllers for each field
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _approverCommentController =
      TextEditingController();

  String? selectedLeaveType;
  final List<String> leaveTypes = [
    "Casual Leave",
    "Sick Leave",
  ];

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _daysController.dispose();
    _statusController.dispose();
    _reasonController.dispose();
    _approverCommentController.dispose();
    super.dispose();
  }

  void _selectDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  void _resetForm() {
    setState(() {
      selectedLeaveType = null;
      _startDateController.clear();
      _endDateController.clear();
      _daysController.clear();
      _statusController.clear();
      _reasonController.clear();
      _approverCommentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
         toolbarHeight: 70.h,
        title: const Text(
          "Edit Leave Application(2024-2025)",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 208, 28, 127),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
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
                  SizedBox(height:70.h),
                  const Text("*Leave Type",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  DropdownButtonFormField<String>(
                    value: selectedLeaveType,
                    decoration: InputDecoration(
                      hintText: "Select Leave Type",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 14.h),
                    ),
                    items: leaveTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => selectedLeaveType = value),
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
                    onTap: () => _selectDate(_startDateController),
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
                    onTap: () => _selectDate(_endDateController),
                  ),
                  SizedBox(height: 10.h),

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
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "Applied",
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
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "Reason of Leave",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  const Text("*Approver's Comments",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextField(
                    controller: _approverCommentController,
                    maxLines: 1,
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
                            backgroundColor:
                                const Color.fromARGB(255, 78, 157, 222),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 8.w),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Note Saved!")),
                            );
                          },
                          icon: Icon(Icons.save,
                              size: 16.sp, color: Colors.white),
                          label: const Text(
                            "Update",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
