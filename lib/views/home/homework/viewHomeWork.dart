import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewHomeWork extends StatefulWidget {
  final Map<String, String> note;

  const ViewHomeWork({super.key, required this.note});

  @override
  State<ViewHomeWork> createState() => _ViewHomeWorkState();
}

class _ViewHomeWorkState extends State<ViewHomeWork> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> students = [
    {"name": "ADVAY BHENDE", "status": "Assigned", "comment": ""},
    {"name": "ANVITA BHASME", "status": "Assigned", "comment": ""},
    {"name": "JEEVIKA KHANDELWAL", "status": "Assigned", "comment": ""},
    {"name": "AARAV CHANDRA", "status": "Assigned", "comment": ""},
    {"name": "CHHAYANK VIJAY GOSI", "status": "Assigned", "comment": ""},
    {"name": "RAGHAV MISHRA", "status": "Assigned", "comment": ""},
    {"name": "ANVITA BHASME", "status": "Assigned", "comment": ""},
    {"name": "JEEVIKA KHANDELWAL", "status": "Assigned", "comment": ""},
    {"name": "AARAV CHANDRA", "status": "Assigned", "comment": ""},
    {"name": "CHHAYANK VIJAY GOSI", "status": "Assigned", "comment": ""},
    {"name": "RAGHAV MISHRA", "status": "Assigned", "comment": ""},
  ];

  List<Map<String, dynamic>> filteredStudents = [];
  List<String> statusOptions = ["Assigned", "Completed", "Partial"];
  List<bool> selectedStudents = [];
  Set<int> visibleCommentIndexes = {}; // Track which comments are visible

  @override
  void initState() {
    super.initState();
    filteredStudents = List.from(students);
    selectedStudents = List.generate(students.length, (index) => false);
  }

  /// 🔍 *Search Functionality*
  void _filterStudents(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredStudents = List.from(students);
      } else {
        filteredStudents = students
            .where((student) => student["name"].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      selectedStudents = List.generate(filteredStudents.length, (index) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 50.h,
        title: Text(
          "HomeWork (2024-2025)",
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
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
        child: Column(
          children: [
            SizedBox(height: 110.h),

            /// *Homework Title*
            // Text(
            //   "HomeWork",
            //   style: TextStyle(
            //     fontSize: 18.sp,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.white,
            //   ),
            // ),
           
            /// 🔍 *Search Box*
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: TextField(
                controller: _searchController,
                onChanged: _filterStudents,
                decoration: InputDecoration(
                  hintText: "Search Student...",
                  hintStyle: TextStyle(color: const Color.fromARGB(255, 215, 208, 208), fontSize: 14.sp),
                  prefixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 238, 232, 232)),
                ),
              ),
            ),

            /// *Homework Description*
            Padding(
              padding: EdgeInsets.only(left: 20, top: 15),
             // padding: EdgeInsets.all(5.w),
              child: Container(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    text: "Description : ",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                     // color: const Color.fromARGB(255, 246, 226, 226),
                    ),
                    children: [
                      TextSpan(
                        text: widget.note['description'] ?? 'No Description',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: const Color.fromARGB(255, 240, 229, 229),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
             SizedBox(height: 5.w),
            
Padding(
  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
  child: Container(
    padding: EdgeInsets.all(10.w),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 241, 229, 229),
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// *Status Text (Truncated if too long)*
        Expanded(
          child: Text(
            "Screenshot_2025-01-04 ba480b12.jpg",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 80, 77, 77),
            ),
            maxLines: 1, // Ensure it stays on one line
            overflow: TextOverflow.ellipsis, // Show "..." if too long
          ),
        ),

        SizedBox(width: 5.w), // Small spacing

        /// *Eye Icon*
        GestureDetector(
          onTap: () {
            // Handle preview action
          },
          child: Icon(
            Icons.remove_red_eye,
            color: Colors.purple,
            size: 20.sp,
          ),
        ),

        SizedBox(width: 10.w), // Small spacing

        /// *Download Icon*
        GestureDetector(
          onTap: () {
            // Handle download action
          },
          child: Icon(
            Icons.download,
            color: Colors.black,
            size: 20.sp,
          ),
        ),
      ],
    ),
  ),
),

            Expanded(child: _studentList()),

            /// *Update Button*
          
             /// *Update Button*
Padding(
  padding: EdgeInsets.symmetric(vertical: 10.h), 
  child: ElevatedButton(
    onPressed: () {
      // Handle update logic here
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[400], // Light grey color
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h), // Adjust padding for size
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r), // Slightly rounded corners
      ),
    ),
    child: Text(
      "Update",
      style: TextStyle(
        fontSize: 14.sp, // Smaller font size
        fontWeight: FontWeight.bold,
        color: Colors.black, // Darker text for contrast
      ),
    ),
  ),
),

          ],
        ),
      ),
    );
  }
Widget _studentList() {
  return ListView.builder(
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    itemCount: filteredStudents.length,
    itemBuilder: (context, index) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: EdgeInsets.only(left: 10,bottom: 10,right: 10),
          //padding: EdgeInsets.all(5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ✅ *Row: Checkbox + Student Name + Status Dropdown + Note Icon*
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// ✅ *Checkbox*
                  Checkbox(
                    value: selectedStudents[index],
                    onChanged: (bool? value) {
                      setState(() {
                        selectedStudents[index] = value ?? false;
                      });
                    },
                  ),

                  /// ✅ *Student Name*
                  Expanded(
                    child: Text(
                      filteredStudents[index]['name'],
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  /// ✅ *Status Dropdown*
                  /// 
                  /// 
                  /// 
                  DropdownButton<String>(
                    value: filteredStudents[index]['status'],
                    underline: SizedBox(),
                    onChanged: (String? newValue) {
                      setState(() {
                        filteredStudents[index]['status'] = newValue!;
                      });
                    },
                    items: statusOptions.map((String status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status, style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold)),
                      );
                    }).toList(),
                  ),




                  /// ✅ *Note Add Icon*
                 
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibleCommentIndexes.contains(index)) {
                          visibleCommentIndexes.remove(index);
                        } else {
                          visibleCommentIndexes.add(index);
                        }
                      });
                    },
                  
                    child: Icon(
                      Icons.note_add,
                      color: Colors.red,
                      size: 22.sp,
                    ),
                  ),
                ],
              ),

              /// ✅ *Always Show Parent Comment Below (Even if Empty)*
             // SizedBox(height: 8.h),
              Row(
                children: [
                  Padding(
                     padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "Parent Comment:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                   // padding: const EdgeInsets.all(8.0),
                    child: Text(
                                    filteredStudents[index]['comment'].toString().isEmpty
                      ? "check the Note i have added"
                      : filteredStudents[index]['comment'],
                                    style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                                  ),
                  ),
                ],
              ),
             //SizedBox(height: 5.h),

              

              /// ✅ *Comment Input Field (Only Show When Toggled)*
              if (visibleCommentIndexes.contains(index)) ...[
  SizedBox(height: 10.h), // Reduced spacing

  SizedBox(
    height: 45.h, // Reduced height
    child: TextField(
      style: TextStyle(fontSize: 12.sp), // Smaller text size
      decoration: InputDecoration(
        hintText: "Type Comment...",
        hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
        contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w), // Smaller padding
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r), // Smaller radius Anvita
         // borderSide: BorderSide(color: Colors.grey, width: 0.1), // Thinner border
        ),
      ),
      onChanged: (text) {
        setState(() {
          filteredStudents[index]['comment'] = text;
        });
      },
    ),
  ),
],

            ],
          ),
        ),
      );
    },
  );
}
}