import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:valu/bloc/locations/locations_bloc.dart';
import 'package:valu/bloc/locations/locations_event.dart';
import 'package:valu/bloc/locations/locations_state.dart';
import 'dart:async';

import 'package:valu/models/valu_models/navigation_arguments.dart';
import 'package:valu/repositories/repositories.dart';
import 'package:valu/widgets/navigation/valu_app_bar_widget.dart';

class LocationsPage extends StatefulWidget {
  static const routeName = '/Locations';

  final ValuRepository valuRepository;

  LocationsPage({Key key, @required this.valuRepository})
      : assert(valuRepository != null),
        super(key: key);

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  List<Marker> allMarkers = [];

  LocationsBloc _locationsBloc;
  GoogleMapController myMapController;
  static const LatLng _mainLocation = const LatLng(26.8206, 30.8025);
  Completer<GoogleMapController> _controller = Completer();

  LatLngBounds getLatLngBoundsForMarkers(List<Marker> markers) {
    var northEast =
        new LatLng(markers[0].position.latitude, markers[0].position.longitude);
    var southWest =
        new LatLng(markers[0].position.latitude, markers[0].position.longitude);

    markers.forEach((marker) {
      if (marker.position.latitude > northEast.latitude) {
        northEast = LatLng(marker.position.latitude, northEast.longitude);
      }
      if (marker.position.longitude > northEast.longitude) {
        northEast = LatLng(northEast.latitude, marker.position.longitude);
      }

      if (marker.position.latitude < southWest.latitude) {
        southWest = LatLng(marker.position.latitude, southWest.longitude);
      }
      if (marker.position.longitude < southWest.longitude) {
        southWest = LatLng(southWest.latitude, marker.position.longitude);
      }
    });

    return LatLngBounds(northeast: northEast, southwest: southWest);
  }

  @override
  void initState() {
    super.initState();
    _locationsBloc = LocationsBloc(valuRepository: widget.valuRepository);
    _locationsBloc.dispatch(SubmitLocations());
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    myMapController.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90)
      check(u, c);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ValuAppBarWidget(
            showLogo: false,
            barTitle: "Locations",
            showSideMenu: false,
            showBackButton: true,
            drawerToggle: () => Navigator.of(context).pop()).build(context),
        body: BlocBuilder(
          bloc: _locationsBloc,
          builder: (BuildContext context, LocationsState state) {
            if (state is IntializeLocationsState ||
                state is LoadingLocationsState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SuccessLocationsState) {
              var markersList = state.response.boothList.map((booth) {
                return Marker(
                  markerId: MarkerId(booth.id.toString()),
                  draggable: true,
                  onTap: () async {
                    var locationURL =
                        "http://maps.google.com/maps?q=loc:${booth.latitude},${booth.longitude}";
                    if (await canLaunch(locationURL)) {
                      await launch(locationURL);
                    }
                  },
                  position: LatLng(double.parse(booth.latitude),
                      double.parse(booth.longitude)),
                  flat: false,
                  anchor: Offset(0.5, 0.5),
                  icon: BitmapDescriptor.fromAsset(
                      'resources/images/ic_booth_marker.png'),
                );
              }).toList();
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _mainLocation,
                        zoom: 7.0,
                      ),
                      mapType: MapType.normal,
                      onMapCreated: (controller) {
                        setState(() {
                          myMapController = controller;
                        });
                        new Future.delayed(Duration(milliseconds: 500), () {
                          var latlngBounds =
                              getLatLngBoundsForMarkers(markersList);
                          CameraUpdate u2 =
                              CameraUpdate.newLatLngBounds(latlngBounds, 50);
                          myMapController.animateCamera(u2).then((void v) {
                            check(u2, this.myMapController);
                          });
                        });
                      },
                      markers: Set.from(markersList),
                    ),
                  ),
                ],
              );
            } else if (state is ErrorLocationsState) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
          },
        ));
  }
}

/*newLatLngBounds */
