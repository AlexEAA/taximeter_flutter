import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taximeter/models/app_state.dart';

class MapOrdersScreen extends StatefulWidget {
  @override
  _MapOrdersScreenState createState() => _MapOrdersScreenState();
}

class _MapOrdersScreenState extends State<MapOrdersScreen> {
  GoogleMapController _controller;


  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height - 50.0,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(appState.locationData.latitude, appState.locationData.longitude), zoom: 16.0),
            onMapCreated: mapCreated,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,

            gestureRecognizers: Set()
              ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
              ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
              ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
              ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
            mapToolbarEnabled: true,
            compassEnabled: true,
          ),
        )
      ],
    );
  }

  void mapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
    });
  }
}
