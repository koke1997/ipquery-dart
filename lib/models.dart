import 'dart:convert';

class IspInfo {
  final String asn;
  final String org;
  final String isp;

  IspInfo({required this.asn, required this.org, required this.isp});

  factory IspInfo.fromJson(Map<String, dynamic> json) => IspInfo(
        asn: json['asn'] ?? '',
        org: json['org'] ?? '',
        isp: json['isp'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'asn': asn,
        'org': org,
        'isp': isp,
      };
}

class LocationInfo {
  final String country;
  final String countryCode;
  final String city;
  final String state;
  final String zipcode;
  final double latitude;
  final double longitude;
  final String timezone;
  final String localtime;

  LocationInfo({
    required this.country,
    required this.countryCode,
    required this.city,
    required this.state,
    required this.zipcode,
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.localtime,
  });

  factory LocationInfo.fromJson(Map<String, dynamic> json) => LocationInfo(
        country: json['country'] ?? '',
        countryCode: json['country_code'] ?? '',
        city: json['city'] ?? '',
        state: json['state'] ?? '',
        zipcode: json['zipcode'] ?? '',
        latitude: (json['latitude'] ?? 0).toDouble(),
        longitude: (json['longitude'] ?? 0).toDouble(),
        timezone: json['timezone'] ?? '',
        localtime: json['localtime'] ?? '',
      );

  Map<String, dynamic> toJson() => {
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

class RiskInfo {
  final bool isMobile;
  final bool isVpn;
  final bool isTor;
  final bool isProxy;
  final bool isDatacenter;
  final int riskScore;

  RiskInfo({
    required this.isMobile,
    required this.isVpn,
    required this.isTor,
    required this.isProxy,
    required this.isDatacenter,
    required this.riskScore,
  });

  factory RiskInfo.fromJson(Map<String, dynamic> json) => RiskInfo(
        isMobile: json['is_mobile'] ?? false,
        isVpn: json['is_vpn'] ?? false,
        isTor: json['is_tor'] ?? false,
        isProxy: json['is_proxy'] ?? false,
        isDatacenter: json['is_datacenter'] ?? false,
        riskScore: json['risk_score'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'is_mobile': isMobile,
        'is_vpn': isVpn,
        'is_tor': isTor,
        'is_proxy': isProxy,
        'is_datacenter': isDatacenter,
        'risk_score': riskScore,
      };
}

class IpInfo {
  final String ip;
  final IspInfo? isp;
  final LocationInfo? location;
  final RiskInfo? risk;

  IpInfo({
    required this.ip,
    this.isp,
    this.location,
    this.risk,
  });

  factory IpInfo.fromJson(Map<String, dynamic> json) => IpInfo(
        ip: json['ip'] ?? '',
        isp: json['isp'] != null ? IspInfo.fromJson(json['isp']) : null,
        location: json['location'] != null ? LocationInfo.fromJson(json['location']) : null,
        risk: json['risk'] != null ? RiskInfo.fromJson(json['risk']) : null,
      );

  Map<String, dynamic> toJson() => {
        'ip': ip,
        'isp': isp?.toJson(),
        'location': location?.toJson(),
        'risk': risk?.toJson(),
      };
}
