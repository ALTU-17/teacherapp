import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewTeacherNote extends StatelessWidget {
  final Map<String, String> note;

  const ViewTeacherNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
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
            

            /// 📝 **Content Box**
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// **Class Info Table**
                    _infoTable([
                      {"Class:": note['class'] ?? ""},
                      {"Created On:": "25-02-2025"},
                      {"Published On:": "25-02-2025"},
                      {"Description:": note['description'] ?? ""},
                    ]),

                    SizedBox(height: 18.h),
                    Divider(color: Colors.grey.shade300, thickness: 1),

                    /// **Attachment Section**
                   Row(
  children: [
    /// 📎 File Name (Flexible to Prevent Overflow)
    Flexible(
      child: Text(
        " pexels-jonaskakaroto-736230.jpg",
        style: TextStyle(fontSize: 14, color: Colors.black),
        overflow: TextOverflow.ellipsis, // If too long, it shows "..."
        maxLines: 2, // Allows wrapping to next line
      ),
    ),
    
    /// 🎯 Buttons Move to Next Line if Needed
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.visibility, color: Colors.purple),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("View Attachment")),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.download, color: Colors.black),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Downloading...")),
            );
          },
        ),
      ],
    ),
  ],
),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ **Table for Key-Value Alignment**
  Widget _infoTable(List<Map<String, String>> data) {
    return Column(
      children: data
          .map(
            (row) => Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Row(
                children: [
                  SizedBox(
                    width: 120.w, // Fixed width for keys
                    child: Text(
                      row.keys.first,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row.values.first,
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
