import 'package:earth_quick_damage_prediction_frontend/globals.dart';
import 'package:earth_quick_damage_prediction_frontend/models/buildings.dart';
import 'package:earth_quick_damage_prediction_frontend/widgets/buildings_list_items_field_widget.dart';
import 'package:earth_quick_damage_prediction_frontend/widgets/buildings_list_items_widget.dart';
import 'package:earth_quick_damage_prediction_frontend/widgets/map_widget.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class EarthQuakeDamagePredictionScreen extends StatefulWidget {
  const EarthQuakeDamagePredictionScreen({super.key});

  @override
  State<EarthQuakeDamagePredictionScreen> createState() =>
      _EarthQuakeDamagePredictionScreenState();
}

class _EarthQuakeDamagePredictionScreenState
    extends State<EarthQuakeDamagePredictionScreen> {
  late List<BuildingData> buildings = [];
  late List<int> damageLevels = [];
  double inDanger = 0;

  @override
  initState() {
    super.initState();
    _fetchBuildingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        image: DecorationImage(
          image: AssetImage('images/bg_b.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.symmetric(horizontal: 160, vertical: 40),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(40),
          image: DecorationImage(
            image: AssetImage('images/bg_f.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 56,
              decoration: BoxDecoration(
                color: Color(0xFF0D1217).withAlpha(255),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.menu,
                          )),
                      Image.asset(
                        'images/image_3.png',
                        width: 1130,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF131821).withAlpha(255),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(left: 18, right: 10),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Padding(
                                  padding: EdgeInsets.only(top: 26, bottom: 8),
                                  child: BinaryLabelsChartWidget(inDanger: inDanger,))),
                          Expanded(
                            flex: 6,
                            child: ListView(
                              children: [
                                for (int i = 0; i < buildings.length; i++)
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 3),
                                      child: BuildingsListItemWidget(
                                        location: buildings[i].address,
                                        lat: buildings[i].latitude,
                                        lon: buildings[i].longitude,
                                        damageLevel: damageLevels[i],
                                      )),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                    VerticalDivider(
                      thickness: 0.2,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.only(
                          top: 18, bottom: 18, right: 18, left: 10),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: EarthquakeMap(
                                        buildings: buildings
                                            .map((item) => LatLng(
                                                item.latitude, item.longitude))
                                            .toList(),
                                        damageLevels: damageLevels,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 18,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            BuildingsListItemsFieldWidget(
                                                title: 'Date',
                                                value: '12/12/2024',
                                                size: 1),
                                            BuildingsListItemsFieldWidget(
                                                title: 'Time',
                                                value: '11h20m',
                                                size: 1),
                                            BuildingsListItemsFieldWidget(
                                                title: 'Time',
                                                value: '11h20m',
                                                size: 1),
                                            BuildingsListItemsFieldWidget(
                                                title: 'Time',
                                                value: '11h20m',
                                                size: 1),
                                            BuildingsListItemsFieldWidget(
                                                title: 'Time',
                                                value: '11h20m',
                                                size: 1),
                                            BuildingsListItemsFieldWidget(
                                                title: 'Time',
                                                value: '11h20m',
                                                size: 1),
                                            Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () async{
                                                  await _fetchBuildingData(prediction: true, intensity: intensity);
                                                  setState(() {});
                                                },
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    height: 40,
                                                    child: Text(
                                                      'Predict',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow
                                                            .withOpacity(0.7),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  ),
                                              ),
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 16,
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                width: double.infinity,
                                child: Image.asset(
                                  'images/image_2.png',
                                  fit: BoxFit.fill,
                                ),
                              ))
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> _fetchBuildingData({bool prediction = false, double intensity = 5}) async {
    String apiUrl =
        (!prediction) ? 'http://127.0.0.1:8000/api/building/get_building_data': 'http://127.0.0.1:8000/api/building/get_building_prediction_data?intensity=$intensity';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> buildingsList = jsonData['buildings'];
        inDanger = jsonData['statistics']["in_danger"].toDouble();
        damageLevels = jsonData['damage_level_predicted'].cast<int>();
        buildings =
            buildingsList.map((item) => BuildingData.fromJson(item)).toList();
      } else {
        throw Exception(
            'Failed to load building data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load building data. Error: $e');
    }
    setState(() {});
  }
}

class BinaryLabelsChartWidget extends StatelessWidget {
  double inDanger = 0;
   BinaryLabelsChartWidget({
    super.key,
    required this.inDanger
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 96,
          width: 180,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'TOTAL NUMBER OF BUILDINGS',
              style: TextStyle(fontSize: 10),
            ),
            Text(
              '120',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SAFE',
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      '${((1 - inDanger) * 100).toStringAsFixed(1)}%',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'DANGER',
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      '${(inDanger * 100).toStringAsFixed(1)}%',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Container(
                  height: 20,
                  width: 175 * (1 - inDanger),
                  color: Colors.green,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  height: 20,
                  width: 1,
                  color: Colors.white,
                ),
                Expanded(
                  child: Container(
                    height: 20,
                    width: 30,
                    color: Colors.orange,
                  ),
                )
              ],
            )
          ]),
        ),
        Container(
          height: 110,
          width: 325,
          child: Container(
            height: 96,
            width: 180,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'OVERVIEW BY DAMAGE LEVEL',
                style: TextStyle(fontSize: 10),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Ali Mendjali',
                        style: TextStyle(fontSize: 8),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        color: Colors.orange,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Constantine',
                        style: TextStyle(fontSize: 8),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'Khroub',
                        style: TextStyle(fontSize: 8),
                      )
                    ],
                  )
                ],
              ),
              Expanded(child: SizedBox()),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 7,
                            height: 30,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(width: 7, height: 20, color: Colors.orange),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 7,
                            height: 10,
                            color: Colors.red,
                          )
                        ],
                      ),
                      Text(
                        '1',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 7,
                            height: 30,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(width: 7, height: 20, color: Colors.orange),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 7,
                            height: 10,
                            color: Colors.red,
                          )
                        ],
                      ),
                      Text(
                        '2',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 7,
                            height: 30,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(width: 7, height: 20, color: Colors.orange),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 7,
                            height: 10,
                            color: Colors.red,
                          )
                        ],
                      ),
                      Text(
                        '3',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 7,
                            height: 30,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(width: 7, height: 20, color: Colors.orange),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 7,
                            height: 10,
                            color: Colors.red,
                          )
                        ],
                      ),
                      Text(
                        '4',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 7,
                            height: 30,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(width: 7, height: 20, color: Colors.orange),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 7,
                            height: 10,
                            color: Colors.red,
                          )
                        ],
                      ),
                      Text(
                        '5',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 7,
                            height: 30,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(width: 7, height: 20, color: Colors.orange),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 7,
                            height: 10,
                            color: Colors.red,
                          )
                        ],
                      ),
                      Text(
                        '6',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 7,
                            height: 30,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(width: 7, height: 20, color: Colors.orange),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 7,
                            height: 10,
                            color: Colors.red,
                          )
                        ],
                      ),
                      Text(
                        '7',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 7,
                            height: 30,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(width: 7, height: 20, color: Colors.orange),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 7,
                            height: 10,
                            color: Colors.red,
                          )
                        ],
                      ),
                      Text(
                        '8',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 7,
                            height: 30,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Container(width: 7, height: 20, color: Colors.orange),
                          SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 7,
                            height: 10,
                            color: Colors.red,
                          )
                        ],
                      ),
                      Text(
                        '9',
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  )
                ],
              )
            ]),
          ),
        )
      ],
    );
  }
}
