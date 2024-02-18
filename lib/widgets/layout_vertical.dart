import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tv_mosque/widgets/layout_top.dart';
import 'package:tv_mosque/widgets/ptimes_list_cards.dart';
import 'carousel.dart';

class LayoutVertical extends StatefulWidget {
  const LayoutVertical({super.key});

  @override
  State<LayoutVertical> createState() => LayoutVerticalState();
}

class LayoutVerticalState extends State<LayoutVertical> {

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        /// Row 1
        /// Gregorian calendar - Hijri calendar
        const Expanded(
          flex: 2,
          child: LayoutTop(),
        ),

        /// Row2
        /// Horizontal prayer times
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              /// Prayer Times list
              /// 6x Widgets with flex 1
              ...buildPrayerTimeCards(context)
            ],
          ),
        ),

        const SizedBox(height: 10),

        /// Row3
        /// announcements
        const Expanded(
          flex: 10,
            child: Carousel(),
        )
      ],
    );
  }
}
