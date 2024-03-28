import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:path_provider/path_provider.dart';
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
  CacheOptions? cacheOptions;
  HiveCacheStore? cacheStore;
  Dio? dio;
  CookieJar? cookieJar;

  HttpService._constructor(){
    dio = Dio(
        BaseOptions(
            receiveTimeout: const Duration(seconds: 5),
            connectTimeout: const Duration(seconds: 5),
            sendTimeout: const Duration(seconds: 15),
        )
    );
    if(!kIsWeb){
      cookieJar = CookieJar();
      dio?.interceptors.add(CookieManager(cookieJar!));
    }
    dio?.httpClientAdapter = getAdapter();
  }

  addInterceptors() async{
    /// Cache
    var cacheDir = await getTemporaryDirectory();
    cacheStore = HiveCacheStore(
      cacheDir.path,
      hiveBoxName: "dio_cache",
    );
    cacheOptions = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.refreshForceCache,
      priority: CachePriority.high,
      maxStale: const Duration(minutes: 5),
      hitCacheOnErrorExcept: [401, 404],
      keyBuilder: (request) {
        return request.uri.toString();
      },
    );
    dio?.interceptors.addAll([
      Logging(),
      DioCacheInterceptor(options: cacheOptions!),
    ]);
  }

  static HttpService? _singleton;
  factory HttpService() {
    _singleton ??= HttpService._constructor();
    return _singleton!;
  }
}
