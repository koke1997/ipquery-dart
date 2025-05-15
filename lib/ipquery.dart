/// A library for interacting with the ipquery.io API.
///
/// This library provides methods to query IP address information including
/// geolocation, ISP details, and risk assessment.
library ipquery;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

/// Formats available for API responses.
enum IpQueryFormat {
  /// Plain text format (simple output)
  text,

  /// JSON format (structured data)
  json,

  /// YAML format (structured data)
  yaml,

  /// XML format (structured data)
  xml
}

/// Converts an [IpQueryFormat] enum to its string representation.
String _formatToString(IpQueryFormat format) {
  switch (format) {
    case IpQueryFormat.text:
      return 'text';
    case IpQueryFormat.json:
      return 'json';
    case IpQueryFormat.yaml:
      return 'yaml';
    case IpQueryFormat.xml:
      return 'xml';
  }
}

/// Main class for interacting with the ipquery.io API.
///
/// Provides methods to query information about IP addresses,
/// including geolocation, ISP details, and risk assessment.
class IpQuery {
  /// Base URL for the ipquery.io API.
  static const String _baseUrl = 'https://api.ipquery.io/';

  /// Query your own public IP address as a string.
  ///
  /// Optionally specify the response [format] (defaults to text).
  ///
  /// ```dart
  /// final ip = await IpQuery.queryOwnIp();
  /// print('My IP: $ip');
  /// ```
  static Future<String> queryOwnIp(
      {IpQueryFormat format = IpQueryFormat.text}) async {
    final response = await http
        .get(Uri.parse(_baseUrl + '?format=${_formatToString(format)}'));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch own IP: ${response.statusCode}');
    }
    return response.body.trim();
  }

  /// Query your own IP address information.
  ///
  /// Optionally specify the response [format] (defaults to JSON).
  ///
  /// Returns an [IpInfo] object for JSON format, or a raw response string for other formats.
  ///
  /// ```dart
  /// final info = await IpQuery.queryOwnIpInfo();
  /// print('Country: ${info.location?.country}');
  /// ```
  static Future<dynamic> queryOwnIpInfo(
      {IpQueryFormat format = IpQueryFormat.json}) async {
    final response = await http
        .get(Uri.parse(_baseUrl + '?format=${_formatToString(format)}'));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch own IP info: ${response.statusCode}');
    }
    if (format == IpQueryFormat.json) {
      return IpInfo.fromJson(jsonDecode(response.body));
    } else {
      return response.body;
    }
  }

  /// Query information for a specific IP address.
  ///
  /// The [ip] parameter should be a valid IPv4 or IPv6 address.
  /// Optionally specify the response [format] (defaults to JSON).
  ///
  /// Returns an [IpInfo] object for JSON format, or a raw response string for other formats.
  ///
  /// ```dart
  /// final info = await IpQuery.querySpecificIp('8.8.8.8');
  /// print('Google DNS is in: ${info.location?.country}');
  /// ```
  static Future<dynamic> querySpecificIp(String ip,
      {IpQueryFormat format = IpQueryFormat.json}) async {
    final response = await http
        .get(Uri.parse(_baseUrl + ip + '?format=${_formatToString(format)}'));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch IP info: ${response.statusCode}');
    }
    if (format == IpQueryFormat.json) {
      return IpInfo.fromJson(jsonDecode(response.body));
    } else {
      return response.body;
    }
  }

  /// Query information for multiple IP addresses (bulk).
  ///
  /// The [ips] parameter should be a list of valid IP addresses.
  /// Optionally specify the response [format] (defaults to JSON).
  ///
  /// Returns a `List<IpInfo>` for JSON format, or a raw response string for other formats.
  ///
  /// ```dart
  /// final results = await IpQuery.queryBulkIps(['8.8.8.8', '1.1.1.1']);
  /// for (var info in results) {
  ///   print('${info.ip} is in ${info.location?.country}');
  /// }
  /// ```
  static Future<dynamic> queryBulkIps(List<String> ips,
      {IpQueryFormat format = IpQueryFormat.json}) async {
    final joined = ips.join(',');
    final response = await http.get(
        Uri.parse(_baseUrl + joined + '?format=${_formatToString(format)}'));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch bulk IP info: ${response.statusCode}');
    }
    if (format == IpQueryFormat.json) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => IpInfo.fromJson(e)).toList();
    } else {
      return response.body;
    }
  }
}
