import 'package:flag/flag.dart';

class Currency {
  final String code;
  final String name;
  final FlagsCode flagCode;
  final double rate;

  Currency({
    required this.code,
    required this.name,
    required this.flagCode,
    required this.rate,
  });
}

final List<Currency> currencies = [
  Currency(code: 'EUR', name: 'Euro', flagCode: FlagsCode.EU, rate: 1.0),
  Currency(
      code: 'USD',
      name: 'Americký dolár',
      flagCode: FlagsCode.US,
      rate: 1.0274),
  Currency(
      code: 'GBP',
      name: 'Britská libra',
      flagCode: FlagsCode.GB,
      rate: 0.83136),
  Currency(
      code: 'JPY', name: 'Japonský jen', flagCode: FlagsCode.JP, rate: 158.87),
  Currency(
      code: 'CHF',
      name: 'Švajčiarsky frank',
      flagCode: FlagsCode.CH,
      rate: 0.9393),
  Currency(
      code: 'BGN', name: 'Bulharský lev', flagCode: FlagsCode.BG, rate: 1.9558),
  Currency(
      code: 'CZK', name: 'Česká koruna', flagCode: FlagsCode.CZ, rate: 25.254),
  Currency(
      code: 'DKK', name: 'Dánska koruna', flagCode: FlagsCode.DK, rate: 7.4618),
  Currency(
      code: 'HUF',
      name: 'Maďarský forint',
      flagCode: FlagsCode.HU,
      rate: 408.43),
  Currency(
      code: 'PLN', name: 'Poľský zlotý', flagCode: FlagsCode.PL, rate: 4.2255),
  Currency(
      code: 'RON', name: 'Rumunský leu', flagCode: FlagsCode.RO, rate: 4.9769),
  Currency(
      code: 'SEK',
      name: 'Švédska koruna',
      flagCode: FlagsCode.SE,
      rate: 11.481),
  Currency(
      code: 'ISK', name: 'Islandská koruna', flagCode: FlagsCode.IS, rate: 146),
  Currency(
      code: 'NOK',
      name: 'Nórska koruna',
      flagCode: FlagsCode.NO,
      rate: 11.7138),
  Currency(
      code: 'TRY', name: 'Turecká líra', flagCode: FlagsCode.TR, rate: 36.9718),
  Currency(
      code: 'AUD',
      name: 'Austrálsky dolár',
      flagCode: FlagsCode.AU,
      rate: 1.6671),
  Currency(
      code: 'BRL',
      name: 'Brazílsky real',
      flagCode: FlagsCode.BR,
      rate: 6.0119),
  Currency(
      code: 'CAD',
      name: 'Kanadský dolár',
      flagCode: FlagsCode.CA,
      rate: 1.5051),
  Currency(
      code: 'CNY', name: 'Čínsky jüan', flagCode: FlagsCode.CN, rate: 7.45),
  Currency(
      code: 'HKD',
      name: 'Hongkongský dolár',
      flagCode: FlagsCode.HK,
      rate: 8.0072),
  Currency(
      code: 'IDR',
      name: 'Indonézska rupia',
      flagCode: FlagsCode.ID,
      rate: 16864.57),
  Currency(
      code: 'ILS',
      name: 'Izraelský nový šekel',
      flagCode: FlagsCode.IL,
      rate: 3.6992),
  Currency(
      code: 'INR',
      name: 'Indická rupia',
      flagCode: FlagsCode.IN,
      rate: 89.4513),
  Currency(
      code: 'KRW',
      name: 'Juhokórejský won',
      flagCode: FlagsCode.KR,
      rate: 1504.01),
  Currency(
      code: 'MXN', name: 'Mexické peso', flagCode: FlagsCode.MX, rate: 21.5073),
  Currency(
      code: 'MYR',
      name: 'Malajzijský ringgit',
      flagCode: FlagsCode.MY,
      rate: 4.5976),
  Currency(
      code: 'NZD',
      name: 'Novozélandský dolár',
      flagCode: FlagsCode.NZ,
      rate: 1.8424),
  Currency(
      code: 'PHP',
      name: 'Filipínske peso',
      flagCode: FlagsCode.PH,
      rate: 60.158),
  Currency(
      code: 'SGD',
      name: 'Singapurský dolár',
      flagCode: FlagsCode.SG,
      rate: 1.4024),
  Currency(
      code: 'THB', name: 'Thajský baht', flagCode: FlagsCode.TH, rate: 34.932),
  Currency(
      code: 'ZAR',
      name: 'Juhoafrický rand',
      flagCode: FlagsCode.ZA,
      rate: 19.3445),
];
