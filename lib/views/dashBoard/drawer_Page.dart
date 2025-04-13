
import 'package:flutter/material.dart';
import 'package:teacherapp/views/auth/password_screen.dart';
class CardItem {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  CardItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onTap,
  });
}

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<CardItem> cardItems = [

    //   CardItem(
    //     imagePath:'assets/parents.png',
    //     title: 'My Profile',
    //     onTap: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (_) => rParentProfilePage()),
    //       );
    //     },
    //   ),

    //   CardItem(
    //     imagePath: 'assets/logout1.png',
    //     title: 'LogOut',
    //     onTap: () {
    //      // showLogoutConfirmationDialog(context);
    //     },
    //   ),

      CardItem(
        imagePath: 'assets/logo.png',
        title: 'Change Password',
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (BuildContext context) {  LoginScreen}
          //     // builder: (context) => DrawerOnlineFeesPayment(
          //     //     regId: reg_id,paymentUrlShare:paymentUrlShare,receiptUrl:receiptUrl,shortName: shortName,academicYr: academic_yr, receipt_button: receipt_button,),
          //   ),
          // );
            Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PasswordScreen()),
        );
        },
      ),
      CardItem(
        imagePath: 'assets/logo.png',
        title: 'About Us',
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (BuildContext context) {  LoginScreen}
          //     // builder: (context) => DrawerOnlineFeesPayment(
          //     //     regId: reg_id,paymentUrlShare:paymentUrlShare,receiptUrl:receiptUrl,shortName: shortName,academicYr: academic_yr, receipt_button: receipt_button,),
          //   ),
          // );
            Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PasswordScreen()),
        );
        },
      ),
    //   CardItem(
    //     imagePath: 'assets/password.png',
    //     title: 'Change Password',
    //     onTap: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (_) => ChangePasswordPage(academicYear:academic_yr,shortName: shortName, userID: user_id, url: url,)),
    //       );
    //     },
    //   ),



    //   CardItem(
    //     imagePath: 'assets/almanac.png',
    //     title: 'Change Academic Year',
    //     onTap: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (_) => ChangeAcademicYearScreen(academic_yr:academic_yr,shortName: shortName)),
    //       );
    //     },
    //   ),


    //   // Add the new Share App card here
    //   CardItem(
    //     imagePath: 'assets/share.png', // Add an appropriate icon for sharing
    //     title: 'Share App',
    //     onTap: () {
    //       Share.share(
    //         'Download Evolvu: Smart Schooling App https://play.google.com/store/apps/details?id=in.aceventura.evolvuschool', // Replace with your app link
    //         subject: 'Parent App!',
    //       );
    //     },
    //   ),

    //   CardItem(
    //     imagePath: 'assets/ace.png',
    //     title: 'About Us',
    //     onTap: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (_) => AboutUsPage(academic_yr:academic_yr,shortName: shortName)),
    //       );
    //     },
    //   ),

    //   CardItem(
    //     imagePath: 'assets/ace.png',
    //     title: 'ID Card',
    //     onTap: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (_) => AboutUsPage(academic_yr:academic_yr,shortName: shortName)),
    //       );
    //     },
    //   ),
    //   // Add more CardItems here...
    // ];
    ];
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.only(top: 65, bottom: 0, left: 0, right: 0),
      child: Stack(
        clipBehavior: Clip.none,
        // This allows the Positioned widget to go outside the Stack's bounds
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 245, 241, 241),
                borderRadius: BorderRadius.circular(8),
              ),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: cardItems.map((cardItem) {
                  return InkWell(
                    onTap: cardItem.onTap,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(cardItem.imagePath, width: 40, height: 40),
                        SizedBox(height: 8),
                        Text(
                          cardItem.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Positioned(
            top: -50, // Adjust this value to place the button above the dialog
            right: 30,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(Icons.close, color: Colors.black, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}