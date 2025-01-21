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

String hidePhone(String phone) {
  if (phone.startsWith('+7') && phone.length == 12) {
    // Формируем маскированный номер с закрытыми цифрами
    return '+7(${phone.substring(2, 5)})***-**-${phone.substring(10, 12)}';
  }
  return phone;
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

List<MonthlyDTStruct> convertMonthlyJSON(dynamic monthlyJSON) {
  final List<MonthlyDTStruct> monthlyList = [];

  // Преобразуем входящий JSON в Map
  final Map<String, dynamic> monthlyMap =
      Map<String, dynamic>.from(monthlyJSON);

  // Перебираем все ключи (месяцы) из JSON
  monthlyMap.forEach((String monthAndYear, dynamic monthData) {
    // Создаем новый экземпляр MonthlyDTStruct
    final MonthlyDTStruct monthStruct = MonthlyDTStruct(
      // Сохраняем ключ (дату) как monthAndYear
      monthAndYear: monthAndYear,
      // Получаем значения из вложенного объекта
      reward: (monthData['reward'] as num).toDouble(),
      distance: (monthData['distance'] as num).toDouble(),
      averageSpeed: (monthData['averageSpeed'] as num).toDouble(),
    );

    // Добавляем созданную структуру в список
    monthlyList.add(monthStruct);
  });

  return monthlyList;
}

String monthAndYearConvert(String monthAndYear) {
// Разбиваем строку по дефису на год и месяц
  final parts = monthAndYear.split('-');
  if (parts.length != 2) return monthAndYear;

  final year = parts[0];
  final month = parts[1];

  // Словарь соответствия номера месяца и названия
  final monthNames = {
    '01': 'Январь',
    '02': 'Февраль',
    '03': 'Март',
    '04': 'Апрель',
    '05': 'Май',
    '06': 'Июнь',
    '07': 'Июль',
    '08': 'Август',
    '09': 'Сентябрь',
    '10': 'Октябрь',
    '11': 'Ноябрь',
    '12': 'Декабрь'
  };

  // Получаем название месяца из словаря
  final monthName = monthNames[month] ?? month;

  // Возвращаем отформатированную строку
  return '$monthName $year';
}

List<DailyDTStruct> convertDailyJSON(dynamic json) {
  final List<DailyDTStruct> dailyList = [];

  // Преобразуем входящий JSON в Map
  final Map<String, dynamic> dailyMap = Map<String, dynamic>.from(json);

  // Перебираем все ключи (даты) из JSON
  dailyMap.forEach((String date, dynamic dayData) {
    // Создаем новый экземпляр DailyDTStruct
    final DailyDTStruct dayStruct = DailyDTStruct(
      // Сохраняем дату
      day: date,
      // Получаем значения из вложенного объекта
      reward: (dayData['reward'] as num).toDouble(),
      distance: (dayData['distance'] as num).toDouble(),
      averageSpeed: (dayData['averageSpeed'] as num).toDouble(),
    );

    // Добавляем созданную структуру в список
    dailyList.add(dayStruct);
  });

  // Сортируем список по дате в обратном порядке (новые даты первыми)
  dailyList.sort((a, b) => b.day.compareTo(a.day));

  return dailyList;
}

String convertDateFormat(String dateString) {
// Разбиваем строку по дефису
  final parts = dateString.split('-');
  if (parts.length != 3) return dateString;

  // Получаем день и месяц
  final day = parts[2];
  final month = parts[1];

  // Возвращаем в формате ДД.ММ
  return '$day.$month';
}
