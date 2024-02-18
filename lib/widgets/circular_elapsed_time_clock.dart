
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:provider/provider.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:tv_mosque/Model/prayer_times.dart';

import '../Logic/Provider/provider_clock.dart';


class CircularElapsedTimeClock extends StatefulWidget {
  const CircularElapsedTimeClock({super.key});

  @override
  State<CircularElapsedTimeClock> createState() => _CircularElapsedTimeClockState();
}

class _CircularElapsedTimeClockState extends State<CircularElapsedTimeClock> {
  int nextPrayerTimeInSeconds=0, currPrayerTimeInSeconds=0, currTimeInSeconds=0, diff=0;
  double pTimeCircularStartAngle = 0;

  late ValueNotifier<double> _pTimeCircular;
  late ValueNotifier<double> _pTimeCircularElapsed;

  @override
  void initState() {
    super.initState();

    _pTimeCircular = ValueNotifier(0.0);
    _pTimeCircularElapsed = ValueNotifier(0.0);
  }

  @override
  void dispose() {
    _pTimeCircular.dispose();
    _pTimeCircularElapsed.dispose();

    super.dispose();
  }

  double calcStartAngle(int currPrayerTimeInSeconds){
    return (currPrayerTimeInSeconds % (12 * 60 * 60)) / (12 * 60 * 60) * 360;
  }

  calcPTimeCircular(PrayerTimes prayerTimes){
    nextPrayerTimeInSeconds = prayerTimes.nextPrayerTimeAsDuration().inSeconds;
    currPrayerTimeInSeconds = prayerTimes.currPrayerTimeAsDuration().inSeconds;
    diff = nextPrayerTimeInSeconds - currPrayerTimeInSeconds;
    if (diff < 0) diff += 24 * 60 * 60;

    /// percentage
    /// pos. values 0-100
    _pTimeCircular.value = diff / (12 * 60 * 60) * 100;
  }

  calcPTimeCircularElapsed(PrayerTimes prayerTimes){
    currPrayerTimeInSeconds = prayerTimes.currPrayerTimeAsDuration().inSeconds;
    currTimeInSeconds = prayerTimes.currTimeToDuration().inSeconds;
    diff = currTimeInSeconds - currPrayerTimeInSeconds;
    if (diff < 0) diff += 24 * 60 * 60;

    /// percentage
    /// pos. values 0-100
    _pTimeCircularElapsed.value = diff / (12 * 60 * 60) * 100;
  }

  @override
  Widget build(BuildContext context) {
    // Current time as human readable text ex. 00:00
    var currentTimeString = DateFormat.Hms().format(DateTime.now());

    /// builds clock
    /// with circular prayer times
    /// displays circular current prayer time range
    /// and elapsed current prayer time
    return Container(
      padding: const EdgeInsets.all(12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          var outerCircularBarWidth = 0.07 * constraints.maxHeight;
          var innerCircularBarWidth = outerCircularBarWidth * 0.75;
          var circularSize = constraints.maxHeight - outerCircularBarWidth / 2;
          return Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/Allah.png')),
                  ),
                  child: AnalogClock(
                    dateTime: DateTime.now(),
                    isKeepTime: true,
                    hourNumberColor: Colors.amber,
                    hourNumberSizeFactor: 1.1,
                    hourNumbers: const ['', '', '3', '', '', '6', '', '', '9', '', '', '12'],
                    hourNumberRadiusFactor: 1.45,
                    hourHandColor: Colors.white,
                    minuteHandColor: Colors.white,
                    dialColor: null,
                    markingColor: Colors.amberAccent,
                    markingWidthFactor: 1.5,
                    markingRadiusFactor: 1.1,
                    secondHandColor: Colors.white,
                    centerPointColor: null,
                    centerPointWidthFactor: 0,
                  ),
                ),

                /// current prayer time range
                /// as circular bar
                Selector<ClockViewModel, PrayerTimes>(
                    selector: (_, provider) => provider.prayerTimes,
                    builder: (context, pTimes, child) {
                      calcPTimeCircular(pTimes);
                      return Container(
                        padding: const EdgeInsets.all(5),
                        child: SimpleCircularProgressBar(
                          animationDuration: 0,
                          size: circularSize,
                          progressStrokeWidth: outerCircularBarWidth,
                          progressColors: [Colors.white.withOpacity(0.6), Colors.white.withOpacity(0.8)],
                          backStrokeWidth: 0,
                          startAngle: calcStartAngle(pTimes.currPrayerTimeAsDuration().inSeconds),
                          valueNotifier: _pTimeCircular,
                        ),
                      );
                    }),

                /// circular elapsed time indicator
                /// of current time
                Selector<ClockViewModel, PrayerTimes>(
                    selector: (_, provider) => provider.prayerTimes,
                    builder: (context, pTimes, child) {
                      calcPTimeCircularElapsed(pTimes);
                      return Container(
                        padding: const EdgeInsets.all(5),
                        child: SimpleCircularProgressBar(
                          animationDuration: 0,
                          size: circularSize,
                          progressStrokeWidth: innerCircularBarWidth,
                          progressColors: const [Colors.deepOrangeAccent, Colors.red],
                          backStrokeWidth: 0,
                          startAngle: calcStartAngle(pTimes.currPrayerTimeAsDuration().inSeconds) + 2,
                          valueNotifier: _pTimeCircularElapsed,
                        ),
                      );
                    }),
              ]
          );
        }
      ),
    );
  }
}