import 'package:ipquery_dart/ipquery.dart';

void main() async {
  // Change this IP to test any address
  const testIp = '8.8.8.8';

  print('--- Querying your own public IP (text) ---');
  final ownIp = await IpQuery.queryOwnIp();
  print('Your IP: $ownIp');

  print('\n--- Querying your own IP info (JSON) ---');
  final ownInfo = await IpQuery.queryOwnIpInfo();
  print('Your IP info: ${ownInfo.ip}, country: ${ownInfo.location?.country}');

  print('\n--- Querying a specific IP (JSON) ---');
  final info = await IpQuery.querySpecificIp(testIp);
  print('$testIp info: ${info.location?.country}');

  print('\n--- Querying a specific IP (YAML) ---');
  final yaml = await IpQuery.querySpecificIp(testIp, format: IpQueryFormat.yaml);
  print(yaml);

  print('\n--- Bulk query (JSON) ---');
  final bulk = await IpQuery.queryBulkIps([testIp, '1.1.1.1']);
  for (var ipInfo in bulk) {
    print('Bulk: ${ipInfo.ip} - ${ipInfo.location?.country}');
  }
}
