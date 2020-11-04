import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  // MapScreen 화면을 생성하면서 동시에 PlaceLocation을 함께 생성하려면 PlaceLocation의 값은 런타임중에 결코 변하지 않는 일정한 값으로 정해져야 하기 때문에 const 여야 한다.
  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 37.422, longitude: -122.084),
      this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),

              //지도를 클릭하지 않으면(즉 마커가 생기지 않는다면) icon이 활성화 되지 않는다.
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context)
                          .pop(_pickedLocation); // markers 좌표 반환
                    },
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting
            ? _selectLocation
            : null, // 'Select on Map' 버튼을 클릭할 경우에는 initialLocation이 없음
        markers: (_pickedLocation == null && widget.isSelecting)
            ? null
            : {
                Marker(
                  markerId: MarkerId('m1'),

                  // 'Select on Map' 버튼을 클릭할 경우에는 _pickedLocation 값으로 marker의 position 처리,
                  // detail의 경로일 경우는 initialLocation 값으로 marker의 position 처리
                  position: _pickedLocation ??
                      LatLng(
                        widget.initialLocation.latitude,
                        widget.initialLocation.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
