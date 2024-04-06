import 'package:flutter_test/flutter_test.dart';
import 'package:social_discovery_group/features/states_selector/data/models/address_model.dart';

void main() {
  group('Address', () {
    const jsonStr = '[{"id": 1, "value": "USA"}]';
    const map = {"id": 1, "value": "USA"};

    test('fromJson returns correct Address', () {
      final address = Address.fromJson(map);
      expect(address.id, 1);
      expect(address.value, 'USA');
    });

    test('toJson returns correct map', () {
      final address = Address(id: 1, value: 'USA');
      expect(address.toJson(), map);
    });

    test('addressesFromJson returns correct list of Address', () {
      final addresses = Address.addressesFromJson(jsonStr);
      expect(addresses, isA<List<Address>>());
      expect(addresses.first.id, 1);
      expect(addresses.first.value, 'USA');
    });

    test('addressesFromJson throws FormatException when json is not a list', () {
      expect(() => Address.addressesFromJson('{"id": 1, "value": "USA"}'), throwsFormatException);
    });
  });
}
