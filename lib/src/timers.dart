// ignore_for_file: non_constant_identifier_names
part of space_time;

// -----------------------------------------------------------------------------

/// FORMATTING

// --------------------
/*
DAY                          d
 ABBR_WEEKDAY                 E
 WEEKDAY                      EEEE
 ABBR_STANDALONE_MONTH        LLL
 STANDALONE_MONTH             LLLL
 NUM_MONTH                    M
 NUM_MONTH_DAY                Md
 NUM_MONTH_WEEKDAY_DAY        MEd
 ABBR_MONTH                   MMM
 ABBR_MONTH_DAY               MMMd
 ABBR_MONTH_WEEKDAY_DAY       MMMEd
 MONTH                        MMMM
 MONTH_DAY                    MMMMd
 MONTH_WEEKDAY_DAY            MMMMEEEEd
 ABBR_QUARTER                 QQQ
 QUARTER                      QQQQ
 YEAR                         y
 YEAR_NUM_MONTH               yM
 YEAR_NUM_MONTH_DAY           yMd
 YEAR_NUM_MONTH_WEEKDAY_DAY   yMEd
 YEAR_ABBR_MONTH              yMMM
 YEAR_ABBR_MONTH_DAY          yMMMd
 YEAR_ABBR_MONTH_WEEKDAY_DAY  yMMMEd
 YEAR_MONTH                   yMMMM
 YEAR_MONTH_DAY               yMMMMd
 YEAR_MONTH_WEEKDAY_DAY       yMMMMEEEEd
 YEAR_ABBR_QUARTER            yQQQ
 YEAR_QUARTER                 yQQQQ
 HOUR24                       H
 HOUR24_MINUTE                Hm
 HOUR24_MINUTE_SECOND         Hms
 HOUR                         j
 HOUR_MINUTE                  jm
 HOUR_MINUTE_SECOND           jms
 HOUR_MINUTE_GENERIC_TZ       jmv
 HOUR_MINUTE_TZ               jmz
 HOUR_GENERIC_TZ              jv
 HOUR_TZ                      jz
 MINUTE                       m
 MINUTE_SECOND                ms
 SECOND                       s
Examples Using the US Locale:
 Pattern                           Result
 ----------------                  -------
 new DateFormat.yMd()             -> 7/10/1996
 new DateFormat("yMd")            -> 7/10/1996
 new DateFormat.yMMMMd("en_US")   -> July 10, 1996
 new DateFormat.jm()              -> 5:08 PM
 new DateFormat.yMd().add_jm()    -> 7/10/1996 5:08 PM
 new DateFormat.Hm()              -> 17:08 // force 24 hour time
 */
// -----------------------------------------------------------------------------
enum TimeAccuracy{
  year,
  month,
  week,
  day,
  hour,
  minute,
  second,
  millisecond,
  microSecond,
}

class Timers {
  // -----------------------------------------------------------------------------

  const Timers();

  // -----------------------------------------------------------------------------
  /// "2019-07-19 8:40:23"
  static DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static dynamic cipherTime({
    @required DateTime time,
    @required bool toJSON,
  }){
    return toJSON ? _cipherDateTimeIso8601(time) : time;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime decipherTime({
    @required dynamic time,
    @required bool fromJSON,
  }){

    // blog('decipherTime : type : ${time.runtimeType} : time : $time');

    if (time == null){
      return null;
    }
    else {
      if (fromJSON == true){
        return _decipherDateTimeIso8601(time);
      }
      else if (time?.runtimeType.toString() == 'Timestamp'){
        return time?.toDate();
      }
      else if (time?.runtimeType.toString() == 'DateTime'){
        return time;
      }
      else {
        return time;
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<dynamic> cipherTimes({
    @required List<DateTime> times,
    @required bool toJSON,
  }){
    final List<dynamic> _times = <String>[];

    if (Mapper.checkCanLoopList(times)){

      for (final DateTime time in times){
        _times.add(cipherTime(
          time: time,
          toJSON: toJSON,
        ));
      }

    }

    return _times;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<DateTime> decipherTimes({
    @required List<dynamic> times,
    @required bool fromJSON,
  }){
    final List<DateTime> _dateTimes = <DateTime>[];

    for (final dynamic time in times){
      _dateTimes.add(
          decipherTime(
            time: time,
            fromJSON: fromJSON,
          )
      );
    }

    return _dateTimes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _cipherDateTimeIso8601(DateTime dateTime){
    String _string;

    if (dateTime != null){
      _string = dateTime.toIso8601String();
    }

    return _string;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime _decipherDateTimeIso8601(String cipheredDateTimeIso8601){
    DateTime _time;

    if (cipheredDateTimeIso8601 != null){
      _time = DateTime.tryParse(cipheredDateTimeIso8601);
    }

    return _time;
  }
  // --------------------
  ///
  static Timestamp decipherDateTimeIso8601ToTimeStamp(String cipheredDateTimeIso8601){

    ///  NOTE : we may revise datetimes timestamps isoStrings for firebase, sembast & sql

    Timestamp _time;

    if (cipheredDateTimeIso8601 != null){
      final DateTime _dateTime = _decipherDateTimeIso8601(cipheredDateTimeIso8601);
      _time = Timestamp.fromDate(_dateTime);
    }

    return _time;
  }
  // --------------------
  ///
  static String tempCipherDateTimeToString(DateTime dateTime){

    if(dateTime == null){
      return null;
    }

    else {
      return dateFormat?.format(dateTime);
    }

  }
  // --------------------
  ///
  static DateTime tempDecipherDateTimeString(String dateTimeString){

    if (dateTimeString == null){
      return null;
    }

    else {
      return dateFormat?.parse(dateTimeString);
    }

  }
  // -----------------------------------------------------------------------------

  /// STRING GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateDayName(BuildContext context, DateTime time){
    return DateFormat('EEEE').format(time);
  }
  // --------------------
  /// GENERATES => [ 'dd / MM / yyyy' ]
  static String generateString_dd_I_MM_I_yyyy({
    @required BuildContext context,
    @required DateTime time
  }){
    final String _dd = '${time.day}';
    final String _mm = '${time.month}';
    final String _yyyy = '${time.year}';
    return '$_dd / $_mm / $_yyyy';
  }
  // --------------------
  /// GENERATES => [ 'hh : mm ampm' ]
  static String generateString_hh_i_mm_ampm({
    @required BuildContext context,
    @required DateTime time,
  }){
    final String _hh = DateFormat('h').format(time);
    final String _mm = Numeric.formatNumberWithinDigits(num: time.minute, digits: 2);
    final String _ampm = DateFormat('a').format(time);
    return '$_hh:$_mm $_ampm';
  }
  // --------------------
  ///
  static String generateString_hh_i_mm_i_ss(DateTime time){

    String _output = '';

    if (
        time != null
        &&
        time.hour != null
        &&
        time.minute != null
        &&
        time.second != null
    ){

      final String _hours = Numeric.formatNumberWithinDigits(num: time.hour, digits: 2);
      final String _minutes = Numeric.formatNumberWithinDigits(num: time.minute, digits: 2);
      final String _seconds = Numeric.formatNumberWithinDigits(num: time.second, digits: 2);

      _output = '$_hours:$_minutes:$_seconds';
    }

    return _output;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String generateString_hh_i_mm_ampm_day_dd_mm_yyyy({
    @required BuildContext context,
    @required DateTime time,
  }){

    String _output = '';

    final bool _timeIsEmpty = checkTimeIsEmpty(
      time: time,
    );

    if (_timeIsEmpty == false){
      final String _hh = DateFormat('h').format(time);
      final String _mm = Numeric.formatNumberWithinDigits(num: time.minute, digits: 2);
      final String _ampm = DateFormat('a').format(time);
      final String _day = generateDayName(context, time);
      final String _dd = '${time.day}';
      final String _MM = time.month.toString();
      final String _yyyy = '${time.year}';

      _output = '$_hh:$_mm $_ampm, $_day $_dd $_MM $_yyyy';
    }

    return _output;
  }
  // --------------------
  /*
String generateStringsList_hh_i_mm_i_ss(List<DateTime> times){
  String _output = '';

  if (Mapper.canLoopList(times)){

    for (int i = 0; i<times.length; i++){
      final String _string = generateString_hh_i_mm_i_ss(times[i]);

      _output = '$_output$_string\n';
    }

  }

  return _output;
}
  // --------------------
String generateStringsList_index_hh_i_mm_i_ss({
  @required List<DateTime> times,
  @required List<int> indexes,
}){
  String _output = '';

  if (
      Mapper.canLoopList(times) == true
      &&
      Mapper.canLoopList(indexes) == true
  ){

    for (int i = 0; i<times.length; i++){

      final String _indexString = '${indexes[i]} : ';
      final String _timeStampString =  generateString_hh_i_mm_i_ss(times[i]);

      _output = '${_output+_indexString+_timeStampString}\n';
    }

  }

  return _output;
}
 */
  // -----------------------------------------------------------------------------

  /// CREATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime createDateTime({
    int year,
    int month,
    int day,
    int hour,
    int minute,
    int second,
    int millisecond,
    int microsecond,
  }){

    final DateTime _now = DateTime.now();
    final DateTime _localTime = _now.toLocal();
    final int _year = year ?? _localTime.year;
    final int _month = month ?? _localTime.month;
    final int _day = day ?? _localTime.day;
    final int _hour = hour ?? _localTime.hour;
    final int _minute = minute ?? _localTime.minute;
    final int _second = second ?? _localTime.second;
    final int _millisecond = millisecond ?? _localTime.millisecond;
    final int _microsecond = microsecond ?? _localTime.microsecond;

    return DateTime(_year, _month, _day, _hour, _minute, _second, _millisecond, _microsecond);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime createDate({
    @required int year,
    @required int month,
    @required int day,
  }){
    return
      createDateTime(
        year: year,
        month: month,
        day: day,
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime createClock({
    @required int hour,
    @required int minute,
    int second,
  }){
    return
      createDateTime(
        year: DateTime.now().toLocal().year,
        month: DateTime.now().toLocal().month,
        day: DateTime.now().toLocal().day,
        hour: hour,
        minute: minute,
        second: second ?? 0,//DateTime.now().toLocal().second,
        millisecond: 0,
        microsecond: 0,
      );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime createClockFromSeconds(int seconds){

    DateTime _output;

    if (seconds != null){

      final int _hours = (seconds / 3600).floor();
      final int _remainingSeconds = seconds - (_hours * 3600);
      final int _minutes = (_remainingSeconds / 60).floor();
      final int _seconds = seconds - (60 * _minutes);

      _output = createClock(
        hour: _hours,
        minute: _minutes,
        second: _seconds,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime createDateAndClock({
    @required int year,
    @required int month,
    @required int day,
    @required int hour,
    @required int minute,
    int second,
  }){
    return createDateTime(
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: 0,//second ?? DateTime.now().toLocal().second,
      millisecond: 0,
      microsecond: 0,
    );
  }
  // --------------------
  ///
  static DateTime createDateTimeAfterNumberOfDays({
    @required int days,
  }){

    final DateTime _now = DateTime.now();

    return createDateAndClock(
      year: _now.year,
      month: _now.month,
      day: _now.day + days,
      hour: 0,
      minute: 0,
    );

  }
  // -----------------------------------------------------------------------------

  /// TIME DIFFERENCE

  // --------------------
  /// TESTED : WORKS PERFECT
  static int calculateTimeDifferenceInSeconds({
    @required DateTime from,
    @required DateTime to,
  }){
    int _output;

    if (to != null && from != null){
      _output = to?.difference(from)?.inSeconds;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int calculateTimeDifferenceInMinutes({
    @required DateTime from,
    @required DateTime to,
  }){
    int _output;

    if (to != null && from != null){

      // blog('calculateTimeDifferenceInMinutes : from : $from : to : $to');

      _output = to?.difference(from)?.inMinutes;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int calculateTimeDifferenceInHours({
    @required DateTime from,
    @required DateTime to,
  }){
    int _output;

    if (to != null && from != null){
      _output = to?.difference(from)?.inHours;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int calculateTimeDifferenceInDays({
    @required DateTime from,
    @required DateTime to,
  }){
    int _output;

    if (to != null && from != null){
      _output = to?.difference(from)?.inDays;
    }

    return Numeric.modulus(_output?.toDouble()).toInt();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int calculateTimeDifferenceInWeeks({
    @required DateTime from,
    @required DateTime to,
  }){
    final int _differenceInDays = calculateTimeDifferenceInDays(from: from, to: to);
    return (_differenceInDays / 7).floor();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int calculateTimeDifferenceInMonths({
    @required DateTime from,
    @required DateTime to,
  }){
    final int _differenceInDays = calculateTimeDifferenceInDays(from: from, to: to);
    return (_differenceInDays / 30).floor();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int calculateTimeDifferenceInYears({
    @required DateTime from,
    @required DateTime to,
  }){
    final int _differenceInDays = calculateTimeDifferenceInDays(from: from, to: to);
    return (_differenceInDays / 365).floor();
  }
  // --------------------
  ///
  static String calculateRemainingHoursAndMinutes({
    @required int secondsUntilNow,
  }){

    String _string = '';

    if (secondsUntilNow != null){

      final int _totalMinutes = (secondsUntilNow / 60).floor();
      final int _hours = (_totalMinutes / 60).floor();
      final int _minutesRemaining = _totalMinutes - (_hours*60);

      final String _hourString = Numeric.formatNumberWithinDigits(num: _hours, digits: 2);
      final String _minutesString = Numeric.formatNumberWithinDigits(num: _minutesRemaining, digits: 2);
      _string = '$_hourString:$_minutesString';
    }

    return _string;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGERS

  // --------------------
  ///
  static void blogDateTime(DateTime dateTime){
    _blog('BLOGGING DATE TIME : $dateTime');
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  ///
  static List<DateTime> putTimeInTimes({
    @required DateTime time,
    @required List<DateTime> times,
  }){
    final List<DateTime> _result = times;

    final bool _timesContainIt = checkTimesContainTime(
      times: times,
      time: time,
      // accuracy: 'minute',
    );

    if (_timesContainIt == false){
      _result.add(time);
    }

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime offsetTime({
    @required DateTime time,
    @required String offset, // should look like this +00:00
  }){

    DateTime _output;

    if (time != null && offset != null && offset.length == 6){

      final List<String> _splitOffset = offset.split('');
      // blog('_splitOffset : $_splitOffset');

      final bool _isPlus = _splitOffset[0] == '+';
      // blog('_isPlus : $_isPlus');

      final _hoursString = '${_splitOffset[1]}${_splitOffset[2]}';
      // blog('_hoursString : $_hoursString');
      final int _hours = Numeric.transformStringToInt(_hoursString);
      // blog('_hours : $_hours');

      final _minutesString = '${_splitOffset[4]}${_splitOffset[5]}';
      // blog('_minutesString : $_minutesString');
      final int _minutes = Numeric.transformStringToInt(_minutesString);
      // blog('_minutes : $_minutes');

      _output = _isPlus == true ?
      time.add(Duration(hours: _hours, minutes: _minutes))
          :
      time.subtract(Duration(hours: _hours, minutes: _minutes))
      ;

    }


    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  ///
  static List<DateTime> getHoursAndMinutesFromDateTimes({
    @required List<DateTime> times,
  }){

    List<DateTime> _result = <DateTime>[];

    if (Mapper.checkCanLoopList(times)){

      for (final DateTime time in times){

        final DateTime _hourMinute = createClock(
            hour: time.hour,
            minute: time.minute
        );

        _result = putTimeInTimes(
            time: _hourMinute,
            times: _result
        );

      }

    }

    return _result;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkTimesAreIdentical({
    @required TimeAccuracy accuracy,
    @required DateTime time1,
    @required DateTime time2,
  }){
    bool _areIdentical = false;

    if (time1 == null && time2 == null){
      _areIdentical = true;
    }
    /// XXX - check if both are not nulls
    else if (time1 != null && time2 != null){

      /// A - YEAR
      if (time1.year == time2.year){

        /// A1 - WHEN LEVEL == YEAR
        if (accuracy == TimeAccuracy.year){
          _areIdentical = true;
        }

        /// A2 - ZOOM IN
        else {

          /// B - MONTH
          if (time1.month == time2.month){

            /// B1 - LEVEL == MONTH
            if (accuracy == TimeAccuracy.month){
              _areIdentical = true;
            }

            /// B2 - ZOOM IN
            else {

              /// C - DAY
              if (time1.day == time2.day){

                /// C1 - LEVEL == DAY
                if (accuracy == TimeAccuracy.day){
                  _areIdentical = true;
                }

                /// C2 - ZOOM IN
                else {

                  /// D - HOUR
                  if (time1.hour == time2.hour){

                    /// D1 - LEVEL == HOUR
                    if (accuracy == TimeAccuracy.hour){
                      _areIdentical = true;
                    }

                    /// D2 - ZOOM IN
                    else {

                      /// E - MINUTE
                      if (time1.minute == time2.minute){

                        /// E1 - LEVEL == MINUTE
                        if (accuracy == TimeAccuracy.minute){
                          _areIdentical = true;
                        }

                        /// E2 - ZOOM IN
                        else {

                          /// F - SECOND
                          if (time1.second == time2.second){

                            /// F1 - LEVEL == SECOND
                            if (accuracy == TimeAccuracy.second){
                              _areIdentical = true;
                            }

                            /// F2 - ZOOM IN
                            if (accuracy == TimeAccuracy.millisecond){

                              /// G - MILLISECOND
                              if (time1.millisecond == time2.millisecond){

                                /// G1 - LEVEL == MILLISECOND
                                // if (_level == 'millisecond'){
                                _areIdentical = true;
                                // }

                                // /// G2 - ZOOM IN
                                // if (_level != 'millisecond') {
                                //
                                //
                                // }

                              }

                            }

                            else {

                              /// H - MICROSECOND
                              if (time1.microsecond == time2.microsecond){

                                /// H1 - LEVEL == MICROSECOND
                                if (accuracy == TimeAccuracy.microSecond){
                                  _areIdentical = true;
                                }

                              }

                            }

                          }

                        }

                      }

                    }

                  }

                }

              }


            }

          }

        }

      }

    }

    // print('timesAreTheSame : $_areIdentical : accuracy : ${accuracy} : timeA ${timeA} : timeB ${timeB}');

    return _areIdentical;
  }
  // --------------------
  ///
  static bool checkTimesContainTime({
    @required List<DateTime> times,
    @required DateTime time,
    TimeAccuracy accuracy = TimeAccuracy.minute,
  }){
    bool _contains = false;

    if (Mapper.checkCanLoopList(times) && time != null){

      for (int i =0; i < times.length; i++){

        final bool _timesAreIdentical = checkTimesAreIdentical(
          accuracy: accuracy,
          time1: times[i],
          time2: time,
        );

        if (_timesAreIdentical == true){
          _contains = true;
          break;
        }

      }

    }

    return _contains;
  }
  // --------------------
  ///
  static bool checkTimeIsAfter({
    @required DateTime existing,
    @required DateTime timeAfter,
  }){
    bool _isAfter = false;

    if (existing != null && timeAfter != null){

      _isAfter = timeAfter.isAfter(existing);

    }

    return _isAfter;
  }
  // --------------------
  ///
  static bool checkTimeIsEmpty({
    @required DateTime time,
    // @required TimeAccuracy accuracy,
  }){
    bool _isEmpty = true;

    if (time != null){
      _isEmpty = false;
    }

    return _isEmpty;
  }
  // --------------------
  ///
   static bool objectIsTimeStamp(dynamic object) {
    return object?.runtimeType == Timestamp;
  }
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  static void _blog(dynamic msg){

    assert((){
      if (kDebugMode) {
        print(msg);
      }
      return true;
    }(), '_');

  }
  // --------------------
}
