import 'package:flutter/material.dart';
import '../models/currency.dart';
import '../widgets/currency_input.dart';
import '../widgets/currency_output.dart';
import '../widgets/currency_picker_sheet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiKey = 'd7e853a4-829e-4b8e-9e7d-42f2904a1c92';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});
  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController _baseController = TextEditingController(text: '');
  final TextEditingController _targetController = TextEditingController();

  Currency fromCurrency = currencies[0];
  Currency toCurrency = currencies[1];

  bool emptyInput = true;
  String dateFrom = '';
  double exchangeRate = 1.0;
  bool isLoading = false;

  bool _isEditingBase = false;
  bool _isEditingTarget = false;

  void loadDate() async {
    final uri = Uri.parse('http://localhost:3000/rates');
    try {
      final response = await http.get(uri, headers: {
        'api-key': apiKey,
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rateMap = data['rate'] as Map<String, dynamic>;
        double targetRate = (rateMap[toCurrency.code] as double).toDouble();
        double baseRate = (rateMap[fromCurrency.code] as double).toDouble();

        setState(() {
          exchangeRate = targetRate / baseRate;
          dateFrom = data['date'] as String;
        });
      } else {
        setState(() {
          dateFrom = 'Neznámy dátum';
        });
      }
    } catch (e) {
      setState(() {
        dateFrom = 'Neznámy dátum';
      });
    }
  }

  Future<void> fetchExchangeRate() async {
    setState(() {
      // isLoading = true;
    });
    final query = 'currency=${fromCurrency.code},${toCurrency.code}';
    final uri = Uri.parse('http://localhost:3000/rates?$query');
    try {
      final response = await http.get(uri, headers: {
        'api-key': apiKey,
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rateMap = data['rate'] as Map<String, dynamic>;
        double targetRate = (rateMap[toCurrency.code] as num).toDouble();
        double baseRate = (rateMap[fromCurrency.code] as num).toDouble();

        exchangeRate = targetRate / baseRate;
      } else {
        exchangeRate = toCurrency.rate / fromCurrency.rate;
      }
    } catch (e) {
      exchangeRate = toCurrency.rate / fromCurrency.rate;
    }
    setState(() {
      // isLoading = false;
    });
  }

  Future<void> _convertFromBase() async {
    if (_baseController.text.isEmpty) return;
    if (_isEditingTarget) return;
    _isEditingBase = true;
    await fetchExchangeRate();
    double baseAmount = double.tryParse(_baseController.text) ?? 0;
    double targetAmount = baseAmount * exchangeRate;
    _targetController.text = targetAmount.toStringAsFixed(2);
    _isEditingBase = false;
    setState(() {});
  }

  Future<void> _convertFromTarget() async {
    if (_targetController.text.isEmpty) return;
    if (_isEditingBase) return;
    _isEditingTarget = true;
    await fetchExchangeRate();
    double targetAmount = double.tryParse(_targetController.text) ?? 0;
    double baseAmount = targetAmount / exchangeRate;
    _baseController.text = baseAmount.toStringAsFixed(2);
    _isEditingTarget = false;
    setState(() {});
  }

  void _swapCurrencies() {
    setState(() {
      var temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
    });
    _convertFromBase();
  }

  void _showCurrencyPicker(bool isFrom) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.75,
        child: CurrencyPickerSheet(
          selectedCurrency: isFrom ? fromCurrency : toCurrency,
          onSelect: (currency) {
            setState(() {
              if (isFrom) {
                fromCurrency = currency;
              } else {
                toCurrency = currency;
              }
            });
            _convertFromBase();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadDate();
    _baseController.addListener(() {
      if (!_isEditingTarget) {
        _convertFromBase();
      }
    });
    _targetController.addListener(() {
      if (!_isEditingBase) {
        _convertFromTarget();
      }
    });
  }

  @override
  void dispose() {
    _baseController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Text('Menová kalkulačka',
                        style: textTheme.headlineLarge)),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Text('Kurzy platné od: $dateFrom',
                            style: textTheme.bodyMedium),
                      ]),
                      const SizedBox(height: 16),
                      const Text('Zadajte sumu:',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      CurrencyInput(
                        controller: _baseController,
                        currency: fromCurrency,
                        onCurrencyTap: () => _showCurrencyPicker(true),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: _swapCurrencies,
                            icon: const Icon(Icons.swap_horiz),
                          ),
                        ],
                      ),
                      const Text('Prepočet:',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      CurrencyOutput(
                        controller: _targetController,
                        currency: toCurrency,
                        onCurrencyTap: () => _showCurrencyPicker(false),
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '1.00000 ${fromCurrency.code} ',
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic),
                            ),
                            TextSpan(
                              text:
                                  '= ${exchangeRate.toStringAsFixed(5)} ${toCurrency.code}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF0049e6),
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _convertFromBase,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF01042D),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Prepočítať',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ],
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
