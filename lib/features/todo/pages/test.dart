import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:tasktrek/common/widgets/appstyle.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocationList extends StatefulWidget {
  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  List<String> locationNames = [];
   String timezone="";

  @override
  void initState() {
    super.initState();
    _getTimezoneNames();
    _getCurrentTimezone();
  }

  void _getTimezoneNames() {
    tz.initializeTimeZones();
    var locations = tz.timeZoneDatabase.locations;
    setState(() {
      locationNames = locations.keys.toList();
    });
  }
  Future<void> _getCurrentTimezone() async {
   timezone = await FlutterNativeTimezone.getLocalTimezone();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Names'),
      ),
      body: Column(
        children: [
         Text(timezone,style: appstyle(20, Colors.white, FontWeight.w600),),
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView.builder(
              itemCount: locationNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(locationNames[index],style: appstyle(15, Colors.white, FontWeight.w600),),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}