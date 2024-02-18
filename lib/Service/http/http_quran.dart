part of 'http_service.dart';

extension QuranAPI on HttpService{
  /// Quran Chapter by Id
  Future<Chapter> fetchChapterById({required String id}) async{
    String endPoint = '/chapters/$id';
    var response = await dio?.get(QURAN.API + endPoint);
    return Chapter.fromJson(response?.data['chapter']);
  }
  /// Quran Verses by Key
  Future<Verse> fetchVerseByKey({
    required String surahNr,
    required String ayahNr,
    int? translation,
    required String language
  }) async{
    String endPoint = '/verses/by_key/$surahNr:$ayahNr';
    var queryParams = {
      'translations': translation,
      'language': language,
    };
    if ( translation == null ){
      endPoint = '/quran/verses/imlaei';
      queryParams = {
        'verse_key': '$surahNr:$ayahNr',
      };
    }
    var response = await dio?.get(
        QURAN.API + endPoint,
        queryParameters: queryParams);
    return Verse.fromJson(translation==null? response?.data["verses"][0]
        :response?.data["verse"]);
  }
}