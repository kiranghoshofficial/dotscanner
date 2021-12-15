import 'package:flutter/material.dart';
import 'app_list.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/image3.jpg',
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50.0),
                ),
                MaterialButton(
                  onPressed: () {},
                  minWidth: 360.0,
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    "Check Your Mobile Status",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 110.0),
                ),
                Image.asset(
                  'assets/images/DOT.png',
                  width: 300.0,
                  height: 400.0,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 100.0),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<Object>(
                          builder: (BuildContext context) => AppsListScreen()),
                    );
                  },
                  minWidth: 280.0,
                  splashColor: Colors.green[800],
                  color: Colors.deepPurpleAccent,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    "SCAN",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
