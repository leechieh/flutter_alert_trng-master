import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:native_dialog/native_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController _textEditingController;
  String _message = 'Hello World!';
  bool _confirmed = false;

  @override
  void initState() {
    _textEditingController = TextEditingController(text: _message);
    super.initState();
  }

  void _handleMessage(String value) {
    _message = value;
  }

  Future<void> _alert() async {
    await NativeDialog.alert(_message);
  }

  Future<void> _confirm() async {
    _confirmed = await NativeDialog.confirm(_message);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dialog Demo'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                    labelText: 'Message', hintText: 'Enter message here'),
                autofocus: true,
                textAlign: TextAlign.center,
                onChanged: _handleMessage,
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: _message.isNotEmpty ? _alert : null,
                        child: Text('Alert'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: _message.isNotEmpty ? _confirm : null,
                child: Text('Confirm'),
              ),
            ),
            Text(_confirmed ? 'Confirmed' : 'Unconfirmed'),
          ],
        ),
      ),
    );
  }
}
