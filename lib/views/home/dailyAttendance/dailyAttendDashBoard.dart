import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DailyAttendDashboard extends StatefulWidget {
  const DailyAttendDashboard({super.key});

  @override
  State<DailyAttendDashboard> createState() => _DailyAttendDashboardState();
}

class _DailyAttendDashboardState extends State<DailyAttendDashboard> {
  final TextEditingController _dateController = TextEditingController();
  String? selectedDate;
  final List<String> classes = ["3 B", "4 D", "5 C", "5 D"];
  String? selectedClass;

  final Map<String, List<String>> studentsByClass = {
    "3 B": ["Aarav Chandra", "Vedant Yewle", "Raghav Mishra", "Saket Sangale"],
    "4 D": [
      "Unnat Singh",
      "Ratish Nair",
      "Ira Jagtap",
      "Raviraj Ghule",
      "Advay Bhende",
      "Anvita Bhasme Bhasme",
      "Sydney Rosario",
      "Prisha Katkar","Unnat Singh",
      "Ratish Nair",
      "Ira Jagtap",
      "Raviraj Ghule",
      "Advay Bhende",
      "Anvita Bhasme Bhasme",
      "Sydney Rosario",
      "Prisha Katkar","Unnat Singh",
      "Ratish Nair",
      "Ira Jagtap",
      "Raviraj Ghule",
      "Advay Bhende",
      "Anvita Bhasme Bhasme",
      "Sydney Rosario",
      "Prisha Katkar"
    ],
    "5 C": [
      "Advay Bhende",
      "Anvita Bhasme Bhasme",
      "Sydney Rosario",
      "Prisha Katkar"
    ],
    "5 D": ["Saket Sangale", "Raviraj Ghule", "Chhayank Vijay Gosi"],
  };

  /// Stores absent status (default: all are present)
  final Map<String, bool> absentStatus = {};

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        selectedDate = "${picked.day}-${picked.month}-${picked.year}";
        _dateController.text = selectedDate!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("Daily Attendance (2024-2025)",
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 226, 25, 99),
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
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Class & Date Selection
             Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("*Class", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        value: selectedClass,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                        ),
                        hint: const Text("Select Class"),
                        items: classes.map((cls) => DropdownMenuItem(value: cls, child: Text(cls))).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedClass = value;
                            absentStatus.clear();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("*Select Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _dateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Select Date",
                          prefixIcon: const Icon(Icons.calendar_today),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                        ),
                        onTap: _selectDate,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),

            /// Student List (Scrollable)
            if (selectedClass != null && selectedDate != null)
              Expanded( // Makes only this section scrollable
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                  color: Colors.white.withOpacity(0.9),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Student List", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),

                      /// Table Header
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                        color: const Color.fromARGB(255, 233, 219, 236),
                        child: Row(
                          children: [
                            Expanded(flex: 2, child: Center(child: Text("Present", style: TextStyle(fontWeight: FontWeight.bold)))),
                            Expanded(flex: 2, child: Center(child: Text("Roll No", style: TextStyle(fontWeight: FontWeight.bold)))),
                            Expanded(flex: 4, child: Center(child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold)))),
                            Expanded(flex: 2, child: Center(child: Text("Absent", style: TextStyle(fontWeight: FontWeight.bold)))),
                          ],
                        ),
                      ),

                      /// Scrollable Student List
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: studentsByClass[selectedClass]!.asMap().entries.map((entry) {
                              int index = entry.key;
                              String studentName = entry.value;
                              bool isAbsent = absentStatus[studentName] ?? false;

                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Checkbox(
                                          value: true, // Always checked
                                          onChanged: null, // Non-editable
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: TextStyle(fontSize: 14.sp, ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        studentName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: isAbsent ? Colors.orange : Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Checkbox(
                                          value: isAbsent,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              absentStatus[studentName] = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            /// Always Visible "Update" Button
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 98, 163, 216),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 12.h),
                  ),
                  onPressed: () {},
                  child: const Text("Update", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}}