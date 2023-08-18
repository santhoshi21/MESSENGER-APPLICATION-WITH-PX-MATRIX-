// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'loading_page.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SCRC Announcements',
//       home: LoadingPage(), // Start with the loading page
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   TextEditingController _textEditingController = TextEditingController();
//   List<String> _suggestions = [
//     'Attention, We have visitors for our lab',
//     'Kindly Join the meeting soon',
//     'Scroll activity test'
//   ];
//   List<String> _recentTexts = [];
//
//   Future<void> _sendTextAndData(String data) async {
//     final Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');//https://jsonplaceholder.typicode.com/posts //http://10.2.132.119:8100
//
//     try {
//       // http.Client client = http.Client();
//       // client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//
//       final response = await http.post(
//         uri,
//         headers: {'Content-Type': 'application/json'},
//         body: '{"data": "$data"}',
//       );
//
//       if (response.statusCode == 200) {
//         // Data sent successfully
//         print('Data sent successfully');
//       } else {
//         print('Failed to send data. Status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error sending data: $e');
//     }
//   }
//
//   void _sendText() {
//     final enteredText = _textEditingController.text;
//     if (enteredText.isNotEmpty) {
//       _recentTexts.insert(0, enteredText);
//       _sendTextAndData(enteredText);
//     }
//     print("Entered text: $enteredText");
//     _textEditingController.clear();
//   }
//
//   void _selectSuggestion(String suggestion) {
//     setState(() {
//       _textEditingController.text = suggestion;
//     });
//   }
//
//   void _insertRecentText(String recentText) {
//     setState(() {
//       _textEditingController.text = recentText;
//     });
//   }
//
//   void _setAnnounceSuggestions() {
//     setState(() {
//       _suggestions = [
//         'Attention, We have visitors for our lab',
//         'Kindly Join the meeting soon',
//         'Scroll activity test'
//       ];
//     });
//   }
//
//   void _setCommandSuggestions() {
//     setState(() {
//       _suggestions = ['Execute command 1', 'Execute command 2', 'Execute command 3'];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.primary, // Use primary color
//         title: Text('SCRC Announcements'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//
//               children: [
//                 SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: _setAnnounceSuggestions,
//                   child: Text('Announce'),
//                 ),
//                 SizedBox(width: 16),
//                 ElevatedButton(
//                   onPressed: _setCommandSuggestions,
//                   child: Text('Command'),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _textEditingController,
//                     onChanged: (value) {
//                       setState(() {
//                         // You can add any custom logic here if needed
//                       });
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Type here...',
//                       labelText: 'Input Text',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: _sendText,
//                   icon: Icon(Icons.send),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     showModalBottomSheet(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return RecentTextList(
//                             recentTexts: _recentTexts, onSelect: _insertRecentText);
//                       },
//                     );
//                   },
//                   icon: Icon(Icons.add),
//                 ),
//               ],
//             ),
//             Container(
//               height: 150,
//               child: ListView.builder(
//                 itemCount: _suggestions.length,
//                 itemBuilder: (context, index) {
//                   final suggestion = _suggestions[index];
//                   return GestureDetector(
//                     onTap: () {
//                       _selectSuggestion(suggestion);
//                     },
//                     child: Container(
//                       margin: EdgeInsets.symmetric(vertical: 8),
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(color: Colors.lightBlueAccent),
//                       ),
//                       child: Text(
//                         suggestion,
//                         style: TextStyle(
//                           color: Colors.lightBlueAccent,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//       // No FloatingActionButton here
//     );
//   }
// }
//
// class RecentTextList extends StatelessWidget {
//   final List<String> recentTexts;
//   final Function(String) onSelect;
//
//   RecentTextList({required this.recentTexts, required this.onSelect});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         ListTile(
//           title: Text(
//             'Recent Texts',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//         Divider(),
//         ListView.builder(
//           shrinkWrap: true,
//           itemCount: recentTexts.length,
//           itemBuilder: (context, index) {
//             final recentText = recentTexts[index];
//             return ListTile(
//               title: Text(recentText),
//               onTap: () {
//                 onSelect(recentText);
//                 Navigator.pop(context);
//               },
//             );
//           },
//         ),
//       ],
//     );
//   }
// }












import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SCRC Announcements',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textEditingController = TextEditingController();
  List<String> _suggestions = [
    'Attention, We have visitors for our lab',
    'Kindly Join the meeting soon',
    'Scroll activity test'
  ];
  List<String> _recentTexts = [];

  Future<void> _sendTextAndData(String data) async {
    final Uri uri = Uri.parse('http://10.2.132.119:8100/');

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: '{"data": "$data"}',
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('Data sent successfully');
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error sending data: $e');
    }
  }

  void _sendText() {
    final enteredText = _textEditingController.text;
    if (enteredText.isNotEmpty) {
      _recentTexts.insert(0, enteredText);
      _sendTextAndData(enteredText); // Send the enteredText to the API
    }
    print("Entered text: $enteredText");
    _textEditingController.clear();
  }

  void _selectSuggestion(String suggestion) {
    setState(() {
      _textEditingController.text = suggestion;
    });
  }

  void _insertRecentText(String recentText) {
    setState(() {
      _textEditingController.text = recentText;
    });
  }

  void _setAnnounceSuggestions() {
    setState(() {
      _suggestions = [
        'Attention, We have visitors for our lab',
        'Kindly Join the meeting soon',
        'Scroll activity test'
      ];
    });
  }

  void _setCommandSuggestions() {
    setState(() {
      _suggestions = ['Execute command 1', 'Execute command 2', 'Execute command 3'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary, // Use primary color
        title: Text('SCRC Announcements'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _setAnnounceSuggestions,
                  child: Text('Announce'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _setCommandSuggestions,
                  child: Text('Command'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    onChanged: (value) {
                      setState(() {
                        // You can add any custom logic here if needed
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Type here...',
                      labelText: 'Input Text',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendText,
                  icon: Icon(Icons.send),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return RecentTextList(
                            recentTexts: _recentTexts, onSelect: _insertRecentText);
                      },
                    );
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            Container(
              height: 150,
              child: ListView.builder(
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = _suggestions[index];
                  return GestureDetector(
                    onTap: () {
                      _selectSuggestion(suggestion);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.lightBlueAccent),
                      ),
                      child: Text(
                        suggestion,
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      // No FloatingActionButton here
    );
  }
}

class RecentTextList extends StatelessWidget {
  final List<String> recentTexts;
  final Function(String) onSelect;

  RecentTextList({required this.recentTexts, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            'Recent Texts',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Divider(),
        ListView.builder(
          shrinkWrap: true,
          itemCount: recentTexts.length,
          itemBuilder: (context, index) {
            final recentText = recentTexts[index];
            return ListTile(
              title: Text(recentText),
              onTap: () {
                onSelect(recentText);
                Navigator.pop(context);
              },
            );
          },
        ),
      ],
    );
  }
}
