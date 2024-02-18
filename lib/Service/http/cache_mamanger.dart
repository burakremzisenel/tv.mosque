import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'cache_file_system.dart';

class DefaultCacheManager extends CacheManager with ImageCacheManager {
  static const key = 'libCachedImageData';

  static DefaultCacheManager? _instance;

  factory DefaultCacheManager() {
    _instance ??= DefaultCacheManager._();
    return _instance!;
  }

  DefaultCacheManager._() : super(Config(
    key,
    stalePeriod: const Duration(days: 30),
    maxNrOfCacheObjects: 120,
    repo: JsonCacheInfoRepository(databaseName: key),
    fileSystem: IOFileSystem(key),
    fileService: HttpFileService(),
  ));
}