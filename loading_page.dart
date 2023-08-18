// import 'package:flutter/material.dart';
// import 'main.dart'; // Import your main.dart
//
// class LoadingPage extends StatefulWidget {
//
//   @override
//   _LoadingPageState createState() => _LoadingPageState();
// }
//
// class _LoadingPageState extends State<LoadingPage> {
//   @override
//   void initState() {
//     super.initState();
//     _simulateLoading(); // Simulate loading before navigating to the main page
//   }
//
//   void _simulateLoading() async {
//     // Simulate loading time (you can adjust the duration)
//     await Future.delayed(Duration(seconds: 2));
//
//     // Navigate to the main page using Navigator.pushReplacement
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => MyHomePage()),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Image.asset('assets/loading_image.png'),
//             CircularProgressIndicator(),
//             SizedBox(height: 20),
//             Text('Loading...'),
//           ],
//         ),
//       ),
//     );
//   }
// }
