import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

enum IpQueryFormat { text, json, yaml, xml }

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

class IpQuery {
  static const String _baseUrl = 'https://api.ipquery.io/';

  /// Query your own public IP address as a string (optionally specify format)
  static Future<String> queryOwnIp(
      {IpQueryFormat format = IpQueryFormat.text}) async {
    final response = await http
        .get(Uri.parse(_baseUrl + '?format=${_formatToString(format)}'));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch own IP: ${response.statusCode}');
    }
    return response.body.trim();
  }

  /// Query your own IP info (returns [IpInfo] for JSON, raw string for others)
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

  /// Query info for a specific IP address (returns [IpInfo] for JSON, raw string for others)
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

  /// Query info for multiple IP addresses (bulk, returns List<IpInfo> for JSON, raw string for others)
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
