import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacherapp/common/customDropDown.dart';

class TeacherProfilePage extends StatefulWidget {
  const TeacherProfilePage({super.key});

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage> {
  final List<String> qualifications = [
    'HSc',
    'M.Sc',
    'MSE',
    'BPharm',
    'B.Com',
    'M.Phil',
    'MCA',
    'M Com',
    'BCA',
    'DCE',
    'MBA',
    'M.LIS',
    'BE',
    'B.Sc',
    'B.A',
    'PGDBM',
    'M.A',
    'B.LIS',
    'BCS',
    'B.Music n Dance',
  ];

  String? selectedprofSubjects;
  String? selectedTrainingStatus;
  String? selectedGender;
  String? selectedBloodGroup;

  final List<String> profSubjects = ['D.Ed', 'B.Ed', 'M.Ed', 'Others'];
  final List<String> trainingStatuses = ['Completed', 'Ongoing', 'Not Started'];
  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> bloodGroup = ["o+", "A+"];

  final Set<String> selectedQualifications = {'B.Com', 'M.A'};

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 203, 13, 76),
              Color.fromARGB(255, 80, 148, 203)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ],
            ),
            height: 600.h,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Center(child: Text("Teacher Profile",  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 15.sp),)),
                  // SizedBox(height: 10,)    ,      // Profile Picture
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 70.r,
                          backgroundImage: const NetworkImage(
                            "https://images.unsplash.com/photo-1519681393784-d120267933ba",
                          ),
                        ),
                        CircleAvatar(
                          radius: 18.r,
                          backgroundColor: Colors.grey.shade300,
                          child: const Icon(Icons.add, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  _buildRowField("Staff's Name", "Kavita", isRequired: true),
                  _buildRowField("Date Of Birth", "05-07-2014",
                      isRequired: true),
                  _buildRowField("Date Of Joining", "01-04-2020",
                      isRequired: true),
                  _buildRowField("Designation", "Teacher"), // << Insert here

                  Padding(
                    padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(text: "Academic Qualification"),
                          TextSpan(
                            text: ' *',
                            style:
                                TextStyle(color: Colors.red, fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Wrap(
                    spacing: 5.w,
                    runSpacing: 1.h,
                    children: qualifications.map((item) {
                      final isChecked = selectedQualifications.contains(item);
                      return FilterChip(
                        selected: isChecked,
                        label: Text(item),
                        selectedColor: Colors.blue.shade100,
                        checkmarkColor: Colors.blue,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isChecked ? Colors.black : Colors.black54,
                          fontSize: 12.sp,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.r),
                          side: BorderSide(color: Colors.grey.shade400),
                        ),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedQualifications.add(item);
                            } else {
                              selectedQualifications.remove(item);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10.h),
                  //_buildRowField("Professional Qualification", "", isRequired: true),

// 👇 Dropdown here
                  CustomDropdownField(
                    label: "Professional Qualification",
                    value: selectedprofSubjects,
                    options: profSubjects,
                    onChanged: (value) {
                      setState(() {
                        selectedprofSubjects = value;
                      });
                    },
                    isRequired: true,
                  ),

                  _buildRowField("Subject for D.Ed/B.Ed", "",
                      isRequired: false),
                  CustomDropdownField(
                    label: "Training Status",
                    value: selectedTrainingStatus, // ✅ correct variable
                    options: trainingStatuses,
                    onChanged: (value) {
                      setState(() {
                        selectedTrainingStatus = value; // ✅ correct assignment
                      });
                    },
                    isRequired: true,
                  ),

                  _buildRowField("Experience", "", isRequired: true),
                  CustomDropdownField(
                    label: "Gender",
                    value: selectedGender,
                    options: genderOptions,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                    isRequired: true,
                  ),
                  CustomDropdownField(
                    label: "Blood Group",
                    value: selectedBloodGroup,
                    options: bloodGroup,
                    onChanged: (value) {
                      setState(() {
                        selectedBloodGroup = value;
                      });
                    },
                    isRequired: true,
                  ),
                  _buildRowField("Religion", "", isRequired: false),
                  _buildRowField("Address", "", isRequired: true),
                  _buildRowField("Mobile Number", "", isRequired: true),
                  _buildRowField("Email ID", "", isRequired: false),
                  _buildRowField("Adhar Card No.", "", isRequired: false),

                  Center(
                    child: SizedBox(
                      height: 50,
                      width: 110,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          backgroundColor:
                              const Color(0xFF4E9DDE), // Light blue color
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Profile Updated')),
                          );
                          // Add actual logic here to save data
                        },
                        child: Text(
                          "Update",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ... continue other fields
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRowField(String label, String value, {bool isRequired = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 130.w,
            child: RichText(
              text: TextSpan(
                text: label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5.sp,
                  color: Colors.black,
                ),
                children: isRequired
                    ? [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(color: Colors.red, fontSize: 14.sp),
                        )
                      ]
                    : [],
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              initialValue: value,
              readOnly: true,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
