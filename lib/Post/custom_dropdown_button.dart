import 'package:flutter/material.dart';
class CustomDropdownButton extends StatefulWidget {
  final Function(String) onChanged;

  CustomDropdownButton({required this.onChanged});

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String selectedRentOrSell = "Rent";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedRentOrSell,
      items: ["Rent", "Sale"].map((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        );
      }).toList(),
      onChanged: (selectedOption) {
        setState(() {
          selectedRentOrSell = selectedOption ?? "Rent";
          widget.onChanged(selectedRentOrSell);
        });
      },
      underline: Container(
        color: Colors.transparent,
      ),
      style: GoogleFonts.poppins(color: Colors.white),
    );
  }
}
