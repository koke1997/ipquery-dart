# ipquery_dart

[![Pub Version](https://img.shields.io/pub/v/ipquery_dart)](https://pub.dev/packages/ipquery_dart)
[![Pub Points](https://img.shields.io/pub/points/ipquery_dart)](https://pub.dev/packages/ipquery_dart/score)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)


A simple Dart SDK for the [ipquery.io](https://ipquery.io) API. Query geolocation, ISP, and risk information for any IP address, your own IP, or in bulk. Supports JSON, YAML, XML, and text formats.

## Documentation

Starting from version 1.0.1, ipquery_dart features comprehensive dartdoc documentation.

To generate the documentation locally:

```bash
dart doc .
```

## Features
- Query your own public IP address
- Query info for a specific IP address
- Bulk query multiple IP addresses
- Choose response format: JSON, YAML, XML, or text

## Installation
Add to your `pubspec.yaml`:
```yaml
dependencies:
  ipquery_dart:
    ipquery_dart: ^1.0.1
```
Run:
```sh
dart pub get
```

###

## Usage Example
```dart
import 'package:ipquery_dart/ipquery.dart';

void main() async {
  // Query your own public IP (as text)
  final ip = await IpQuery.queryOwnIp();
  print('Your IP: $ip');

  // Query your own IP info (as JSON)
  final info = await IpQuery.queryOwnIpInfo();
  print('Your IP info: ${info.ip}, country: ${info.location?.country}');

  // Query a specific IP (as JSON)
  final ipInfo = await IpQuery.querySpecificIp('8.8.8.8');
  print('8.8.8.8 info: ${ipInfo.location?.country}');

  // Query in YAML format
  final yaml = await IpQuery.querySpecificIp('8.8.8.8', format: IpQueryFormat.yaml);
  print('YAML output:\n$yaml');

  // Bulk query (as JSON)
  final bulk = await IpQuery.queryBulkIps(['8.8.8.8', '1.1.1.1']);
  for (var info in bulk) {
    print('Bulk: ${info.ip} - ${info.location?.country}');
  }
}
```

## Main methods
- `IpQuery.queryOwnIp({format})` → String
- Gets your public IP address as a string
- Optional format parameter (defaults to text)
---
- `IpQuery.queryOwnIpInfo({format})` → IpInfo or String
- Gets full information about your public IP
- Returns IpInfo object for JSON format, raw string for others
---
- `IpQuery.querySpecificIp(ip, {format})` → IpInfo or String
- Gets information about a specific IP address
- Returns IpInfo object for JSON format, raw string for others
---
- `IpQuery.queryBulkIps([ips], {format})` → List<IpInfo> or String
- Gets information about multiple IP addresses
- Returns List<IpInfo> for JSON format, raw string for others

## Response formats
```dart
enum IpQueryFormat { text, json, yaml, xml }
```


---
## Data Models
- `IpInfo` - Main container for IP data
- `LocationInfo` - Geographic information (country, city, coordinates)
- `IspInfo` - Network provider information (ASN, organization)
- `RiskInfo` - Security information (proxy detection, risk scores)

See the example directory for more detailed usage examples.

## Important Information
This project is not affiliated with **IPQuery.io**. For more information, please visit their website at [ipquery.io](https://ipQuery.io/)
