import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers = Set<Marker>();
  Set<Circle> circles = Set<Circle>();
  Set<Polyline> polylines = Set<Polyline>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: [
          IconButton(
            onPressed: () async{
              PermissionStatus status = await Permission.location.request();
              if(status.isGranted){
                print('Location permission granted');
              }
            },
            icon: Icon(Icons.location_on),
          ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        compassEnabled: true,
        onTap: (LatLng latlng){
          _controller.future.then(
                  (value) {
                    value.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(target: latlng,zoom: 17),
                      ),
                    );
                    String markerName = 'marker_${markers.length}';
                    Marker marker = Marker(
                      markerId: MarkerId(markerName),
                      position: latlng,
                      infoWindow: InfoWindow(title: markerName),
                    );
                    setState(() => markers.add(marker));
                  }
          );
          String markerName = 'marker_${markers.length}';
          Marker marker = Marker(
              markerId: MarkerId(markerName),
            position: latlng,
            infoWindow: InfoWindow(title: markerName),
          );
          setState(() => markers.add(marker));
        },
        markers: markers,
        zoomGesturesEnabled: false,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onLongPress: (LatLng latLng){
        //   String circleId = 'circles_${circles.length}';
        //   Circle circle = Circle(
        //     circleId: CircleId(circleId),
        //     center: latLng,
        //     fillColor: Colors.red.shade200,
        //     strokeColor: Colors.red.shade700,
        //     radius: 30,
        //     strokeWidth: 2,
        //   );
        //   setState(() => circles.add(circle));
          String polylineId = 'polyline_${polylines.length}';
          Polyline polyline = Polyline(
            polylineId: PolylineId(polylineId),
            width: 1,
            color: Colors.blue,
            // jointType: JointType.bevel,
            startCap: Cap.roundCap,
            endCap: Cap.roundCap,
            points: [
              LatLng(31.513244, 34.427285),
              LatLng(31.514219, 34.425920),
              LatLng(31.511773, 34.423380),
              LatLng(31.510167, 34.421877),
              LatLng(31.505863, 34.417706),
            ],
          );
          setState(() => polylines.add(polyline));
        },
        circles: circles,
        polylines: polylines,
        buildingsEnabled: true,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(31.512871, 34.427866),
          zoom: 16.0,
        ),
      ),
    );
  }
}




