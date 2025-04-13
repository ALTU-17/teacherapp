

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacherapp/views/home/remark/addRemark.dart';
import 'package:teacherapp/views/home/remark/viewRemark.dart';

class RemarkDashBoard extends StatelessWidget {
  const RemarkDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notes = [
      {
        'class': '5 D',
        'subject': 'English',
        'date': '11-03-2025',
        'Remark Type': 'Test note for English.',
      },

      {
        'class': '5 D',
        'subject': 'SST',
        'date': '01-03-2025',
        'Remark Type': 'Created for iOS.',
      },
      {
        'class': '5 D',
        'subject': 'SST',
        'date': '01-03-2025',
        'Remark Type': 'Created by D for iOS.',
      },
      {
        'class': '5 D',
        'subject': 'English',
        'date': '26-02-2025',
        'Remark Type': 'Test.',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 60.h,
        title: Text(
           "Remarks(2024-2025)",
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
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
            SizedBox(height: 120.h),
            
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return TeacherNoteCard(note: note);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddRemark()),
    );
  },
    backgroundColor: const Color.fromARGB(221, 168, 160, 160),
        child: const Icon(Icons.add, size: 30, color: Colors.black),
        
      ),
    );
  }
}

class TeacherNoteCard extends StatefulWidget {
  final Map<String, String> note;
  const TeacherNoteCard({super.key, required this.note});

  @override
  // ignore: library_private_types_in_public_api
  _TeacherNoteCardState createState() => _TeacherNoteCardState();
}


class _TeacherNoteCardState extends State<TeacherNoteCard> {
  bool showActions = false;
  bool showEditActions = false; // New state to toggle edit, delete, and check icons

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **Class & Subject Row**
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.class_, color: Colors.blue, size: 18),
                    SizedBox(width: 5.w),
                    Text(
                      "Class: ${widget.note['class']}",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
                
                Row(
              children: [
                const Icon(Icons.menu_book, color: Colors.red, size: 18),
                SizedBox(width: 8.w),
                Text(
                  widget.note['subject']!,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                ),
              ],
            ),
            Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.green, size: 18),
                    SizedBox(width: 5.w),
                    Text(
                      widget.note['date']!,
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),

          //  SizedBox(height: 6.h),

            /// **Subject**
            

            Divider(color: const Color.fromARGB(255, 215, 199, 199), thickness: 1.5),

            /// **Description**
            
          
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    "Student Name: ${widget.note['Remark Type']}",
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                  
                ),
              ],
            ), 
             Divider(color: Colors.grey.shade300, thickness: 1),
              Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 8.w),
                Expanded(
                  child:Text(
                    "Subject of Remark: ${widget.note['Remark Type']}",
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                  
                ),
              ],
            ),
             Divider(color: Colors.grey.shade300, thickness: 1),
               Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    "Remark Type: ${widget.note['Remark Type']}",
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                  
                ),
              ],
            ),

            Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
   
    IconButton(
                      icon: const Icon(Icons.remove_red_eye, color: Colors.purple),
                      onPressed: () {
                        Navigator.push(
                          context,
                            MaterialPageRoute(builder: (context) => const ViewReamark(note: {},)),
                        //  MaterialPageRoute(builder: (BuildContext context) { ViewReamark }
                           // builder: (context) => ViewReamark(note: widget.note),
                          
                        );
                        setState(() {
                          showActions = false;
                        });
                      },
                    ),


    SizedBox(width: 20), // Adds space between icons

    /// **📖 Read Icon (Non-Clickable)**
    Icon(
      Icons.menu_book,
      color: Colors.purple,
      size: 24, // Adjust size as needed
    ),
  ],
),

                  ],
                
                 
            
            ),
         
        ),
      
    );
  }
}
