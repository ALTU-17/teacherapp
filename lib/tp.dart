// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class DailyAttendDashboard extends StatefulWidget {
//   const DailyAttendDashboard({super.key});

//   @override
//   State<DailyAttendDashboard> createState() => _DailyAttendDashboardState();
// }

// class _DailyAttendDashboardState extends State<DailyAttendDashboard> {
//   final TextEditingController _dateController = TextEditingController();
//   String? selectedDate;
//   final List<String> classes = ["3 B", "4 D", "5 C", "5 D"];
//   String? selectedClass;
//   bool selectAll = false; // Track select all checkbox state

//   final Map<String, List<String>> studentsByClass = {
//     "3 B": ["Aarav Chandra", "Vedant Yewle", "Raghav Mishra", "Saket Sangale"],
//     "4 D": ["Unnat Singh", "Ratish Nair", "Ira Jagtap", "Raviraj Ghule"],
//     "5 C": ["Advay Bhende", "Anvita Bhasme", "Sydney Rosario", "Prisha Katkar"],
//     "5 D": ["Saket Sangale", "Raviraj Ghule", "Chhayank Vijay Gosi"],
//   };

//   final Map<String, bool> attendanceStatus = {};

//   @override
//   void dispose() {
//     _dateController.dispose();
//     super.dispose();
//   }

//   void _selectDate() async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2023),
//       lastDate: DateTime(2030),
//     );
//     if (picked != null) {
//       setState(() {
//         selectedDate = "${picked.day}-${picked.month}-${picked.year}";
//         _dateController.text = selectedDate!;
//       });
//     }
//   }

//   /// Toggles the select all feature
//   void _toggleSelectAll(bool? value) {
//     if (selectedClass == null) return;
//     setState(() {
//       selectAll = value!;
//       for (String student in studentsByClass[selectedClass] ?? []) {
//         attendanceStatus[student] = selectAll;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         title: const Text("Daily Attendance (2024-2025)", style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color.fromARGB(255, 226, 25, 99),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.pink, Colors.blue],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(20.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// Class & Date Selection
//               Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text("*Class", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
//                         SizedBox(height: 5),
//                         DropdownButtonFormField<String>(
//                           value: selectedClass,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white,
//                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
//                           ),
//                           hint: const Text("Select Class"),
//                           items: classes.map((cls) => DropdownMenuItem(value: cls, child: Text(cls))).toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               selectedClass = value;
//                               attendanceStatus.clear();
//                               selectAll = false;
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: 15.w),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text("*Select Date", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
//                         SizedBox(height: 5),
//                         TextFormField(
//                           controller: _dateController,
//                           readOnly: true,
//                           decoration: InputDecoration(
//                             hintText: "Select Date",
//                             prefixIcon: const Icon(Icons.calendar_today),
//                             filled: true,
//                             fillColor: Colors.white,
//                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
//                           ),
//                           onTap: _selectDate,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 15.h),

//               /// Student List with Select All Feature
//               if (selectedClass != null && selectedDate != null)
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Card(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
//                       color: Colors.white.withOpacity(0.9),
//                       child: Padding(
//                         padding: EdgeInsets.all(10.w),
//                         child: Column(
//                           children: [
//                             const Text("Student List", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                             SizedBox(height: 10),

//                             /// Table Header with Select All Checkbox
//                             Container(
//                               padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10),
//                               color: Colors.grey[300],
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width: 50.w,
//                                     child: Checkbox(
//                                       value: selectAll,
//                                       onChanged: _toggleSelectAll,
//                                     ),
//                                   ),
//                                   SizedBox(width: 50.w, child: const Text("Roll No", style: TextStyle(fontWeight: FontWeight.bold))),
//                                   const Expanded(child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold))),
//                                   SizedBox(width: 80.w, child: const Text("Absentees", style: TextStyle(fontWeight: FontWeight.bold))),
//                                 ],
//                               ),
//                             ),

//                             /// Student List
//                             ListView.builder(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: studentsByClass[selectedClass]?.length ?? 0,
//                               itemBuilder: (context, index) {
//                                 String studentName = studentsByClass[selectedClass]![index];
//                                 return Container(
//                                   padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20),
//                                   decoration: BoxDecoration(
//                                     border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       SizedBox(
//                                         width: 50.w,
//                                         child: Checkbox(
//                                           value: attendanceStatus[studentName] ?? false,
//                                           onChanged: (bool? value) {
//                                             setState(() {
//                                               attendanceStatus[studentName] = value!;
//                                               selectAll = attendanceStatus.length == studentsByClass[selectedClass]?.length &&
//                                                   attendanceStatus.values.every((v) => v);
//                                             });
//                                           },
//                                         ),
//                                       ),
//                                       SizedBox(width: 50.w, child: Text("${index + 1}")),
//                                       Expanded(child: Text(studentName, style: const TextStyle(fontWeight: FontWeight.w500))),
//                                       SizedBox(
//                                         width: 30.w,
//                                         child: Checkbox(
//                                           value: !(attendanceStatus[studentName] ?? false),
//                                           onChanged: null,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),

//                             /// Submit Button
//                             SizedBox(height: 10.h),
//                             // ElevatedButton(
//                             //   style: ElevatedButton.styleFrom(
//                             //     backgroundColor: Colors.blue,
//                             //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
//                             //     padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 12.h),
//                             //   ),
//                             //  // onPressed: _submitAttendance,
//                             //   child: const Text("Update", style: TextStyle(color: Colors.white, fontSize: 16)),
//                             // ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
