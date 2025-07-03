import 'package:flutter/material.dart';
import 'package:sportable/Services/utils/globals.dart';

class Search extends StatelessWidget {
  final dynamic controller;
  final dynamic onChanged;
  const Search({super.key, this.onChanged, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      style: TextStyle(color: Globals.secondaryColor, fontSize: Globals.title),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        prefixIcon: Icon(Icons.search, color: Globals.secondaryColor, size: 32),
        hintText: "Search",
        hintStyle: TextStyle(
          fontSize: Globals.title,
          color: Globals.secondaryColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Globals.secondaryColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Globals.secondaryColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Globals.secondaryColor, width: 2),
        ),
      ),
    );
  }
}
