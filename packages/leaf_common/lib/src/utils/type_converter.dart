part of '../lf_common.dart';

class LFTypeConverter {
  T? convertTo<T>(dynamic value) {
    if (value == null) return null;

    try {
      // String 타입 변환
      if (T == String) {
        return value.toString() as T;
      }

      // int 타입 변환
      if (T == int) {
        if (value is int) return value as T;
        if (value is double) return value.toInt() as T;
        if (value is String) return int.parse(value) as T;
        if (value is bool) return (value ? 1 : 0) as T;
      }

      // double 타입 변환
      if (T == double) {
        if (value is double) return value as T;
        if (value is int) return value.toDouble() as T;
        if (value is String) return double.parse(value) as T;
        if (value is bool) return (value ? 1.0 : 0.0) as T;
      }

      // bool 타입 변환
      if (T == bool) {
        if (value is bool) return value as T;
        if (value is int) return (value != 0) as T;
        if (value is double) return (value != 0.0) as T;
        if (value is String) {
          String lower = value.toLowerCase();
          return (lower == 'true' || lower == '1' || lower == 'yes') as T;
        }
      }

      // num 타입 변환
      if (T == num) {
        if (value is num) return value as T;
        if (value is String) {
          // 정수로 파싱ㄴ 먼저 시도
          if (value.contains('.')) {
            return double.parse(value) as T;
          } else {
            return int.parse(value) as T;
          }
        }
        if (value is bool) return (value ? 1 : 0) as T;
      }

      // List 타입 변환
      if (T.toString().startsWith('List')) {
        if (value is List) return value as T;
        return [value] as T;
      }

      // 직접 캐스팅 시도
      if (value is T) return value;
    } catch (e) {
      return null;
    }
    return null;
  }
}
