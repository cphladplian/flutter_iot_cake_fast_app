import 'package:flutter/material.dart';
import 'package:flutter_iot_cake_fast_app/models/cake_shop.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

class CakeShopDetailUi extends StatefulWidget {
  CakeShop? cakeShopDetail;
  CakeShopDetailUi({super.key, this.cakeShopDetail});

  @override
  State<CakeShopDetailUi> createState() => _CakeShopDetailUiState();
}

class _CakeShopDetailUiState extends State<CakeShopDetailUi> {
  //Phone
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  //Browser
  Future<void> _launchInBrowserView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }

  //Map
  MapController? mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(
          widget.cakeShopDetail!.name!,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Center(
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/${widget.cakeShopDetail!.image1!}',
                      width: 120,
                      height: 80,
                      fit: BoxFit.cover,
                    )),
                SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/${widget.cakeShopDetail!.image2!}',
                      width: 120,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/${widget.cakeShopDetail!.image3!}',
                      width: 120,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ]),
                SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {},
                          leading: Icon(
                            FontAwesomeIcons.shop,
                          ),
                          title: Text(
                            widget.cakeShopDetail!.name!,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: Icon(
                            FontAwesomeIcons.locationDot,
                          ),
                          title: Text(
                            widget.cakeShopDetail!.address!,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            _makePhoneCall(widget.cakeShopDetail!.phone!);
                          },
                          leading: Icon(
                            Icons.phone,
                          ),
                          title: Text(
                            widget.cakeShopDetail!.phone!,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            _launchInBrowserView(
                                Uri.parse(widget.cakeShopDetail!.website!));
                          },
                          leading: Icon(
                            FontAwesomeIcons.globe,
                          ),
                          title: Text(
                            widget.cakeShopDetail!.website!,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            _launchInBrowserView(
                                Uri.parse(widget.cakeShopDetail!.facebook!));
                          },
                          leading: Icon(
                            FontAwesomeIcons.facebook,
                          ),
                          title: Text(
                            widget.cakeShopDetail!.facebook!,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: FlutterMap(
                      mapController: MapController(),
                      //กำหนดตำแหน่งแผนที่
                      options: MapOptions(
                        initialCenter: LatLng(
                          double.parse(widget.cakeShopDetail!.latitude!),
                          double.parse(widget.cakeShopDetail!.longitude!),
                        ),
                        initialZoom: 15.0,
                      ),
                      //วาดแผนที่
                      children: [
                        //แสดงแผนที่
                        TileLayer(
                          urlTemplate:
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          userAgentPackageName: 'com.example.app',
                        ),
                        RichAttributionWidget(
                          attributions: [
                            TextSourceAttribution(
                              'OpenStreetMap contributors',
                              onTap: () => _launchInBrowserView(Uri.parse(
                                  'https://www.openstreetmap.org/copyright')),
                            )
                          ],
                        ),
                        MarkerLayer(markers: [
                          Marker(
                            point: LatLng(
                              double.parse(widget.cakeShopDetail!.latitude!),
                              double.parse(widget.cakeShopDetail!.longitude!),
                            ),
                            child: InkWell(
                              onTap: () {
                                String googleMapUrl =
                                    'https://www.google.com/maps/search/?api=1&query=${widget.cakeShopDetail!.latitude},${widget.cakeShopDetail!.longitude}';
                                _launchInBrowserView(Uri.parse(googleMapUrl));
                              },
                              child: Icon(
                                FontAwesomeIcons.locationDot,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ),
                        ]),
                      ]),
                ),
              ],
            ),
          )),
    );
  }
}
