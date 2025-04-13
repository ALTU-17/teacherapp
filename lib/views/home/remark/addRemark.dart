import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'studentListRemark.dart'; // Import the correct student selection screen

class AddRemark extends StatefulWidget {
  const AddRemark({super.key});

  @override
  State<AddRemark> createState() => _AddRemarkState();
}

class _AddRemarkState extends State<AddRemark> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _subjectOfRemarkController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();

  String? selectedSubject;
  final List<String> subjects = ["Math", "English", "Science", "SST", "Hindi"];
  final List<String> classes = ["3 B", "4 D", "5 C", "5 D"];
  final List<String> selectedClasses = [];
  List<String> selectedStudents = []; // ✅ Added for storing selected students

  @override
  void dispose() {
    _dateController.dispose();
    _subjectOfRemarkController.dispose();
    _remarkController.dispose();
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
        _dateController.text = "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  void _resetForm() {
    setState(() {
      selectedClasses.clear();
      selectedSubject = null;
      selectedStudents.clear();
      _dateController.clear();
      _subjectOfRemarkController.clear();
      _remarkController.clear();
    });
  }

  void _openStudentSelection() async {
    final List<String>? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StudentSelectionScreen()),
    );

    if (result != null) {
      setState(() {
        selectedStudents = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Create Remark (2024-2025)", style: TextStyle(color: Colors.white)),
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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 140.h),
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
                  /// **Class Selection (Checkboxes)**
                  const Text("*Class", style: TextStyle(fontWeight: FontWeight.bold)),
                  Wrap(
                    spacing: 5.w,
                    children: classes.map((cls) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: selectedClasses.contains(cls),
                            onChanged: (bool? value) {
                              setState(() {
                                value == true ? selectedClasses.add(cls) : selectedClasses.remove(cls);
                              });
                            },
                          ),
                          Text(cls),
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20.h),

                  /// **Subject Dropdown**
                  const Text("*Subject", style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: selectedSubject,
                      hint: const Text("Select Subject"),
                      items: subjects.map((subject) {
                        return DropdownMenuItem(value: subject, child: Text(subject));
                      }).toList(),
                      onChanged: (value) => setState(() => selectedSubject = value),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  /// **Student Selection Field (Clickable)**
                  const Text("*Students", style: TextStyle(fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: _openStudentSelection,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10.r),
                       
                      ),
                      child: Text(
                        selectedStudents.isEmpty ? "select students" : selectedStudents.join(", "),
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  /// **Date Picker (Clickable)**
                  
                 

                  /// **Subject of Remark**
                  const Text("*Subject of Remark", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextField(
                    controller: _subjectOfRemarkController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Type here...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  /// **Remark**
                  const Text("*Remark", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextField(
                    controller: _remarkController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Type here...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Attach Document", style: TextStyle(fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.attach_file, color: Colors.blue),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Attach file clicked")),
                          );
                        },
                      ),
                      
                    ],
                  ),
                 
                  SizedBox(height: 10.h),

                  /// Save & Reset Buttons
                Row(
  children: [
    Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 78, 157, 222),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r), // Reduced border radius
          ),
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w), // Reduced padding
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Note Saved!")),
          );
        },
        icon: Icon(Icons.save, size: 16.sp, color: Colors.white), // Reduced icon size
        label: const Text("Save", style: TextStyle(color: Colors.white, fontSize: 14)), // Reduced text size
      ),
    ),
    SizedBox(width: 20.w), // Slightly reduced space between buttons
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
        icon: Icon(Icons.refresh, size: 16.sp, color: Colors.black), // Reduced icon size
        label: const Text("Reset", style: TextStyle(color: Colors.black, fontSize: 14)), // Reduced text size
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
