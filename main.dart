import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<void> _initialization;

  MyApp() : _initialization = _initializeApp();

  static Future<void> _initializeApp() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SCRC Announcements',
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MyHomePage();
          } else {
            return Scaffold(
              body: Center(
                child: Image.asset('assets/loading_image.png'),
              ),
            );
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  SharedPreferences? _prefs;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences? _prefs;
  String _currentButtonType = 'TXT'; // Initialize with 'TXT'

  TextEditingController _textEditingController = TextEditingController();
  List<String> _suggestions = [
    'Attention, We have visitors for our lab',
    'Kindly Join the meeting soon',
    'I need everyone in my room right now',
    'Report to LAB1 within the next 5 minutes',
    'Meet in LAB1 within the next 5 minutes'
  ];
  List<String> _recentTexts = [];

  void initState() {
    super.initState();
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadRecentTexts();
  }

  void _loadRecentTexts() {
    setState(() {
      _recentTexts = _prefs?.getStringList('recentTexts') ?? [];
    });
  }

  Future<void> _sendTextAndData(String data) async {
    final Uri uri = Uri.parse('http://192.168.164.8:8100/');//https://jsonplaceholder.typicode.com/posts

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: '{"data": "$data", "type": "$_currentButtonType"}',
      );

      if (response.statusCode == 200) {
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
      _recentTexts.remove(enteredText);
      _recentTexts.insert(0, enteredText);

      if (_recentTexts.length > 5) {
        _recentTexts.removeLast();
      }

      if (_prefs != null) {
        _prefs?.setStringList('recentTexts', _recentTexts);
      }

      _sendTextAndData(enteredText);
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
        'I need everyone in my room right now',
        'Report to LAB1 within the next 5 minutes',
        'Meet in LAB1 within the next 5 minutes'
      ];
      _currentButtonType = 'TXT'; // Set to 'TXT' for Announce
    });
  }

  void _setCommandSuggestions() {
    setState(() {
      _suggestions = ['aq', 'srEM', 'wd', 'wf', 'wn'];
      _currentButtonType = 'CMD'; // Set to 'CMD' for Command
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
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
                  onPressed: () => _setAnnounceSuggestions(),
                  child: Text('Announce'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => _setCommandSuggestions(),
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
                  onPressed: () => _sendText(),
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
            // Wrap the ListView.builder with a Container and set the height
            Container(
              height: 300, // Change this value to adjust the height of the ListView
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
