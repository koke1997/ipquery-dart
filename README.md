# ipquery_dart

![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/koke1997/ipquery-dart/total)

A simple Dart SDK for the [ipquery.io](https://ipquery.io) API. Query geolocation, ISP, and risk information for any IP address, your own IP, or in bulk. Supports JSON, YAML, XML, and text formats.

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
    path: .
```
Run:
```sh
dart pub get
```

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

## API
- `IpQuery.queryOwnIp({format})` → String
- `IpQuery.queryOwnIpInfo({format})` → IpInfo or String
- `IpQuery.querySpecificIp(ip, {format})` → IpInfo or String
- `IpQuery.queryBulkIps([ips], {format})` → List<IpInfo> or String

See the `example/` directory for more.

---
MIT License


---
## Important Information
This project is not affiliated with **IPQuery.io**. For more information, please visit their website at [ipquery.io](https://ipQuery.io/)
