import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tv_mosque/widgets/layout_top.dart';
import 'package:tv_mosque/widgets/ptimes_list_cards.dart';
import 'package:tv_mosque/widgets/ptimes_list_V.dart';
import 'carousel.dart';
import 'divider.dart';

class LayoutHorizontal extends StatefulWidget {
  const LayoutHorizontal({super.key});

  @override
  State<LayoutHorizontal> createState() => LayoutHorizontalState();
}

class LayoutHorizontalState extends State<LayoutHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        /// Left Widget
        /// Date header
        /// Announcements
        const Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                /// Row 1
                /// Date & Time
                Expanded(
                    flex: 2,
                    child: LayoutTop()
                ),

                /// Row 2
                /// Carousel
                /// Announcements
                Expanded(
                  flex: 6,
                  child: Carousel(),
                )
              ],
            ),
          ),
        ),

        // divider vertical
        verticalDivider(),

        // Right Widget
        // vertical prayer times
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                /// Prayer Times list
                /// 6x Widgets with flex 1
                ...buildPrayerTimeCards(context)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
