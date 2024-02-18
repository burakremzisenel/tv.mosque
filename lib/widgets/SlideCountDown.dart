import 'package:flutter/cupertino.dart';
import 'package:slide_countdown/slide_countdown.dart';

class PTimeSlideCountDown extends StatefulWidget {
  const PTimeSlideCountDown({super.key, required this.duration});

  final Duration duration;

  @override
  State<PTimeSlideCountDown> createState() => _PTimeSlideCountDownState();
}

class _PTimeSlideCountDownState extends State<PTimeSlideCountDown> {

  StreamDuration streamDuration = StreamDuration(
      config: StreamDurationConfig(
          autoPlay: true,
          countDownConfig: CountDownConfig(
              duration: Duration.zero
          )
      )
  );

  @override
  void initState() {
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    streamDuration = StreamDuration(
        config: StreamDurationConfig(
            onDone: (){
              debugPrint('ON DONE');
              setState(() {
                streamDuration.add(widget.duration);
                //streamDuration.play();
              });
            },
            autoPlay: true,
            countDownConfig: CountDownConfig(
                duration: widget.duration
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Count down REBUILD');

    return SlideCountdownSeparated(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Color(0xFFF23333),
      ),
      shouldShowDays: (_)=>false,
      shouldShowHours: (_)=>true,
      shouldShowMinutes: (_)=>true,
      shouldShowSeconds: (_)=>true,
      // showZeroValue: true,
      duration:   widget.duration,
      streamDuration: streamDuration,

      // streamDuration:StreamDuration(
      //     config: StreamDurationConfig(
      //         autoPlay: true,
      //         countDownConfig: CountDownConfig(
      //             duration: widget.duration
      //         )
      //     )
      // ),
    );
  }
}

/*


import 'package:flutter/cupertino.dart';
import 'package:slide_countdown/slide_countdown.dart';



class PTimeSlideCountDown extends StatelessWidget{
  final Duration duration;

  const PTimeSlideCountDown({super.key, required this.duration});



  @override
  Widget build(BuildContext context) {
    StreamDuration streamDuration = StreamDuration(
        config: StreamDurationConfig(
            autoPlay: true,
            countDownConfig: CountDownConfig(
                duration: duration
            )
        )
    );

    return SlideCountdownSeparated(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Color(0xFFF23333),
      ),
      shouldShowDays: (_)=>false,
      shouldShowHours: (_)=>true,
      shouldShowMinutes: (_)=>true,
      shouldShowSeconds: (_)=>true,
      // showZeroValue: true,
      duration:   duration,
      streamDuration: streamDuration,
      onDone: (){
        streamDuration.resume();
      },
      // streamDuration:StreamDuration(
      //     config: StreamDurationConfig(
      //         autoPlay: true,
      //         countDownConfig: CountDownConfig(
      //             duration: widget.duration
      //         )
      //     )
      // ),
    );
  }
}
*/
