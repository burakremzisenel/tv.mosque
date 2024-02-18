import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/defaults.dart';
import 'package:fancy_shimmer_image/widgets/image_shimmer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './cache_mamanger.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:tv_mosque/Model/Quran/Chapter.dart';
import 'package:tv_mosque/Model/announcement.dart';

import '../../Model/Quran/Quran.dart';
import '../../Model/Quran/Verse.dart';
import '../../Model/calendar_info.dart';
import '../../Model/prayer_times.dart';

import '../../Model/settings.dart';
import 'http_logging.dart';
import 'http_shared.dart';

part 'http_directus.dart';
part 'http_quran.dart';
part 'http_igmg.dart';

class HttpService{
  Settings? settings;

  Dio? dio;
  CookieJar? cookieJar;
  HttpService._constructor(){
    dio = Dio(
        BaseOptions(
            receiveTimeout: const Duration(seconds: 10), // 15 seconds
            connectTimeout: const Duration(seconds: 15),
            sendTimeout: const Duration(seconds: 15),
        )
    );
    if(!kIsWeb){
      cookieJar = CookieJar();
      dio?.interceptors.add(CookieManager(cookieJar!));
    }
    dio?.httpClientAdapter = getAdapter();
    dio?.interceptors.add(Logging());
  }
  static HttpService? _singleton;
  factory HttpService() {
    _singleton ??= HttpService._constructor();
    return _singleton!;
  }
}
