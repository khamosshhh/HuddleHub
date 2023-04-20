import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_compass/utils/src/compass_ui.dart';

import '../profile/allUsers.dart';
import '../radar.dart';
import 'direction_arc.dart';
import 'markers_display.dart';

class RadarDisplay extends StatefulWidget {
  const RadarDisplay({super.key});

  @override
  State<RadarDisplay> createState() => _RadarDisplayState();
}

class _RadarDisplayState extends State<RadarDisplay> {
  final int _animationDurationMs = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color.fromARGB(255, 26, 34, 37),
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.navigate_before_rounded),
      //     onPressed: () {
      //       Get.off(
      //         () => const RadarSearch(),
      //         transition: Transition.leftToRight,
      //         duration: const Duration(milliseconds: 500),
      //       );
      //     },
      //   ),
      //   toolbarHeight: 45,
      // ),

      body: SmoothCompass(
        compassBuilder: (context, compassData, compassAsset) {
          final double animationTurns =
              compassData == null || compassData.data == null
                  ? 0
                  : compassData.data!.turns * -1;
          const double size = 300.0;

          return Container(
            // Background Styling
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 26, 34, 37),
                  Colors.lightBlue,
                ],
              ),
            ),

            child: Stack(
              children: [
                // Radar
                Center(
                  child: SizedBox(
                    height: size,
                    width: size,
                    child: Stack(
                      children: [
                        // Radar Chart
                        AnimatedRotation(
                          turns: animationTurns,
                          duration:
                              Duration(milliseconds: _animationDurationMs),
                          child: ShaderMask(
                            shaderCallback: (bounds) => const RadialGradient(
                              radius: 0.75,
                              stops: [0.3, 0.7],
                              colors: [
                                Colors.white,
                                Colors.transparent,
                              ],
                            ).createShader(bounds),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/grid_tile.png'),
                                  opacity: 0.5,
                                  repeat: ImageRepeat.repeat,
                                  scale: 3,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Radar BG Lines
                        Center(
                          child: Image.asset('assets/images/radar_lines.png'),
                        ),

                        // Radar Tracer
                        const Center(
                          child: DirectionArc(
                            size: 100,
                            color: Color.fromARGB(255, 72, 142, 208),
                          ),
                        ),

                        // Pulsating Markers
                        AnimatedRotation(
                          turns: animationTurns,
                          duration:
                              Duration(milliseconds: _animationDurationMs),
                          child: MarkersDisplay(
                            size: size,
                            zoomLevel: range/10000,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Compass
                Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.all(30),
                  child: AnimatedRotation(
                    turns: animationTurns,
                    duration: Duration(milliseconds: _animationDurationMs),
                    child: Image.asset(
                      'assets/images/compass.png',
                      scale: 2,
                    ),
                  ),
                ),

                // Cords
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.all(20),
                  child: const SizedBox(
                    child: Text(
                      'Lat: ' '\nLon: ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // User Details Button
                Column(
                  children: [
                    const SizedBox(
                      height: 500,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => const AllUsersScreen()),
                        child: const Text('Get Details'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
