import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewedByTeacherNote extends StatefulWidget {
  final Map<String, String> note;

  const ViewedByTeacherNote({super.key, required this.note});

  @override
  _ViewedByTeacherNote createState() => _ViewedByTeacherNote();
}

class _ViewedByTeacherNote extends State<ViewedByTeacherNote> {
  final TextEditingController _searchController = TextEditingController(); // ✅ Search Controller
  List<Map<String, dynamic>> students = [];
  List<Map<String, dynamic>> filteredStudents = [];

  @override
  void initState() {
    super.initState();
    students = _dummyStudents(); // Load initial student list
    filteredStudents = List.from(students); // Initially, show all students
  }

  /// Dummy list of students
  List<Map<String, dynamic>> _dummyStudents() {
    return [
      {"id": 1, "name": "ADVAY BHENDE", "viewed": false},
      {"id": 2, "name": "AARON JONES", "viewed": false},
      {"id": 3, "name": "LIAM", "viewed": false},
      {"id": 4, "name": "RAVIRAJ GHULE", "viewed": false},
      {"id": 5, "name": "ANVITA BHASME", "viewed": false},
      {"id": 6, "name": "CHHAYANK VIJAY GOSI", "viewed": true},
      {"id": 7, "name": "SYDNEY ROSARIO", "viewed": false},
      {"id": 8, "name": "SANVI KADAM", "viewed": true},
      {"id": 9, "name": "ISHAN KHANDELWAL", "viewed": false},
      {"id": 10, "name": "SHIFRA D'SOUZA", "viewed": true},
      {"id": 11, "name": "ROHAN SHARMA", "viewed": false},
      {"id": 12, "name": "ANIKA VERMA", "viewed": false},
      {"id": 13, "name": "KARAN SINGH", "viewed": false},
      {"id": 14, "name": "MEERA NAIR", "viewed": true},
      {"id": 15, "name": "VIVEK KAPOOR", "viewed": false},
      {"id": 16, "name": "PRIYA RASTOGI", "viewed": false},
      {"id": 17, "name": "SUMIT JADHAV", "viewed": true},
      {"id": 18, "name": "TANYA DESAI", "viewed": false},
      {"id": 19, "name": "NIKHIL CHOPRA", "viewed": false},
      {"id": 20, "name": "POOJA SAXENA", "viewed": true},
      {"id": 21, "name": "RAHUL YADAV", "viewed": false},
      {"id": 22, "name": "SNEHA MALHOTRA", "viewed": false},
    ];
  }

  /// **Search Function**
  void _filterStudents(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredStudents = List.from(students);
      } else {
        filteredStudents = students
            .where((student) =>
                student["name"].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  /// **Toggle viewed status**
  void toggleViewedStatus(int index) {
    setState(() {
      filteredStudents[index]['viewed'] = !filteredStudents[index]['viewed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 60.h,
        title: Text(
          "Teacher Note Viewed By(2024-2025)",
          style: TextStyle(fontSize: 17.sp, color: Colors.white),
        ),
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0, // No shadow
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink, Colors.blue], // Gradient background
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 120.h), // Adjusted for AppBar spacing

            /// **Search Box**

             SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextField(
                controller: _searchController,
                onChanged: _filterStudents, // Call search function
                decoration: InputDecoration(
                  hintText: "Search Student...",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 232, 219, 219),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

           

            /// **Heading**
           
            SizedBox(height: 20.h),

            /// **Student List**
            Expanded(
              child: filteredStudents.isEmpty
                  ? Center(
                      child: Text(
                        "No students found",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: filteredStudents.length,
                      itemBuilder: (context, index) {
                        final student = filteredStudents[index];
                        return _studentTile(student, index);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// **Student Tile**
  Widget _studentTile(Map<String, dynamic> student, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: ListTile(
          leading: Text(
            student['id'].toString(),
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          title: Text(
            student['name'],
            style: TextStyle(fontSize: 14.sp),
          ),
          trailing: IconButton(
            icon: Icon(
              student['viewed'] ? Icons.person : Icons.person_off,
              color: student['viewed'] ? Colors.blue : Colors.red,
            ),
            onPressed: () => toggleViewedStatus(index),
          ),
        ),
      ),
    );
  }
}
