import 'package:earth_quick_damage_prediction_frontend/globals.dart';
import 'package:earth_quick_damage_prediction_frontend/widgets/buildings_list_items_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:patterns_canvas/patterns_canvas.dart';

class BuildingsListItemWidget extends StatelessWidget {
  final String location;
  final double lat;
  final double lon;
  final int damageLevel;

  const BuildingsListItemWidget({
    super.key,
    required this.location,
    required this.lat,
    required this.lon,
    required this.damageLevel
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: double.infinity,
      color: Color(0xFF1D222A),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 36,
                height: 36,
                child: CustomPaint(
                  painter: DiagonalStripesPainter(
                      fgColor: colorFromDamageLevel(damageLevel).withOpacity(0.5),
                      bgColor: colorFromDamageLevel(damageLevel).withOpacity(0.3),
                      featuresCount: 8),
                ),
              ),
              Text(
                damageLevel.toStringAsFixed(1),
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                BuildingsListItemsFieldWidget(
                    title: 'Time', value: '11h20m', size: 1),
                BuildingsListItemsFieldWidget(
                    title: 'Location', value: location, size: 2),
                BuildingsListItemsFieldWidget(
                    title: 'Coordination',
                    value:
                        '${lat.toStringAsFixed(3)}, ${lon.toStringAsFixed(3)}',
                    size: 2),
                BuildingsListItemsFieldWidget(
                    title: 'Sensor', value: 'None', size: 1),
              ],
            ),
          ),
          Icon(Icons.keyboard_arrow_down_outlined)
        ],
      ),
    );
  }
}

class DiagonalStripesPainter extends CustomPainter {
  Color fgColor;
  Color bgColor;
  int featuresCount;

  DiagonalStripesPainter(
      {required this.fgColor,
      required this.bgColor,
      required this.featuresCount});
  @override
  void paint(Canvas canvas, Size size) {
    var pattern = DiagonalStripesThick(
      bgColor: bgColor,
      fgColor: fgColor,
      featuresCount: featuresCount,
    );
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    pattern.paintOnRect(canvas, size, rect);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
