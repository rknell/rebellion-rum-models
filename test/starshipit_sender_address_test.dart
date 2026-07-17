import 'package:rebellion_rum_models/rebellion_rum_models.dart';
import 'package:test/test.dart';

void main() {
  group('StarShipIt sender address defaults', () {
    test('shipping quote sender splits unit from street', () {
      final request = ShippingQuoteRequestModel(
        address: const StartShipItRateDestinationAddressModel(
          street: '1 Sample Street',
          suburb: 'Brisbane',
          state: 'QLD',
          postCode: '4000',
          countryCode: 'AU',
        ),
        items: const {'SKU': 1},
      );

      expect(request.sender.building, equals('Unit 27'));
      expect(request.sender.street, equals('3 Octal Street'));
    });

    test('rates request default sender serializes building separately', () {
      final request = StartShipItGetRatesRequestModel(
        destination: const StartShipItRateDestinationAddressModel(
          street: '1 Sample Street',
          suburb: 'Brisbane',
          state: 'QLD',
          postCode: '4000',
          countryCode: 'AU',
        ),
        packages: const [
          StartShipItRatePackageModel(
            weight: 1,
            height: 1,
            width: 1,
            length: 1,
          ),
        ],
      );

      expect(request.toJson()['sender'], containsPair('building', 'Unit 27'));
      expect(
        request.toJson()['sender'],
        containsPair('street', '3 Octal Street'),
      );
    });
  });
}
