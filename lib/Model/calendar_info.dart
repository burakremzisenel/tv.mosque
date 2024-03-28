
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'calendar_info.g.dart';

@JsonSerializable()
class CalendarInfo with EquatableMixin{

  @JsonKey(name: 'DaysTopicText')
  String? daysTopicText;

  @JsonKey(name: 'Event')
  String? event;

  @JsonKey(name: 'DaysTopic')
  String? daysTopic;

  @JsonKey(name: 'AyahOrHadith')
  String? ayahOrHadith;

  @JsonKey(defaultValue: {}, includeToJson: true)
  Map<String,String> eventTranslations;

  @JsonKey(defaultValue: {}, includeToJson: true)
  Map<String,String> daysTopicTranslations;

  @JsonKey(defaultValue: {}, includeToJson: true)
  Map<String,String> daysTopicTextTranslations;

  @JsonKey(defaultValue: {}, includeToJson: true)
  Map<String,String> ayahTranslations;

  CalendarInfo({
    this.daysTopic,
    this.daysTopicText,
    this.ayahOrHadith,
    this.event,
    this.eventTranslations = const{},
    this.daysTopicTranslations = const{},
    this.daysTopicTextTranslations = const{},
    this.ayahTranslations = const{},
});

  factory CalendarInfo.init(){
    return CalendarInfo(
        daysTopic: '',
        daysTopicText: '',
        ayahOrHadith: '',
        event: '',
        eventTranslations: {},
        daysTopicTextTranslations: {},
        daysTopicTranslations: {},
        ayahTranslations: {});
  }

  String getTranslatedEvent(String currentLocale){
    final res = eventTranslations[currentLocale] ??= '';
    return res;
  }
  String getTranslatedTopic(String currentLocale){
    final res = daysTopicTranslations[currentLocale] ??= '';
    return res;
  }
  String getTranslatedTopicText(String currentLocale){
    final res = daysTopicTextTranslations[currentLocale] ??= '';
    return res.replaceAll('<br>', '\n');
  }
  String getTranslatedAyah(String currentLocale){
    final res = ayahTranslations[currentLocale] ??= '';
    return res;
  }

  factory CalendarInfo.fromJson(Map<String, dynamic> json) => _$CalendarInfoFromJson(json);
  Map<String, dynamic> toJson() => _$CalendarInfoToJson(this);

  @override
  List<Object?> get props => [
    eventTranslations,
    daysTopicTranslations,
    daysTopicTextTranslations,
    ayahTranslations
  ];
}