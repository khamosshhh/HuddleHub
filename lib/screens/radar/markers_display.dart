import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'location.dart';
import 'marker.dart';

class MarkersDisplay extends StatefulWidget {
  final double size;
  final double zoomLevel;

  const MarkersDisplay({
    Key? key,
    required this.size,
    required this.zoomLevel,
  }) : super(key: key);

  @override
  State<MarkersDisplay> createState() => _MarkersDisplayState();
}

class _MarkersDisplayState extends State<MarkersDisplay>
    with SingleTickerProviderStateMixin {
  final List<Marker> _markers = [];

  Marker _myLocation = Marker(latitude: 0, longitude: 0);

  AnimationController? _animationController;

  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();

    _updateMyLocation();

    // Fetch location data from Firestore and update markers list
    FirebaseFirestore.instance
        .collection('locations')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        final marker = Marker(
          latitude: doc['latitude'],
          longitude: doc['longitude'],
        );
        setState(() {
          _markers.add(marker);
        });
      }
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationController?.repeat(reverse: true);
    _animation = Tween(begin: 2.0, end: 10.0).animate(_animationController!)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  // Fetch Live Location of the User
  Future<Position> _updateMyLocation() async {
    // Request permission to access the device's location
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permission denied');
    }
    var location;
    final positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 10,
      ),
    );
    await for (final position in positionStream) {
      print(position);
      setState(() {
        // Update the Location in Database
        location = LocationDB(
          latitude: position.latitude,
          longitude: position.longitude,
        );
        print(location);
        storeLocation(location);

        // Update the Location in Map
        _myLocation = Marker(
          latitude: position.latitude,
          longitude: position.longitude,
        );
        print(_myLocation);
      });
    }

    return location;
  }

  _getMarkers() {
    return List<Widget>.from(
      _markers.map((marker) {
        final diffLat = marker.latitude - _myLocation.latitude;
        final diffLng = marker.longitude - _myLocation.longitude;

        final ratio = widget.size / widget.zoomLevel;
        final top = diffLat * ratio + widget.size / 2;
        final left = diffLng * ratio + widget.size / 2;

        return Positioned(
          left: left,
          top: top,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: _animation?.value ?? 0,
                  spreadRadius: _animation?.value ?? 0,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _getMarkers(),
    );
  }
}
