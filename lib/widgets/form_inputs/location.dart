import 'package:curso_udemy/models/product.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:curso_udemy/models/location_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LocationInput extends StatefulWidget {
  final Function setLocation;
  final Product product;

  const LocationInput(this.setLocation, this.product);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  final FocusNode _addressInputFocusNode = FocusNode();
  GoogleMapController _controller;
  TextEditingController _fieldController = TextEditingController();
  LatLng _cameraPos = LatLng(37.42796133480664, -122.085749655962);
  Set<Marker> _markers;
  LocationData _locationData;

  @override
  void initState() {
    super.initState();
    _addressInputFocusNode.addListener(_updateLocation);
    if (widget.product != null) {
      _fieldController.text = widget.product.location.address;
      _updateLocation(true);
    }
  }

  @override
  void dispose() {
    _addressInputFocusNode.removeListener(_updateLocation);
    super.dispose();
  }

  void _updateLocation([geocode = false]) async {
    final String address = _fieldController.text.trim();
    var coords;
    var formatedAddress;
    if (!_addressInputFocusNode.hasFocus) {
      if (address.isEmpty) {
        widget.setLocation(null);
        return;
      }
      if (!geocode) {
        final Uri url = Uri.https(
          'maps.googleapis.com',
          '/maps/api/geocode/json',
          {
            'address': address,
            'key': 'AIzaSyCo3g7ATyPNuloj6HW5JQdHIVeQDaelYms'
          });
        final response = await http.get(url);
        final decodedResp = json.decode(response.body);
        formatedAddress = decodedResp['results'][0]['formatted_address'];
        coords = decodedResp['results'][0]['geometry']['location'];
      } else {
        formatedAddress = widget.product.location.address;
        coords = {'lat': widget.product.location.latitude, 'lng': widget.product.location.longitude};
      }
      _locationData = LocationData(
        address: formatedAddress, 
        latitude: coords['lat'],
        longitude: coords['lng'],  
      );
      final LatLng newPos = LatLng(_locationData.latitude, _locationData.longitude);
      setState(() {
        _markers = {Marker(
          markerId: MarkerId('addressMarker'),
          position: newPos
        )};
        _cameraPos = newPos;
        _fieldController.text = _locationData.address; 
      });
      widget.setLocation(_locationData);
      if (_controller != null) {
        _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          zoom: 16.4746,
          target: newPos,
        )));
      } 
    }
  }

  Widget mapContent() {
    if (_fieldController.text.isNotEmpty && _fieldController.text != null) {
      return GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _cameraPos,
          zoom: 16.4746
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        onCameraMove: (CameraPosition position) {
          setState(() {
            _cameraPos = position.target;
          });
        },
      );
    }
    return SizedBox(height: 10, width: 10,);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        TextFormField(
          focusNode: _addressInputFocusNode,
          controller: _fieldController,
          autovalidate: true,
          validator: (String value) {
            if (_locationData == null || value.isEmpty) return 'No valid location found';
            return null;
          },
          decoration: InputDecoration(
            labelText: 'Address',
            icon: Icon(Icons.location_on),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.95,
          child: mapContent(),
        ),
      ],
    );
  }

}