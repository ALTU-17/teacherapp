

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacherapp/common/styles.dart';
import 'package:teacherapp/views/auth/password_screen.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  void initState() {
    // super.initState();
   
  }



  @override
  Widget build(BuildContext context) {
  

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/img.png', // Replace with your background image
              fit: BoxFit.cover,
            ),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    Image.asset(
                      'assets/logo.png', // Replace with your logo image
                      width: 200,
                      height: 140,
                    ),
                    // Center(
                    //   child: Text(
                    //    // 'Don\'t miss any update from school.  Follow your child\'s activity and   progress with our smart Parent App.',
                    //     // style: TextStyle(
                    //     //   color: Colors.white,
                    //     //   fontSize: 20,
                    //     // ),
                    //   //  textAlign: TextAlign.center,
                    //   ),
                    // ),
                    SizedBox(height: 15),
                    Image.asset(
                      'assets/loginPage.png',
                      // Replace with your logo image
                      width: 350.w,
                      height: 450.h,
                    ),

                    SizedBox(height: 40.h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        
                        decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.person_outline),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                   // SizedBox(height: 5),
                   // Visibility(
                    
                      // Set this boolean based on your condition
                      // child: Text(
                      //   'Invalid UserId!',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                   // ),
                    // Visibility(
                    
                    //   child: Text(
                    //     'Please Enter User Name!!',
                    //     style: TextStyle(
                    //       color: Colors.red,
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),

                    SizedBox(height: 35),
                    // _isLoading
                    //     ? CircularProgressIndicator() // Show progress indicator when loading
                    //     : Container(
                    //         height: 40,
                    //         width: 180,
                    //         decoration: BoxDecoration(
                    //             color: Colors.blue,
                    //             borderRadius: BorderRadius.circular(20)),
                    //         child: TextButton(
                    //           onPressed: () {
                    //             if (email.text.toString().isEmpty) {
                    //               setState(() {
                    //                 shouldShowText2 = true;
                    //               });

                    //               Fluttertoast.showToast(
                    //                 msg: 'Please Enter User Name!!',
                    //                 backgroundColor: Colors.black45,
                    //                 textColor: Colors.white,
                    //                 toastLength: Toast.LENGTH_LONG,
                    //                 gravity: ToastGravity.CENTER,
                    //               );
                    //             } else {
                    //               setState(() {
                    //                 shouldShowText2 = false;
                    //               });
                    //               loginfun(email.text.toString());
                    //             }
                    //           },
                              Container(
  height: 40,
  width: 180,
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(20),
  ),
  child: Center(
    child: TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PasswordScreen()),
        );
      },
      child: Text(
        'Next',
         style: AppStyles.buttonText
      ),
    ),
  ),
),


                          
                        

                    // SizedBox(height: 20),
                    // Text(
                    //   'Fv1.0.0',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    
                   

                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'aceventuraservices@gmail.com',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  // Future<void> getVersion(BuildContext _context) async {
  //   print('latest_version11 => ${BaseURl + 'flutter_latest_version'}');

  //   final url = Uri.parse(BaseURl + 'flutter_latest_version'); // Assuming BaseURl is your base URL

  //   try {
  //     final response = await http.post(url);
  //     print('latest_version => ${response.statusCode}');

  //     if (response.statusCode == 200) {
  //       final jsonData = jsonDecode(response.body);
  //       print('latest_version => ${response.body}');

  //       // Check if jsonData is a list and extract the first item if it is
  //       if (jsonData is List && jsonData.isNotEmpty) {
  //         final packageInfo = await PackageInfo.fromPlatform();
  //         print('Current_version => ${packageInfo.version}');

  //         final androidVersion = jsonData[0]['latest_version'] as String; // Ensure this is a String
  //         final releaseNotes = jsonData[0]['release_notes'] as String;
  //         final forcedUpdate = jsonData[0]['forced_update'] as String;

  //         if (androidVersion != null) {
  //           print('Current_version => 22222 ${packageInfo.version}');

  //           final localAndroidVersion = packageInfo.version;

  //           // Compare versions
  //           if (_isVersionGreater(androidVersion, localAndroidVersion)) {
  //             print('Current_version => 3333 ${packageInfo.version}');

  //             if (forcedUpdate == 'N') {
  //               print('Current_version => NNNNN ${packageInfo.version}');

  //               showDialog(
  //                 context: _context,
  //                 builder: (BuildContext context) {
  //                   return AlertDialog(
  //                     title: Text('V ${packageInfo.version}'),
  //                     content: Text(releaseNotes),
  //                     actions: [
  //                       TextButton(
  //                         onPressed: () {
  //                           launchUrl(Uri.parse(
  //                               'https://play.google.com/store/apps/details?id=in.aceventura.evolvuschool'));
  //                         },
  //                         child: Text(
  //                           'Update',
  //                           style: TextStyle(
  //                               color: Colors.green, fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                       TextButton(
  //                         onPressed: () {
  //                           Navigator.of(context).pop();
  //                         },
  //                         child: Text('Cancel'),
  //                       ),
  //                     ],
  //                   );
  //                 },
  //               );
  //             } else if (forcedUpdate == 'Y') {
  //               print('Current_version => 44444 ${packageInfo.version}');

  //               showDialog(
  //                 context: _context,
  //                 builder: (BuildContext context) {
  //                   return AlertDialog(
  //                     title: Text('V ${packageInfo.version}'),
  //                     content: Text(releaseNotes),
  //                     actions: [
  //                       TextButton(
  //                         onPressed: () {
  //                           launchUrl(Uri.parse(
  //                               'https://play.google.com/store/apps/details?id=in.aceventura.evolvuschool'));
  //                         },
  //                         child: Text(
  //                           'Update',
  //                           style: TextStyle(
  //                               color: Colors.green, fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //                 },
  //               );
  //             }
  //           }
  //         }
  //       } else {
  //         print("Unexpected JSON format");
  //       }
  //     } else {
  //       print('Error Response: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }


  }
