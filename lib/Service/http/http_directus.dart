part of 'http_service.dart';

extension DirectusAPI on HttpService{
  /// Fetch Announcements from API.MOSQUE
  ///
  Future<List<Announcement>> fetchAnnouncements() async {
    try {
      //_singleton.dio.options.headers['X-API-KEY'] = API_KEY;
      Response? res = await dio?.get(
          '${settings?.directusApi}/items/feeds',
          options: Options(
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer ${settings?.directusKey}",
              },
              responseType: ResponseType.json,
              sendTimeout: const Duration(seconds: 5)
          )
      );
      List<Announcement> newsList = Announcement.listFromJson(res?.data['data']);
      return newsList;

    } on DioError catch (e) {
      //throw DioExceptions.fromDioError(e).message;
      debugPrint(e.message);

    } catch (e) {
      //throw NewsListFetchDataException(e.toString());
      debugPrint(e.toString());
    }
    return [];
  }

  String directusImgUri(imgID){
    return Uri.parse('${settings?.directusApi}/images/$imgID').toString();
  }

  /// Fetchs an network image & caches it
  Widget fetchImageByID({
    String? imageUrl,
    required String imageID,
    BoxFit? fit,
    double? width,
    double? height,
    ImageWidgetBuilder? imageBuilder,
    Widget? errorWidget,
  }) {
    return CachedNetworkImage(
      httpHeaders: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${settings?.directusKey}",
      },
      alignment: Alignment.center,
      imageUrl: imageUrl ?? '${settings?.directusApi}/assets/$imageID',
      cacheKey: imageID,
      fit: fit ?? BoxFit.fitWidth,
      //width: width ?? 300,
      //height: height ?? 300,
      imageBuilder: imageBuilder,
      cacheManager: kIsWeb? null: DefaultCacheManager(),
      imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
      placeholder: (context, url) => ImageShimmerWidget(
        shimmerDirection: ShimmerDirection.ltr,
        shimmerDuration: const Duration(milliseconds: 1500),
        baseColor: Colors.white,
        highlightColor: defaultShimmerHighlightColor,
        backColor: defaultShimmerBackColor,
      ),
      errorWidget: (context, url, error) {
        debugPrint(error.toString());
        if (errorWidget != null) {
          return errorWidget;
        } else {
          return const Center(
              child: Icon(CupertinoIcons.photo_fill, color: Colors.white, size: 64)
          );
        }
      },
    );
  }
}