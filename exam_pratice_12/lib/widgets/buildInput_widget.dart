import 'package:flutter/material.dart';

class BuildinputWidget extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;
  final bool show;
  final VoidCallback? toggle;
  final TextInputType keyboardType;

  const BuildinputWidget({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    this.show = false,
    this.toggle,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textAlignVertical: TextAlignVertical.center,
        obscureText: isPassword ? !show : false,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: Colors.blue),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(show ? Icons.visibility : Icons.visibility_off),
                  onPressed: toggle,
                )
              : null,
        ),
      ),
    );
  }
}