import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


import 'dart:async';


class LocationsPage extends StatefulWidget {
  static const routeName = '/Locations';





  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  List<Marker> allMarkers = [];

  String noBrancheList;

  bool loading = false;

  GoogleMapController myMapController;
  static const LatLng _mainLocation = const LatLng(26.8206, 30.8025);

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

  Widget _scrollingList() {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: (this.loading)
          ? Container(
              margin: const EdgeInsets.only(top: 36.0),
              color: Colors.white,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("dddex"),
                        subtitle: Text("Tetst"),
                        onTap: () async {
                          // var locationURL =
                          //     "http://maps.google.com/maps?q=loc:${branchList[index].latitude},${branchList[index].longitude}";
                          // if (await canLaunch(locationURL)) {
                          //   await launch(locationURL);
                          // }
                        },
                        trailing: Image.asset(
                          "resources/icons/ic_arrow_right.png",
                          color: Colors.black87,
                          height: 18.0,
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      )
                    ],
                  );
                },
              ))
          : Center(
              child: Text(
                "error can't loading Branches",
                style: TextStyle(
                    fontSize:20.0 ,
                    color: Colors.black,
                    fontFamily: "avenir_book_01"),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  PanelController _pc = new PanelController();

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return  Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                (this.loading)
                    ? IconButton(
                        padding: EdgeInsets.all(13),
                        icon: RotatedBox(
                            quarterTurns: 0,
                            child: new Image.asset(
                                'resources/images/ic_show_map_list.png',
                                color: Colors.black)),
                        color: Colors.black,
                        onPressed: () {
                          _pc.isPanelOpen() ? _pc.close() : _pc.open();
                        },
                      )
                    : Container(),
              ],
              title: Text(
                "Locations",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: "avenir_book_01"),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
              leading: new IconButton(
                padding: EdgeInsets.all(13.5),
                icon: RotatedBox(
                    quarterTurns: 2,
                    child: new Image.asset('resources/icons/ic_arrow_right.png',
                        color: Colors.black)),
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: Material(
              child: SlidingUpPanel(
                  backdropEnabled: true,
                  borderRadius: radius,
                  isDraggable: true,
                  controller: _pc,
                  maxHeight:  MediaQuery.of(context).size.height * 0.50,
                  minHeight: 50.0,
                  panel: _scrollingList(),
                  collapsed: Container(
                    color: Colors.orangeAccent,
                    child: Center(
                      child: Text(
                        "All Locations",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  body: Center(),
            )) );
  }
}
