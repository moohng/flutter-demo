import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_demo/pages/CalendarDemo.dart';
import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = <WordPair>[];

  // 极光推送
  String debugLabel = 'Unknown';
  final JPush jpush = new JPush();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    jpush.getRegistrationID().then((rid) {
      setState(() {
        debugLabel = 'flutter getRegistrationID: $rid';
      });
    });

    jpush.setup(
      appKey: '71c7c1c041f7e0f6650db7e2',
      channel: "theChannel",
      production: false,
      debug: true,
    );
    
    try {
      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print('flutter onOpenNotification: $message');
          setState(() {
            debugLabel = 'flutter onOpenNotification: $message';
          });
        },
        onOpenNotification: (Map<String, dynamic> message) async {
          print('flutter onOpenNotification: $message');
          setState(() {
            debugLabel = 'flutter onOpenNotification: $message';
          });
        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          print('flutter onReceiveMessage: $message');
          setState(() {
            debugLabel = 'flutter onReceiveMessage: $message';
          });
        }
      );
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      debugLabel = platformVersion;
    });
  }


  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
          return ListTile(
            title: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        },);

        final List<Widget> divided = ListTile.divideTiles(tiles: tiles, context: context).toList();

//        return new SelectedWords(divided);
        return CalendarDemo();
      }),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RandomWordsState();
  }
}