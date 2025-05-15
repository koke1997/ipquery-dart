// File: lib/ipquery_dart.dart
library ipquery_dart;

export 'src/client.dart';
export 'src/models.dart';

// File: lib/src/models.dart
import 'dart:convert';

class ISPInfo {
  final String? asn;
  final String? org;
  final String? isp;

  ISPInfo({this.asn, this.org, this.isp});

  factory ISPInfo.fromJson(Map<String, dynamic> json) {
    return ISPInfo(
      asn: json['asn'],
      org: json['org'],
      isp: json['isp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'asn': asn,
      'org': org,
      'isp': isp,
    };
  }
}

class LocationInfo {
  final String? country;
  final String? countryCode;
  final String? city;
  final String? state;
  final String? zipcode;
  final double? latitude;
  final double? longitude;
  final String? timezone;
  final String? localtime;

  LocationInfo({
    this.country,
    this.countryCode,
    this.city,
    this.state,
    this.zipcode,
    this.latitude,
    this.longitude,
    this.timezone,
    this.localtime,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    return LocationInfo(
      country: json['country'],
      countryCode: json['country_code'],
      city: json['city'],
      state: json['state'],
      zipcode: json['zipcode'],
      latitude: json['latitude'] != null
          ? (json['latitude'] is int
              ? (json['latitude'] as int).toDouble()
              : json['latitude'])
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] is int
              ? (json['longitude'] as int).toDouble()
              : json['longitude'])
          : null,
      timezone: json['timezone'],
      localtime: json['localtime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'country_code': countryCode,
      'city': city,
      'state': state,
      'zipcode': zipcode,
      'latitude': latitude,
      'longitude': longitude,
      'timezone': timezone,
      'localtime': localtime,
    };
  }
}

class RiskInfo {
  final bool? isMobile;
  final bool? isVpn;
  final bool? isTor;
  final bool? isProxy;
  final bool? isDatacenter;
  final int? riskScore;

  RiskInfo({
    this.isMobile,
    this.isVpn,
    this.isTor,
    this.isProxy,
    this.isDatacenter,
    this.riskScore,
  });

  factory RiskInfo.fromJson(Map<String, dynamic> json) {
    return RiskInfo(
      isMobile: json['is_mobile'],
      isVpn: json['is_vpn'],
      isTor: json['is_tor'],
      isProxy: json['is_proxy'],
      isDatacenter: json['is_datacenter'],
      riskScore: json['risk_score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_mobile': isMobile,
      'is_vpn': isVpn,
      'is_tor': isTor,
      'is_proxy': isProxy,
      'is_datacenter': isDatacenter,
      'risk_score': riskScore,
    };
  }
}

class IPInfo {
  final String ip;
  final ISPInfo? isp;
  final LocationInfo? location;
  final RiskInfo? risk;

  IPInfo({
    required this.ip,
    this.isp,
    this.location,
    this.risk,
  });

  factory IPInfo.fromJson(Map<String, dynamic> json) {
    return IPInfo(
      ip: json['ip'],
      isp: json['isp'] != null ? ISPInfo.fromJson(json['isp']) : null,
      location: json['location'] != null
          ? LocationInfo.fromJson(json['location'])
          : null,
      risk: json['risk'] != null ? RiskInfo.fromJson(json['risk']) : null,
    );
  }

  factory IPInfo.fromRawJson(String str) =>
      IPInfo.fromJson(json.decode(str));

  Map<String, dynamic> toJson() {
    return {
      'ip': ip,
      'isp': isp?.toJson(),
      'location': location?.toJson(),
      'risk': risk?.toJson(),
    };
  }

  String toRawJson() => json.encode(toJson());

  @override
  String toString() {
    return 'IPInfo(ip: $ip, isp: $isp, location: $location, risk: $risk)';
  }
}

// File: lib/src/client.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'models.dart';

const String baseUrl = 'https://api.ipquery.io/';

class IPQueryClient {
  final http.Client _client;
  final String? _proxy;

  IPQueryClient({String? proxy})
      : _proxy = proxy ?? Platform.environment['https_proxy'],
        _client = http.Client();

  /// Fetch information for a specific IP address
  Future<IPInfo> queryIp(String ip) async {
    final response = await _client.get(Uri.parse('$baseUrl$ip'));
    _checkStatus(response);
    return IPInfo.fromRawJson(response.body);
  }

  /// Fetch information for multiple IP addresses
  Future<List<IPInfo>> queryBulk(List<String> ips) async {
    final ipList = ips.join(',');
    final response = await _client.get(Uri.parse('$baseUrl$ipList'));
    _checkStatus(response);
    
    final List<dynamic> decoded = json.decode(response.body);
    return decoded.map((item) => IPInfo.fromJson(item)).toList();
  }

  /// Fetch the public IP address of the current machine
  Future<String> queryOwnIp() async {
    final response = await _client.get(Uri.parse(baseUrl));
    _checkStatus(response);
    return response.body;
  }

  void _checkStatus(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(
          'HTTP error ${response.statusCode}: ${response.body}');
    }
  }

  /// Close the client when done
  void close() {
    _client.close();
  }
}

// File: lib/src/async_client.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'models.dart';

const String asyncBaseUrl = 'https://api.ipquery.io/';

class AsyncIPQueryClient {
  final http.Client _client;
  final String? _proxy;

  AsyncIPQueryClient({String? proxy})
      : _proxy = proxy ?? Platform.environment['https_proxy'],
        _client = http.Client();

  /// Fetch information for a specific IP address
  Future<IPInfo> queryIp(String ip) async {
    final response = await _client.get(Uri.parse('$asyncBaseUrl$ip'));
    _checkStatus(response);
    return IPInfo.fromRawJson(response.body);
  }

  /// Fetch information for multiple IP addresses
  Future<List<IPInfo>> queryBulk(List<String> ips) async {
    final ipList = ips.join(',');
    final response = await _client.get(Uri.parse('$asyncBaseUrl$ipList'));
    _checkStatus(response);
    
    final List<dynamic> decoded = json.decode(response.body);
    return decoded.map((item) => IPInfo.fromJson(item)).toList();
  }

  /// Fetch the public IP address of the current machine
  Future<String> queryOwnIp() async {
    final response = await _client.get(Uri.parse(asyncBaseUrl));
    _checkStatus(response);
    return response.body;
  }

  void _checkStatus(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(
          'HTTP error ${response.statusCode}: ${response.body}');
    }
  }

  /// Close the client when done
  void close() {
    _client.close();
  }
}

// File: example/main.dart
import 'package:ipquery_dart/ipquery_dart.dart';

void main() async {
  final client = IPQueryClient();
  
  try {
    // Query your own IP
    print('Fetching your public IP address...');
    final myIp = await client.queryOwnIp();
    print('Your IP: $myIp');
    
    // Query information about an IP
    final ipInfo = await client.queryIp(myIp);
    print('IP Information: $ipInfo');
    
    // Query multiple IPs
    final bulkInfo = await client.queryBulk(['1.1.1.1', '8.8.8.8']);
    print('Bulk Information:');
    for (var info in bulkInfo) {
      print('- ${info.ip}: ${info.location?.country}');
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    client.close();
  }
}

// File: pubspec.yaml
name: ipquery_dart
description: A Dart SDK for ipquery.io API - A free IP address API built for developers
version: 0.1.0
homepage: https://github.com/yourusername/ipquery-dart

environment:
  sdk: ">=2.17.0 <4.0.0"

dependencies:
  http: ^1.1.0

dev_dependencies:
  test: ^1.24.0
  lints: ^2.1.0
