import 'dart:convert';
import 'package:flutter/material.dart';

class FilterModel {
  final List<String> make;
  final List<String> condition;
  final List<String> storage;
  final List<String> ram;

  FilterModel({
    required this.make,
    required this.condition,
    required this.storage,
    required this.ram,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      make: List<String>.from(json['make']),
      condition: List<String>.from(json['condition']),
      storage: List<String>.from(json['storage']),
      ram: List<String>.from(json['ram']),
    );
  }
}