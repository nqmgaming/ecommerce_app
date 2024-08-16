import 'package:ecommerce_app/core/constants/colors_constant.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.black.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? ColorsConstant.blackColor : ColorsConstant.transparentColor,
            ),
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
            child: Icon(
              icon,
              color: isSelected ? ColorsConstant.whiteColor : ColorsConstant.blackColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 6),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              isSelected ? label : '',
              style: const TextStyle(
                color: ColorsConstant.blackColor,
                fontWeight: FontWeight.bold,
                fontSize: 9,
                letterSpacing: 0.1
              ),
            ),
          ),
        ],
      ),
    );
  }
}
