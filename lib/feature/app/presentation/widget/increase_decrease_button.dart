import 'package:flutter/material.dart';

class IncreaseDecreaseButton extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int> onChanged;

  const IncreaseDecreaseButton({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<IncreaseDecreaseButton> createState() => _IncreaseDecreaseButtonState();
}

class _IncreaseDecreaseButtonState extends State<IncreaseDecreaseButton> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  void _increase() {
    setState(() {
      _currentValue++;
    });
    widget.onChanged(_currentValue);
  }

  void _decrease() {
    if (_currentValue > 0) {
      setState(() {
        _currentValue--;
      });
      widget.onChanged(_currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.remove,
              size: 14,
            ),
            onPressed: _decrease,
          ),
          Text(
            '$_currentValue',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 14,
            ),
            onPressed: _increase,
          ),
        ],
      ),
    );
  }
}