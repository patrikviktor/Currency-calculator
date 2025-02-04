import 'package:flutter/material.dart';
import '../models/currency.dart';
import 'package:flag/flag.dart';

class CurrencyPickerSheet extends StatefulWidget {
  final Currency selectedCurrency;
  final Function(Currency) onSelect;

  const CurrencyPickerSheet({
    super.key,
    required this.selectedCurrency,
    required this.onSelect,
  });

  @override
  State<CurrencyPickerSheet> createState() => _CurrencyPickerSheetState();
}

class _CurrencyPickerSheetState extends State<CurrencyPickerSheet> {
  final TextEditingController _searchController = TextEditingController();
  late List<Currency> filteredCurrencies;

  @override
  void initState() {
    super.initState();
    filteredCurrencies = currencies;
  }

  void _filterCurrencies(String query) {
    setState(() {
      final lowerQuery = query.toLowerCase();
      filteredCurrencies = currencies.where((currency) {
        return currency.name.toLowerCase().contains(lowerQuery) ||
            currency.code.toLowerCase().contains(lowerQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Vyhľadaj menu...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderSide: BorderSide.none),
                isDense: true,
              ),
              onChanged: _filterCurrencies,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCurrencies.length,
              itemBuilder: (context, index) {
                final currency = filteredCurrencies[index];
                return ListTile(
                  leading:
                      Flag.fromCode(currency.flagCode, height: 24, width: 24),
                  title: Text('${currency.code} - ${currency.name}'),
                  selected: currency.code == widget.selectedCurrency.code,
                  onTap: () => widget.onSelect(currency),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
