

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacherapp/views/home/techerNote/addTeacherNote.dart';
import 'package:teacherapp/views/home/techerNote/editTeacherNote.dart';
import 'package:teacherapp/views/home/techerNote/viewedByTeacherNote.dart';
import 'package:teacherapp/views/home/techerNote/viewTeacherNote.dart';

class TeacherNoteDashBoard extends StatelessWidget {
  const TeacherNoteDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notes = [
      {
        'class': '5 D',
        'subject': 'English',
        'date': '11-03-2025',
        'description': 'Test note for English.',
      },

      {
        'class': '5 D',
        'subject': 'SST',
        'date': '01-03-2025',
        'description': 'Created for iOS.',
      },
      {
        'class': '5 D',
        'subject': 'SST',
        'date': '01-03-2025',
        'description': 'Created by D for iOS.',
      },
      {
        'class': '5 D',
        'subject': 'English',
        'date': '26-02-2025',
        'description': 'Test.',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 60.h,
        title: Text(
           "Teacher Note(2024-2025)",
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
      MaterialPageRoute(builder: (context) => const AddTeacherNote()),
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
        padding: EdgeInsets.all(12.w),
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

            SizedBox(height: 6.h),

            /// **Subject**
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

            Divider(color: Colors.grey.shade300, thickness: 1),

            /// **Description**
            
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    "Description: ${widget.note['description']}",
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                ),
              ],
            ),

            /// **Action Buttons**
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (showActions) ...[
                  if (showEditActions) ...[
                    /// **✔ Check Button**
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () {
                        setState(() {
                          showActions = false;
                          showEditActions = false;
                        });
                      },
                    ),

                    /// **✏ Edit Button**
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditTeacherNote()),
    );
  },
                    ),

                    /// **🗑 Delete Button**
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Delete action triggered")),
                        );
                      },
                    ),
                  ] else ...[
                    /// **👀 View Button**
                    IconButton(
                      icon: const Icon(Icons.remove_red_eye, color: Colors.purple),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewTeacherNote(note: widget.note),
                          ),
                        );
                        setState(() {
                          showActions = false;
                        });
                      },
                    ),

                    /// **📖 Read Button**
                    IconButton(
                      icon: const Icon(Icons.menu_book, color: Colors.purple),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewedByTeacherNote(note: widget.note),
                          ),
                        );
                        setState(() {
                          showActions = false;
                        });
                      },
                    ),
                  ],
                ] else
                  IconButton(
                    icon: const Icon(Icons.more_horiz, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        showActions = true;
                        showEditActions = widget.note['subject'] == "SST"; 
                        // Only show edit/delete/check for SST, change condition as needed
                      });
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
