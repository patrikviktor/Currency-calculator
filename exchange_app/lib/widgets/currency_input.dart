import 'package:flutter/material.dart';
import 'package:flag/flag.dart';
import '../models/currency.dart';

class CurrencyInput extends StatelessWidget {
  final TextEditingController controller;
  final Currency currency;
  final VoidCallback onCurrencyTap;

  const CurrencyInput({
    super.key,
    required this.controller,
    required this.currency,
    required this.onCurrencyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          GestureDetector(
            onTap: onCurrencyTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: [
                  Flag.fromCode(currency.flagCode, height: 24, width: 24),
                  const SizedBox(width: 8),
                  Text(currency.code,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const Icon(Icons.arrow_drop_up),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
