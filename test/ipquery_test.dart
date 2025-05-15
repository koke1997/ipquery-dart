import 'package:test/test.dart';
import 'package:ipquery_dart/ipquery.dart';
import 'package:ipquery_dart/models.dart';

void main() {
  group('IpQuery', () {
    test('queryOwnIp returns a valid IP string (text)', () async {
      final ip = (await IpQuery.queryOwnIp(format: IpQueryFormat.text)).trim();
      expect(ip, isNotEmpty);
      expect(RegExp(r'^\d{1,3}(\.\d{1,3}){3}$').hasMatch(ip), isTrue, reason: 'Returned IP: $ip');
    });

    test('queryOwnIpInfo returns valid IpInfo (json)', () async {
      final info = await IpQuery.queryOwnIpInfo(format: IpQueryFormat.json) as IpInfo;
      expect(info.ip, isNotEmpty);
      expect(info.location, isNotNull);
      expect(info.risk, isNotNull);
    });

    test('queryOwnIpInfo returns YAML', () async {
      final yaml = await IpQuery.queryOwnIpInfo(format: IpQueryFormat.yaml) as String;
      expect(yaml, contains('ip:'));
      expect(yaml, contains('location:'));
    });

    test('queryOwnIpInfo returns XML', () async {
      final xml = await IpQuery.queryOwnIpInfo(format: IpQueryFormat.xml) as String;
      expect(xml, contains('<ip>'));
      expect(xml, contains('<location>'));
    });

    test('querySpecificIp returns correct IpInfo (json)', () async {
      final info = await IpQuery.querySpecificIp('8.8.8.8', format: IpQueryFormat.json) as IpInfo;
      expect(info.ip, '8.8.8.8');
      expect(info.location, isNotNull);
      expect(info.risk, isNotNull);
    });

    test('querySpecificIp returns YAML', () async {
      final yaml = await IpQuery.querySpecificIp('8.8.8.8', format: IpQueryFormat.yaml) as String;
      expect(yaml, contains('ip: 8.8.8.8'));
      expect(yaml, contains('location:'));
    });

    test('querySpecificIp returns XML', () async {
      final xml = await IpQuery.querySpecificIp('8.8.8.8', format: IpQueryFormat.xml) as String;
      expect(xml, contains('<ip>8.8.8.8</ip>'));
      expect(xml, contains('<location>'));
    });

    test('queryBulkIps returns a list of IpInfo (json)', () async {
      final infos = await IpQuery.queryBulkIps(['8.8.8.8', '1.1.1.1'], format: IpQueryFormat.json) as List<IpInfo>;
      expect(infos.length, 2);
      expect(infos[0].ip, '8.8.8.8');
      expect(infos[1].ip, '1.1.1.1');
    });

    test('queryBulkIps returns YAML', () async {
      final yaml = await IpQuery.queryBulkIps(['8.8.8.8', '1.1.1.1'], format: IpQueryFormat.yaml) as String;
      expect(yaml, contains('ip: 8.8.8.8'));
      expect(yaml, contains('ip: 1.1.1.1'));
    });

    test('queryBulkIps returns XML', () async {
      final xml = await IpQuery.queryBulkIps(['8.8.8.8', '1.1.1.1'], format: IpQueryFormat.xml) as String;
      expect(xml, contains('<ip>8.8.8.8</ip>'));
      expect(xml, contains('<ip>1.1.1.1</ip>'));
    });
  });
}
