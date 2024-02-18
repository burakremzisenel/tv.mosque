import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tv_mosque/Model/settings.dart';

import '../../helper/shared_prefs.dart';

class SettingsProvider extends ChangeNotifier{
  Settings settings;
  bool isLandscape;
  int languageToggleTimer;
  int pageSlideTimer;

  SettingsProvider(this.settings)
      : isLandscape = settings.orientation == Orientation.landscape,
        languageToggleTimer = settings.languageToggleTimer,
        pageSlideTimer = settings.pageSlideTimer;

  updateEndpoints(String iApi, String iKey, String dApi, String dKey) async {
    settings.igmgApi = iApi;
    settings.igmgApiKey = iKey;
    settings.directusApi = dApi;
    settings.directusKey = dKey;
    await saveToBuffer(BufferTypes.settings, settings.toJson());
  }

  toggleOrientation() async {
    isLandscape = !isLandscape;
    settings.orientation = isLandscape? Orientation.landscape : Orientation.portrait;
    await saveToBuffer(BufferTypes.settings, settings.toJson());
    notifyListeners();
  }

  incLangTimer() async {
    languageToggleTimer++;
    settings.languageToggleTimer = languageToggleTimer;
    await saveToBuffer(BufferTypes.settings, settings.toJson());
    notifyListeners();
  }
  decLangTimer() async {
    if(languageToggleTimer > 0){
      languageToggleTimer--;
      settings.languageToggleTimer = languageToggleTimer;
      await saveToBuffer(BufferTypes.settings, settings.toJson());
      notifyListeners();
    }
  }

  incSliderTimer() async {
    pageSlideTimer++;
    settings.pageSlideTimer = pageSlideTimer;
    await saveToBuffer(BufferTypes.settings, settings.toJson());
    notifyListeners();
  }
  decSliderTimer() async {
    if(pageSlideTimer > 0){
      pageSlideTimer--;
      settings.pageSlideTimer = pageSlideTimer;
      await saveToBuffer(BufferTypes.settings, settings.toJson());
      notifyListeners();
    }
  }
}