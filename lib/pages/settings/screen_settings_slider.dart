
import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

import '../../Logic/Provider/provider_settings.dart';

@RoutePage()
class SliderSettingsPage extends StatefulWidget {
  const SliderSettingsPage({super.key});

  @override
  State<SliderSettingsPage> createState() => SliderSettingsPageState();
}

class SliderSettingsPageState extends State<SliderSettingsPage> {
  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: ui.TextDirection.ltr,

      child: Consumer<SettingsProvider>(
        builder: (context, provider, child) {
          return RotatedBox(
            quarterTurns: provider.isLandscape? 0 :1,
            child: Scaffold(
                backgroundColor: CupertinoColors.lightBackgroundGray,

                appBar: AppBar(
                  title: Text('announcements'.tr()),
                ),

                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Slider duration title
                      SizedBox(
                        width: MediaQuery.of(context).size.width/1.1,
                        child: ListTile(
                          title: Text('slider_duration'.tr()),
                          subtitle: Text('slider_duration_desc'.tr(),softWrap: true,),
                        ),
                      ),

                      /// Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// Decrease button
                          ElevatedButton(
                            onPressed: () => provider.decSliderTimer(),
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(24),
                                elevation: 0
                            ),
                            child: const Text('-',  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                          ),

                          /// Current value
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Center(
                              child: Text(
                                  '${provider.pageSlideTimer}',
                                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)
                              ),
                            ),
                          ),

                          /// Increase button
                          ElevatedButton(
                              onPressed: () => provider.incSliderTimer(),
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(24),
                                  elevation: 0
                              ),
                              child: const Text('+',style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
                          )
                        ],
                      )
                    ],
                  ),
                )
            ),
          );
        }
      ),
    );
  }
}