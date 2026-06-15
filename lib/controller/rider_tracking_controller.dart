import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// Make sure your Tcolor and appBaseUrl are correctly defined/imported
import 'package:vendor/common/color_extension.dart';
import 'package:vendor/common/size.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

enum TrackingState { loading, success, error }

class RiderTrackingController extends GetxController {
  late IO.Socket socket;
  final Rx<TrackingState> trackingState = TrackingState.loading.obs;

  final RxSet<Marker> markers = <Marker>{}.obs;
  final RxSet<Polyline> polylines = <Polyline>{}.obs;
  final Rx<CameraPosition> initialCameraPosition =
      const CameraPosition(target: LatLng(8.4945477, 4.5910293), zoom: 15).obs;

  GoogleMapController? _mapController;
  final List<LatLng> _points = [];

  final RxList<String> placeNames = <String>[].obs;
  final RxBool isFetchingPlaces = false.obs;

  // FIX #1: Using onInit for robust, lifecycle-aware initialization
  @override
  void onInit() {
    super.onInit();
    // Get the orderId passed from the navigation arguments
    final String orderId = Get.arguments as String;
    _startTracking(orderId);
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  // This is now a private method called only by onInit
  void _startTracking(String orderId) {
    trackingState.value = TrackingState.loading;
    _connectAndListen(orderId);
    Timer(const Duration(seconds: 15), () {
      if (trackingState.value == TrackingState.loading) {
        trackingState.value = TrackingState.error;
      }
    });
  }

  void _connectAndListen(String orderId) {
    socket = IO.io(
        appBaseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    // FIX #2: THE RACE CONDITION FIX
    // Register ALL event listeners BEFORE connecting.
    socket.onConnect((_) {
      print('✅ CONTROLLER: Socket connected');
      socket.emit("order:subscribe", {"orderId": orderId});
    });

    socket.on("rider:locationHistory", _onLocationHistory);
    socket.on("rider:locationUpdate", _onLocationUpdate); // Corrected typo
    socket.onDisconnect((_) => print('❌ CONTROLLER: Socket disconnected'));
    socket.onError((data) => print('❌ CONTROLLER: Socket Error: $data'));

    // Connect only AFTER all listeners are ready.
    socket.connect();
  }

  void _onLocationHistory(dynamic data) {
    trackingState.value = TrackingState.success;
    if (data is List && data.isNotEmpty) {
      _points.clear();
      for (var point in data) {
        _points.add(LatLng(point['lat'], point['lng']));
        print("latitude: ${point['lat']}");
        print("longitude: ${point['lng']}");
      }

      // FIX #3: RELIABLE UI UPDATE
      // Reassign the .value of the RxSet to guarantee the UI rebuilds.
      // polylines.value = {
      //   Polyline(
      //       polylineId: const PolylineId("riderPath"),
      //       points: _points,
      //       color: Tcolor.Secondary,
      //       width: 5)
      // };
      _getDirectionsAndDrawRoute();

      if (_points.isNotEmpty) {
        _updateMarker(_points.last);
      }
    }
  }

  void _onLocationUpdate(dynamic data) {
    print("📍📍📍 LIVE UPDATE RECEIVED BY CUSTOMER APP: $data");
    if (data != null && data['lat'] != null && data['lng'] != null) {
      final newPoint = LatLng(data['lat'], data['lng']);
      _points.add(newPoint);

      _getDirectionsAndDrawRoute();
      _updateMarker(newPoint);

      // _updatePolylines();

      _mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: newPoint, zoom: 16.5)));
    }
  }

  String _formatPlacemark(Placemark p) {
    final street =
        (p.street != null && !p.street!.contains('+')) ? p.street : null;
    final subLocality = (p.subLocality != null && !p.subLocality!.contains('+'))
        ? p.subLocality
        : null;
    final locality =
        (p.locality != null && !p.locality!.contains('+')) ? p.locality : null;

    List<String> addressParts = [];

    if (street != null && street.isNotEmpty) {
      addressParts.add(street);
    }
    if (subLocality != null && subLocality.isNotEmpty) {
      addressParts.add(subLocality);
    }
    if (locality != null && locality.isNotEmpty) {
      addressParts.add(locality);
    }
    if (addressParts.isEmpty) {
      return p.administrativeArea ?? "Unamed Road";
    }
    return addressParts.join(', ');
  }

  void _getDirectionsAndDrawRoute() async {
    if (_points.length < 2) {
      return;
    }
    PolylinePoints polylinePoints = PolylinePoints(apiKey: googleApiKey);
    List<LatLng> polylineCoordinate = [];

    // definng the origin
    PointLatLng origin =
        PointLatLng(_points.first.latitude, _points.first.longitude);
    PointLatLng destinaton =
        PointLatLng(_points.last.latitude, _points.last.longitude);

    // defining te waypoints(i.e all the points between the first and the last)
    List<PolylineWayPoint> waypoints = [];
    if (_points.length > 2) {
      waypoints = _points
          .sublist(1, _points.length - 1)
          .map((point) => PolylineWayPoint(
              location: '${point.latitude},${point.longitude}'))
          .toList();
    }
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        request: PolylineRequest(
            origin: origin,
            destination: destinaton,
            mode: TravelMode.driving,
            wayPoints: waypoints),
        // googleApiKey: googleApiKey
      );
      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polylineCoordinate.add(LatLng(point.latitude, point.longitude));
        }
      } else {
        print("Directions API Error: ${result.errorMessage}");
        // As a fallback, you could draw a straight line here if directions fail
        // polylineCoordinates = List.from(_points);
      }
    } catch (e) {
      print("Error fetching directions: $e");
    }
    polylines.value = {
      Polyline(
          polylineId: const PolylineId("direction_route"),
          points: polylineCoordinate,
          color: Colors.deepPurpleAccent,
          width: 6)
    };
  }

  Future<void> fetchPlacesNames() async {
    if (isFetchingPlaces.value) return;

    if (_points.isEmpty) {
      placeNames.clear();
      Fluttertoast.showToast(msg: "Rider as not moved yet");
      return;
    }

    isFetchingPlaces.value = true;
    placeNames.clear();

    String lastDistinctPlace = "";

    for (final point in _points) {
      try {
        List<Placemark> placemarks =
            await placemarkFromCoordinates(point.latitude, point.longitude);
        if (placemarks.isNotEmpty) {
          final p = placemarks.first;
          final String currentPlace = _formatPlacemark(p);
          if (currentPlace.isNotEmpty && currentPlace != lastDistinctPlace) {
            placeNames.add(currentPlace);
          }
        }
      } catch (e) {
        print("Error during reverse geocoding for point $point: $e");
      }
    }
    isFetchingPlaces.value = false;
  }

  void _updateMarker(LatLng position) {
    // Also use reliable reassignment here
    markers.value = {
      Marker(
          markerId: const MarkerId("rider_marker"),
          position: position,
          infoWindow: const InfoWindow(title: "Rider"),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure))
    };
  }

  void _updatePolylines() {
    polylines.value = {
      Polyline(
          polylineId: const PolylineId('riderPath'),
          points: List.from(_points),
          color: Tcolor.SECONDARY_S3,
          width: 5)
    };
  }

  @override
  void onClose() {
    print('CONTROLLER: Closing. Disconnecting socket.');
    socket.disconnect();
    _mapController?.dispose();
    super.onClose();
  }
}
