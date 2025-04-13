
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> showLogoutConfirmationDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap a button
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Logout Confirmation',
          style: TextStyle(fontSize: 22.sp),
        ),
        content: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: ListBody(
              children: <Widget>[
                Text('Do you want to logout?',
                    style: TextStyle(fontSize: 16.sp,color: Colors.grey)),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
          ),
          TextButton(
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
             // logout(context); // Call the logout function
            },
          ),
        ],
      );
    },
  );
}


// Future<void> logout(BuildContext context) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.clear(); // Clear all stored data

//   // Optionally show a toast message
//   Fluttertoast.showToast(
//     msg: 'Logged out successfully!',
//     backgroundColor: Colors.black45,
//     textColor: Colors.white,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.CENTER,
//   );

//   // Navigate to the login screen
//   Navigator.of(context).pushAndRemoveUntil(
//     MaterialPageRoute(builder: (context) => UserNamePage()),
//         (Route<dynamic> route) => false,
//   );
// }


