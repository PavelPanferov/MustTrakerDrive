import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';

double calculateAverageSpeed(List<dynamic>? json) {
  if (json == null || json.isEmpty) {
    return 0; // Если данных нет, возвращаем 0
  }

  // Сортируем данные по возрастанию дат
  json.sort((a, b) {
    DateTime dateA = DateTime.parse(a['timestamp']);
    DateTime dateB = DateTime.parse(b['timestamp']);
    return dateA.compareTo(dateB);
  });

  // Функция для суммирования расстояний и времени
  double totalDistance = 0.0;
  Duration totalTime = Duration.zero;

  for (int i = 0; i < json.length - 1; i++) {
    LatLng? pointA = LatLng(json[i]['latitude'], json[i]['longitude']);
    LatLng? pointB = LatLng(json[i + 1]['latitude'], json[i + 1]['longitude']);

    totalDistance += calculateDistance(pointA, pointB)!; // Суммируем расстояние

    // Вычисляем время между двумя точками
    DateTime timeA = DateTime.parse(json[i]['timestamp']);
    DateTime timeB = DateTime.parse(json[i + 1]['timestamp']);
    totalTime += timeB.difference(timeA); // Суммируем время
  }

  // Проверяем, чтобы не делить на 0
  if (totalTime.inSeconds == 0) {
    return 0; // Если нет времени, скорость 0
  }

  // Возвращаем среднюю скорость в км/ч
  double averageSpeed = (totalDistance / 1000) / (totalTime.inHours);
  return averageSpeed;
}

double calculateAverageSpeedForDay(
  List<dynamic>? json,
  DateTime day,
) {
  if (json == null || json.isEmpty) {
    return 0;
  }

  // Фильтруем данные для заданного дня
  List<dynamic> dayData = json.where((data) {
    DateTime timestamp = DateTime.parse(data['timestamp']);
    return timestamp.year == day.year &&
        timestamp.month == day.month &&
        timestamp.day == day.day;
  }).toList();

  // Сортируем данные по возрастанию дат
  dayData.sort((a, b) {
    DateTime dateA = DateTime.parse(a['timestamp']);
    DateTime dateB = DateTime.parse(b['timestamp']);
    return dateA.compareTo(dateB);
  });

  // Суммируем расстояния между точками в рамках одного дня
  double totalDistance = 0.0;
  Duration totalTime = Duration.zero;

  for (int i = 0; i < dayData.length - 1; i++) {
    LatLng? pointA = LatLng(dayData[i]['latitude'], dayData[i]['longitude']);
    LatLng? pointB =
        LatLng(dayData[i + 1]['latitude'], dayData[i + 1]['longitude']);

    totalDistance += calculateDistance(pointA, pointB)!; // Суммируем расстояние

    // Вычисляем время между двумя точками
    DateTime timeA = DateTime.parse(dayData[i]['timestamp']);
    DateTime timeB = DateTime.parse(dayData[i + 1]['timestamp']);
    totalTime += timeB.difference(timeA); // Суммируем время
  }

  // Проверяем, чтобы не делить на 0
  if (totalTime.inSeconds == 0) {
    return 0; // Если нет времени, скорость 0
  }

  // Возвращаем среднюю скорость в км/ч
  double averageSpeed = (totalDistance / 1000) / (totalTime.inHours);
  return averageSpeed;
}

double calculateTotalDistance(List<dynamic>? json) {
  if (json == null || json.isEmpty) {
    return 0; // Если данных нет, возвращаем 0
  }

  // Сортируем данные по возрастанию дат
  json.sort((a, b) {
    DateTime dateA = DateTime.parse(a['timestamp']);
    DateTime dateB = DateTime.parse(b['timestamp']);
    return dateA.compareTo(dateB);
  });

  // Суммируем расстояния между точками
  double totalDistance = 0.0;

  for (int i = 0; i < json.length - 1; i++) {
    LatLng? pointA = LatLng(json[i]['latitude'], json[i]['longitude']);
    LatLng? pointB = LatLng(json[i + 1]['latitude'], json[i + 1]['longitude']);
    totalDistance += calculateDistance(
        pointA, pointB)!; // Используем новую функцию calculateDistance
  }

  return totalDistance; // Возвращаем общее расстояние
}

// Функция для расчета расстояния между двумя точками
double? calculateDistance(LatLng? positionOne, LatLng? positionTwo) {
  if (positionOne == null || positionTwo == null)
    return null; // Проверка на null
  var p = 0.017453292519943295; // Конверсия градусов в радианы
  var a = 0.5 -
      math.cos((positionTwo.latitude - positionOne.latitude) * p) / 2 +
      math.cos(positionOne.latitude * p) *
          math.cos(positionTwo.latitude * p) *
          (1 - math.cos((positionTwo.longitude - positionOne.longitude) * p)) /
          2;
  double result = 12742 * math.asin(math.sqrt(a)); // Расчет расстояния
  return result; // Возвращаем результат в километрах
}

DateTime? getFirstDateForDay(
  List<dynamic>? json,
  DateTime day,
) {
  if (json == null || json.isEmpty) {
    return null; // Если данные отсутствуют, возвращаем null
  }

  // Фильтруем данные для заданного дня
  List<dynamic> dayData = json.where((data) {
    DateTime timestamp = DateTime.parse(data['timestamp']);
    return timestamp.year == day.year &&
        timestamp.month == day.month &&
        timestamp.day == day.day;
  }).toList();

  // Если нет данных за этот день, возвращаем null
  if (dayData.isEmpty) {
    return null;
  }

  // Находим минимальную дату
  DateTime firstDate = dayData
      .map((data) => DateTime.parse(data['timestamp']))
      .reduce((a, b) => a.isBefore(b) ? a : b);

  return firstDate; // Возвращаем первую дату за день
}

String hidePhone(String phone) {
  if (phone.startsWith('+7') && phone.length == 12) {
    // Формируем маскированный номер с закрытыми цифрами
    return '+7(${phone.substring(2, 5)})***-**-${phone.substring(10, 12)}';
  }
  return phone;
}

double calculateTotalDistanceForDay(
  List<dynamic>? json,
  DateTime day,
) {
  if (json == null || json.isEmpty) {
    return 0; // Если данных нет, возвращаем 0
  }

  // Фильтруем данные для указанного дня
  List<dynamic> dayData = json.where((data) {
    DateTime timestamp = DateTime.parse(data['timestamp']);
    return timestamp.year == day.year &&
        timestamp.month == day.month &&
        timestamp.day == day.day;
  }).toList();

  // Сортируем данные по возрастанию дат
  dayData.sort((a, b) {
    DateTime dateA = DateTime.parse(a['timestamp']);
    DateTime dateB = DateTime.parse(b['timestamp']);
    return dateA.compareTo(dateB);
  });

  // Суммируем расстояния между точками
  double totalDistance = 0.0;

  for (int i = 0; i < dayData.length - 1; i++) {
    LatLng? pointA = LatLng(dayData[i]['latitude'], dayData[i]['longitude']);
    LatLng? pointB =
        LatLng(dayData[i + 1]['latitude'], dayData[i + 1]['longitude']);
    totalDistance += getDistanceBetweenPoints(pointA, pointB)!;
  }

  return totalDistance; // Возвращаем общее расстояние за день
}

// Функция для расчета расстояния между двумя точками
double? getDistanceBetweenPoints(LatLng? positionOne, LatLng? positionTwo) {
  if (positionOne == null || positionTwo == null)
    return null; // Проверка на null

  var p = 0.017453292519943295; // Конверсия градусов в радианы
  var a = 0.5 -
      math.cos((positionTwo!.latitude - positionOne!.latitude) * p) / 2 +
      math.cos(positionOne.latitude * p) *
          math.cos(positionTwo.latitude * p) *
          (1 - math.cos((positionTwo.longitude - positionOne.longitude) * p)) /
          2;
  double result = 12742 * math.asin(math.sqrt(a)); // Расчет расстояния
  return result; // Возвращаем результат в километрах
}

DateTime? getLastDateForDay(
  List<dynamic>? json,
  DateTime day,
) {
  if (json == null || json.isEmpty) {
    return null; // Если данные отсутствуют, возвращаем null
  }

  // Фильтруем данные для заданного дня
  List<dynamic> dayData = json.where((data) {
    DateTime timestamp = DateTime.parse(data['timestamp']);
    return timestamp.year == day.year &&
        timestamp.month == day.month &&
        timestamp.day == day.day;
  }).toList();

  // Если нет данных за этот день, возвращаем null
  if (dayData.isEmpty) {
    return null;
  }

  // Находим максимальную дату
  DateTime lastDate = dayData
      .map((data) => DateTime.parse(data['timestamp']))
      .reduce((a, b) => a.isAfter(b) ? a : b);

  return lastDate; // Возвращаем последнюю дату за день
}

String phoneClearBel(String phone) {
  // Удаляем все символы, кроме цифр и '+'
  String cleanedPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');

  // Определяем код страны и остальную часть номера
  String countryCode = '';
  String restOfNumber = '';

  if (cleanedPhone.startsWith('+')) {
    if (cleanedPhone.startsWith('+375')) {
      countryCode = '+375';
      restOfNumber = cleanedPhone.substring(4);
    } else {
      // Для других кодов стран (предполагаем, что код страны может быть от 1 до 3 цифр после '+')
      RegExp countryCodeRegex = RegExp(r'^\+\d{1,3}');
      countryCode = countryCodeRegex.stringMatch(cleanedPhone) ?? '';
      restOfNumber = cleanedPhone.substring(countryCode.length);
    }
  } else {
    // Если нет '+', предполагаем, что это локальный номер
    restOfNumber = cleanedPhone;
  }

  // Проверяем длину оставшейся части номера
  if (restOfNumber.length < 5) {
    return cleanedPhone; // Возвращаем как есть, если номер слишком короткий
  }

  // Форматируем номер
  String formattedPhone = countryCode;
  formattedPhone += '(${restOfNumber.substring(0, 2)})';
  formattedPhone += '***-**-${restOfNumber.substring(restOfNumber.length - 2)}';

  return formattedPhone;
}

List<DateTime>? listMonth(
  List<dynamic>? json,
  int limit,
) {
// Проверяем, что список не null и не пустой
  if (json == null || json.isEmpty) {
    return null;
  }

  // Используем Set для хранения уникальных дат по месяцам
  Set<DateTime> uniqueMonths = {};

  for (var data in json) {
    // Преобразуем timestamp в DateTime
    if (data is Map<String, dynamic> && data.containsKey('timestamp')) {
      DateTime timestamp = DateTime.parse(data['timestamp']);
      // Добавляем только месяц и год в Set, без конкретного дня
      DateTime monthOnly = DateTime(timestamp.year, timestamp.month);
      uniqueMonths.add(monthOnly);
    }
  }

  // Преобразуем Set обратно в список и сортируем по возрастанию
  List<DateTime> sortedMonths = uniqueMonths.toList()
    ..sort((a, b) =>
        b.compareTo(a)); // Сортировка по убыванию (от последних месяцев)

  // Применяем лимит, если он указан
  if (limit != null && limit > 0 && sortedMonths.length > limit) {
    sortedMonths = sortedMonths.take(limit).toList();
  }

  return sortedMonths;
}

List<DateTime>? listDaysInMonth(
  List<dynamic>? json,
  DateTime month,
) {
  // Проверяем, что список не null и не пустой
  if (json == null || json.isEmpty) {
    return null;
  }

  // Используем Set для хранения уникальных дней в конкретном месяце
  Set<DateTime> uniqueDays = {};

  for (var data in json) {
    // Преобразуем timestamp в DateTime
    if (data is Map<String, dynamic> && data.containsKey('timestamp')) {
      DateTime timestamp = DateTime.parse(data['timestamp']);

      // Проверяем, что дата относится к указанному месяцу
      if (timestamp.year == month.year && timestamp.month == month.month) {
        // Добавляем полную дату (день, месяц, год) в Set
        DateTime dayOnly =
            DateTime(timestamp.year, timestamp.month, timestamp.day);
        uniqueDays.add(dayOnly);
      }
    }
  }

  // Преобразуем Set обратно в список и сортируем по возрастанию дат
  List<DateTime> sortedDays = uniqueDays.toList()
    ..sort((a, b) =>
        a.compareTo(b)); // Сортировка по возрастанию (от начала к концу месяца)

  return sortedDays;
}

double differenceBetween2month(
  List<dynamic>? json,
  DateTime month,
) {
  if (json == null || json.isEmpty) {
    return 0;
  }

  // Фильтруем данные для заданного месяца
  List<dynamic> currentMonthData = json.where((data) {
    DateTime timestamp = DateTime.parse(data['timestamp']);
    return timestamp.year == month.year && timestamp.month == month.month;
  }).toList();

  List<dynamic> previousMonthData = json.where((data) {
    DateTime timestamp = DateTime.parse(data['timestamp']);
    return timestamp.year == month.year && timestamp.month == month.month - 1;
  }).toList();

  // Сортируем данные по возрастанию дат
  currentMonthData.sort((a, b) {
    DateTime dateA = DateTime.parse(a['timestamp']);
    DateTime dateB = DateTime.parse(b['timestamp']);
    return dateA.compareTo(dateB);
  });

  previousMonthData.sort((a, b) {
    DateTime dateA = DateTime.parse(a['timestamp']);
    DateTime dateB = DateTime.parse(b['timestamp']);
    return dateA.compareTo(dateB);
  });

  // Функция для суммирования расстояний между точками в рамках одного месяца
  double calculateTotalDistance(List<dynamic> data) {
    double totalDistance = 0.0;

    for (int i = 0; i < data.length - 1; i++) {
      LatLng? pointA = LatLng(data[i]['latitude'], data[i]['longitude']);
      LatLng? pointB =
          LatLng(data[i + 1]['latitude'], data[i + 1]['longitude']);
      totalDistance += returnDistanceBetweenTwoPoints(pointA, pointB)!;
    }

    return totalDistance;
  }

  // Вычисляем суммарное расстояние для текущего и предыдущего месяца
  double currentMonthDistance = calculateTotalDistance(currentMonthData);
  double previousMonthDistance = calculateTotalDistance(previousMonthData);

  // Возвращаем разницу между текущим и предыдущим месяцами
  return currentMonthDistance - previousMonthDistance;
}

double? returnDistanceBetweenTwoPoints(
    LatLng? positionOne, LatLng? positionTwo) {
  var p = 0.017453292519943295;
  var a = 0.5 -
      math.cos((positionTwo!.latitude - positionOne!.latitude) * p) / 2 +
      math.cos(positionOne.latitude * p) *
          math.cos(positionTwo.latitude * p) *
          (1 - math.cos((positionTwo.longitude - positionOne.longitude) * p)) /
          2;
  double result = 12742 * math.asin(math.sqrt(a));
  return result; // возвращаем результат в километрах
}

bool phoneValidation(String phone) {
  // Regular expression to match phone number with symbols
  RegExp regExp = RegExp(r'^[\d\+\-\(\) ]+$');

  // Check if the phone number matches the regular expression
  return regExp.hasMatch(phone);
}

String phoneClearRU(String phone) {
  // Удаляем все символы, кроме цифр и '+'
  String cleanedPhone = phone.replaceAll(RegExp(r'[^\d+]'), '');

  // Определяем код страны и остальную часть номера
  String countryCode = '';
  String restOfNumber = '';

  if (cleanedPhone.startsWith('+')) {
    if (cleanedPhone.startsWith('+7')) {
      countryCode = '+7';
      restOfNumber = cleanedPhone.substring(2);
    } else {
      // Для других кодов стран (предполагаем, что код страны может быть от 1 до 3 цифр после '+')
      RegExp countryCodeRegex = RegExp(r'^\+\d{1,3}');
      countryCode = countryCodeRegex.stringMatch(cleanedPhone) ?? '';
      restOfNumber = cleanedPhone.substring(countryCode.length);
    }
  } else {
    // Если нет '+', предполагаем, что это локальный номер
    restOfNumber = cleanedPhone;
  }

  // Проверяем длину оставшейся части номера
  if (restOfNumber.length < 5) {
    return cleanedPhone; // Возвращаем как есть, если номер слишком короткий
  }

  // Форматируем номер
  String formattedPhone = countryCode;
  formattedPhone += '(${restOfNumber.substring(0, 3)})';
  formattedPhone += '***-**-${restOfNumber.substring(restOfNumber.length - 2)}';

  return formattedPhone;
}

DateTime? stringToDateTime(String? string) {
  // convert string to datetime (exemple "1975-02-05T00:00:00.000Z"
  if (string == null) {
    return null;
  }

  try {
    return DateTime.parse(string);
  } catch (e) {
    return null;
  }
}

int? timeToAge(
  DateTime? birthDate,
  DateTime currentTime,
) {
  // Нужно высчитывать количество лет пользователя
  if (birthDate == null) {
    return null;
  }

  final age = currentTime.year - birthDate.year;
  if (currentTime.month < birthDate.month ||
      (currentTime.month == birthDate.month &&
          currentTime.day < birthDate.day)) {
    return age - 1;
  }

  return age;
}

String? createURLfromID(String? avatarBlobId) {
  // Ссылка на аватар формируется так https://api.must.io/api/profile/avatar/{avatarBlobId}.jpg
  if (avatarBlobId != null) {
    return 'https://api.must.io/api/profile/avatar/$avatarBlobId.jpg';
  } else {
    return null;
  }
}

double? completeDriverCounter(DriverCompleteDTStruct? completeDriverDT) {
  int counter = 0;

  if (completeDriverDT?.onBoarding == true) counter += 1;
  if (completeDriverDT?.registration == true) counter += 1;
  if (completeDriverDT?.noBot == true) counter += 1;
  if (completeDriverDT?.experience == true) counter += 1;
  if (completeDriverDT?.dreamJob == true) counter += 1;
  if (completeDriverDT?.employmentStatus == true) counter += 1;
  if (completeDriverDT?.myVehicle == true) counter += 1;
  if (completeDriverDT?.myFleet == true) counter += 1;

  return counter * 12.5;
}

String? convertDriverNumber(String stringDriverNubmer) {
  //   // convert number(5008189924)to this mask ## ## ###### like this (50 08 189924)
  if (stringDriverNubmer.length != 10) {
    return null;
  }

  String maskedNumber = stringDriverNubmer.substring(0, 2) +
      ' ' +
      stringDriverNubmer.substring(2, 4) +
      ' ' +
      stringDriverNubmer.substring(4);

  return maskedNumber;
}

String? ageConvertString(int userAge) {
  // Получаем последние две цифры возраста
  int lastTwoDigits = userAge % 100;

  // Проверяем, попадает ли возраст в диапазон 11-14
  if (lastTwoDigits >= 11 && lastTwoDigits <= 14) {
    return 'лет';
  }

  // Получаем последнюю цифру возраста
  int lastDigit = userAge % 10;

  switch (lastDigit) {
    case 1:
      return 'год';
    case 2:
    case 3:
    case 4:
      return 'года';
    default:
      return 'лет';
  }
}
