import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async { // change to async because we invoke await 

  WidgetsFlutterBinding.ensureInitialized(); // Ensure that Flutter is initialized before calling Firebase
  await Firebase.initializeApp();

  // Initialize Firebase
  logAppOpen(); // This is a custom function to log app open events, you can define it as needed

  runApp(const MyApp());
}

void logAppOpen() {
  // Here you can implement your logic to log the app open event
  // For example, you might want to send an event to Firebase Analytics
  print("App Opened"); // Placeholder for actual logging logic
  // You can replace this with your logging logic, such as Firebase Analytics
  FirebaseAnalytics.instance.logAppOpen();
}

class MyApp extends StatelessWidget {


  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorObservers: <NavigatorObserver>[observer],
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
    Map<String, Object>? eventParams = {
      'counter_value': _counter,
    };

    // Log the increment event to Firebase Analytics
    FirebaseAnalytics.instance.logEvent(
      name: 'increment_counter',
      parameters: eventParams,
    );
    print("Counter incremented to $_counter"); // Optional: Print to console for debugging

  }



  @override
  void initState() {
    super.initState();
    // You can add any initialization logic here if needed
    // For example, you might want to log a screen view event

    
    FirebaseAnalytics.instance.setCurrentScreen(screenName: "Home Screen");
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
