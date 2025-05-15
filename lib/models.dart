/// Data models for IP information returned by the ipquery.io API.
library models;

/// Information about the Internet Service Provider.
class IspInfo {
  /// Autonomous System Number
  final String asn;

  /// Organization name
  final String org;

  /// Internet Service Provider name
  final String isp;

  /// Creates a new ISP information object.
  IspInfo({required this.asn, required this.org, required this.isp});

  /// Creates an [IspInfo] from a JSON object.
  factory IspInfo.fromJson(Map<String, dynamic> json) => IspInfo(
        asn: json['asn'] ?? '',
        org: json['org'] ?? '',
        isp: json['isp'] ?? '',
      );

  /// Converts this [IspInfo] to a JSON object.
  Map<String, dynamic> toJson() => {
        'asn': asn,
        'org': org,
        'isp': isp,
      };
}

/// Geographic location information for an IP address.
class LocationInfo {
  /// Country name
  final String country;

  /// Two-letter country code (ISO 3166-1 alpha-2)
  final String countryCode;

  /// City name
  final String city;

  /// State or region name
  final String state;

  /// Postal or ZIP code
  final String zipcode;

  /// Latitude coordinate
  final double latitude;

  /// Longitude coordinate
  final double longitude;

  /// Timezone identifier (e.g., "America/New_York")
  final String timezone;

  /// Local time at the location
  final String localtime;

  /// Creates a new location information object.
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

  /// Creates a [LocationInfo] from a JSON object.
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

  /// Converts this [LocationInfo] to a JSON object.
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

/// Security and risk assessment information for an IP address.
class RiskInfo {
  /// Whether the IP is from a mobile network
  final bool isMobile;

  /// Whether the IP is from a VPN
  final bool isVpn;

  /// Whether the IP is from the Tor network
  final bool isTor;

  /// Whether the IP is from a proxy server
  final bool isProxy;

  /// Whether the IP is from a datacenter
  final bool isDatacenter;

  /// Risk score (0-100, higher means riskier)
  final int riskScore;

  /// Creates a new risk information object.
  RiskInfo({
    required this.isMobile,
    required this.isVpn,
    required this.isTor,
    required this.isProxy,
    required this.isDatacenter,
    required this.riskScore,
  });

  /// Creates a [RiskInfo] from a JSON object.
  factory RiskInfo.fromJson(Map<String, dynamic> json) => RiskInfo(
        isMobile: json['is_mobile'] ?? false,
        isVpn: json['is_vpn'] ?? false,
        isTor: json['is_tor'] ?? false,
        isProxy: json['is_proxy'] ?? false,
        isDatacenter: json['is_datacenter'] ?? false,
        riskScore: json['risk_score'] ?? 0,
      );

  /// Converts this [RiskInfo] to a JSON object.
  Map<String, dynamic> toJson() => {
        'is_mobile': isMobile,
        'is_vpn': isVpn,
        'is_tor': isTor,
        'is_proxy': isProxy,
        'is_datacenter': isDatacenter,
        'risk_score': riskScore,
      };
}

/// Main container for IP address information.
class IpInfo {
  /// The IP address
  final String ip;

  /// ISP information (may be null)
  final IspInfo? isp;

  /// Geographic location information (may be null)
  final LocationInfo? location;

  /// Security and risk assessment information (may be null)
  final RiskInfo? risk;

  /// Creates a new IP information object.
  IpInfo({
    required this.ip,
    this.isp,
    this.location,
    this.risk,
  });

  /// Creates an [IpInfo] from a JSON object.
  factory IpInfo.fromJson(Map<String, dynamic> json) => IpInfo(
        ip: json['ip'] ?? '',
        isp: json['isp'] != null ? IspInfo.fromJson(json['isp']) : null,
        location: json['location'] != null
            ? LocationInfo.fromJson(json['location'])
            : null,
        risk: json['risk'] != null ? RiskInfo.fromJson(json['risk']) : null,
      );

  /// Converts this [IpInfo] to a JSON object.
  Map<String, dynamic> toJson() => {
        'ip': ip,
        'isp': isp?.toJson(),
        'location': location?.toJson(),
        'risk': risk?.toJson(),
      };
}
