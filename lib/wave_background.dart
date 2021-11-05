import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaveBackground extends StatelessWidget {
  const WaveBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  WaveWidget(
      config: CustomConfig(
        gradientBegin: Alignment.bottomCenter,
        gradientEnd: Alignment.topCenter,
        gradients: [
          [Color(0xFF1E88E5), Color(0xFF1E88E5)],
          [Color(0xFF96C7F3), Color(0xFF96C7F3)],
          [Color(0xFF43A0EF), Color(0xFF499FE9)],
        ],
        heightPercentages: [0.03, 0.01, 0.02],
        durations: [19440, 10000, 6000],
      ),
      size: Size(
        double.infinity,
        double.infinity,
      ),
      // backgroundColor: Colors.blue.shade300,
    );
  }
}
