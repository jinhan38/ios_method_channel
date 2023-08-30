import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform = MethodChannel('iosMethodChannel');
  String value = "no data";
  int count = 0;

  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler(nativeMethodCallHandler);
  }

  Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
    switch (methodCall.method) {
      case "countMethod":
        count = methodCall.arguments as int;
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 26),
            ),
            Text(
              "count : $count",
              style: const TextStyle(fontSize: 26),
            ),
            ElevatedButton(
              onPressed: _callMethodChannel,
              child: const Text('Talk'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _callMethodChannel() async {
    value = await platform.invokeMethod('talk');
    setState(() {});
  }
}
