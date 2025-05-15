import 'package:test/test.dart';
import 'package:ipquery_dart/ipquery.dart';

void main() {
  test('Smoke test: API is reachable and returns valid data', () async {
    // This will fail if the API is down or the library is broken
    final ip = await IpQuery.queryOwnIp();
    expect(ip, isNotEmpty, reason: 'API did not return a valid IP');
    final info = await IpQuery.queryOwnIpInfo();
    expect(info.ip, isNotEmpty, reason: 'API did not return valid IP info');
    expect(info.location, isNotNull, reason: 'Location info missing');
    expect(info.risk, isNotNull, reason: 'Risk info missing');
  });
}
