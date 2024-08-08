import 'package:flutter/material.dart';

class CustomBottomNavigationBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const CustomBottomNavigationBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? Colors.black : Colors.transparent,
          ),
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          isSelected ? label : '',
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.black,
          ),
        ),
      ],
    );
  }
}
