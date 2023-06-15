import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safeguard_group3_project/widget/appbar_widget.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  List<Marker> markers = [];
  MapController mapController = MapController();
  LatLng? currentLocation;
  //final curr_user = FirebaseAuth.instance.currentUser!;
  //final curr_user_id = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _loadMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: buildAppBar(context, "Map Page"),
          body: Column(
            children: [
              Expanded(
                flex: 5,
                child: currentLocation == null
                    ? Center(child: CircularProgressIndicator())
                    : FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                          center: currentLocation,
                          zoom: 13.0,
                          onTap: _handleTap,
                        ),
                        layers: [
                          TileLayerOptions(
                            urlTemplate:
                                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c'],
                          ),
                          MarkerLayerOptions(markers: markers),
                        ],
                      ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('reports')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot report = snapshot.data!.docs[index];
                          GeoPoint location = report['location'];
                          return ListTile(
                            title: Text(report['report']),
                            subtitle: Text("User Reported:"
                                '${report['user']}'),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('reports')
                                    .doc(report.id)
                                    .delete();
                                _loadMarkers(); // Refresh markers after deletion
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 90.0, // adjust this as needed
          right: 15.0, // adjust this as needed
          child: FloatingActionButton(
            onPressed: () async {
              Position position = await Geolocator.getCurrentPosition();
              mapController.move(
                  LatLng(position.latitude, position.longitude), 13.0);
            },
            child: Icon(Icons.my_location),
          ),
        ),
      ],
    );
  }

  void _handleTap(LatLng latLng) {
    showDialog(
      context: context,
      builder: (context) {
        String report = '';
        return AlertDialog(
          title: Text('Report'),
          content: TextField(
            onChanged: (value) {
              report = value;
            },
            decoration: InputDecoration(hintText: "Enter your report"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () async {
                // Save the report to Firebase here
                await FirebaseFirestore.instance.collection('reports').add({
                  'user': "Victor", //curr_user
                  'report': report,
                  'location': GeoPoint(latLng.latitude, latLng.longitude)
                });
                // Add a new marker to the map
                setState(() {
                  markers.add(
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: latLng,
                      builder: (ctx) => Container(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _loadMarkers() async {
    // Fetch the reports from Firestore
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('reports').get();
    // Create a new list of markers
    List<Marker> newMarkers = [];
    // Iterate through the reports
    for (var report in querySnapshot.docs) {
      // Get the location of the report
      GeoPoint location = report['location'];

      // Create a new marker
      Marker marker = Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(location.latitude, location.longitude),
        builder: (ctx) => Container(
          child: Icon(
            Icons.location_on,
            color: Colors.red,
          ),
        ),
      );
      // Add the marker to the list
      newMarkers.add(marker);
    }
    // Update the state to include the new markers
    setState(() {
      markers = newMarkers;
    });
  }
}
