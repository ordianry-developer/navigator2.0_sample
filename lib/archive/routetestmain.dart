import 'package:flutter/material.dart';


void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        '/second_page': (BuildContext context) => SecondPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('HomePage'),
            // Press this button to open the SecondPage.
            ElevatedButton(
              child: Text('Second Page >'),
              onPressed: () {
                Navigator.pushNamed(context, '/second_page');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  bool _showRectangle = false;

  void _navigateLocallyToShowRectangle() async {
    // This local history entry essentially represents the display of the red
    // rectangle. When this local history entry is removed, we hide the red
    // rectangle.
    setState(() => _showRectangle = true);
    ModalRoute.of(context)?.addLocalHistoryEntry(
        LocalHistoryEntry(
            onRemove: () {
              // Hide the red rectangle.
              setState(() => _showRectangle = false);
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final localNavContent = _showRectangle
      ? Container(
          width: 100.0,
          height: 100.0,
          color: Colors.red,
        )
      : ElevatedButton(
          child: Text('Show Rectangle'),
          onPressed: _navigateLocallyToShowRectangle,
        );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            localNavContent,
            ElevatedButton(
              child: Text('< Back'),
              onPressed: () {
                // Pop a route. If this is pressed while the red rectangle is
                // visible then it will will pop our local history entry, which
                // will hide the red rectangle. Otherwise, the SecondPage will
                // navigate back to the HomePage.
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}