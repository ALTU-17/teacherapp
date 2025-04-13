// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class DailyAttenStudent extends StatefulWidget {
//   const DailyAttenStudent({super.key});

//   @override
//   State<DailyAttenStudent> createState() => _DailyAttenStudent();
// }

// class _DailyAttenStudent extends State<DailyAttenStudent> {
//   final List<Map<String, dynamic>> students = [
//     {"id": 5, "name": "JEEVIKA KHANDELWAL"},
//     {"id": 7, "name": "CHHAYANK VIJAY GOSI"},
//     {"id": 8, "name": "RAGHAV MISHRA"},
//     {"id": 9, "name": "RATISH NAIR"},
//     {"id": 10, "name": "SYDNEY ROSARIO"},
//     {"id": 11, "name": "UNNAT SINGH"},
//     {"id": 12, "name": "VEDANT YEWLE"},
//     {"id": 13, "name": "IRA JAGTAP"},
//     {"id": 14, "name": "SANVI KADAM"},
//     {"id": 15, "name": "SHAURYA KUMBHAR"},
//   ];
// final Set<String> selectedStudents = {};

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Select Students", style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.pink,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(colors: [Colors.pink, Colors.blue], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//         ),
//         child: Column(
//           children: [
//             // Student List (Scrollable)
//             Expanded(
//               child: ListView.builder(
//                 padding: EdgeInsets.all(12.w),
//                 itemCount: students.length,
//                 itemBuilder: (context, index) {
//                   final student = students[index];
//                   return Card(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//                     child: ListTile(
//                       leading: Text("${student['id']}", style: const TextStyle(fontWeight: FontWeight.bold)),
//                       title: Text(student['name']),
//                       trailing: Checkbox(
//                         value: selectedStudents.contains(student['name']),
//                         onChanged: (bool? value) {
//                           setState(() {
//                             value == true ? selectedStudents.add(student['name']) : selectedStudents.remove(student['name']);
//                           });
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             // Submit Button (Fixed at Bottom)
//             Padding(
//               padding: EdgeInsets.only(left: 20 , bottom: 30, right: 10),
//             //  padding: const EdgeInsets.all(28.0),
//               child: Center(
//                 child: SizedBox(
//                  // width: double.infinity,
//                   height: 50.h,
                  
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (selectedStudents.isEmpty) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("Please select at least one student")),
//                         );
//                         return;
//                       }
//                       print("Selected Students: $selectedStudents");
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 189, 195, 185),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//                     ),
//                     child: const Text(
//                       "Submit",
//                       style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 100, 94, 94), fontWeight: FontWeight.bold ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
