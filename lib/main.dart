import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position _currentPosition;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  String _currrentAdress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Get location'),
              onPressed: () => _getCurrentLocation(),
            ),
            Text(_currrentAdress ?? 'hola'),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((position) {
      setState(() {
        _currentPosition = position;
      });
      _getUserCountry();
    });
  }

  _getUserCountry() async {
    List<Placemark> placemarks =
        await geolocator.placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);
    Placemark country = placemarks[0];

    print(placemarks.length);

    setState(() {
      _currrentAdress = country.isoCountryCode;
    });
  }
}
