import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddLeaveApplicationPage extends StatefulWidget {
  const AddLeaveApplicationPage({super.key});

  @override
  State<AddLeaveApplicationPage> createState() => _AddLeaveApplicationPage();
}

class _AddLeaveApplicationPage extends State<AddLeaveApplicationPage> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? selectedSubject;
  final List<String> subjects = ["Casual Leave ", "Sick Leave ", ];

  final List<String> selectedClasses = [];

  @override
  void dispose() {
    _dateController.dispose();
    _descriptionController.dispose();
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
      _dateController.clear();
      _descriptionController.clear();
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Create Leave Application(2024-2025)" ,style: TextStyle(color: Colors.white), ),
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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
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
                  
                  const Text("*Leave Type", style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                  
                    child: DropdownButtonFormField<String>(
                      value: selectedSubject,
                      hint: const Text("Select Leave Type"),
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

                  /// Date Picker
                  const Text("*Select Start Date", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Select Date",
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onTap: _selectDate,
                  ),
                   SizedBox(height: 10.h),

                  /// Date Picker
                  const Text("*Select End  Date", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: "Select End Date",
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onTap: _selectDate,
                  ),
                  
 SizedBox(height: 10.h),
                  /// Description
                  const Text("*Days", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "No.of Days",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                   const Text("*Reason", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Reason of Leave",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  /// Attach Document
                  

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
