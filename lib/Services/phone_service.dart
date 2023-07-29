import 'dart:convert';

import 'package:assignment_flutter/Model/FilterModel.dart';
import 'package:assignment_flutter/Model/ListingModel.dart';
import 'package:http/http.dart' as http;

import 'app_uri.dart';

class PhoneService{
  Future<List<Listing>> fetchListings() async {
    final response = await http.get(Uri.parse(AppUri.listurl));
    if (response.statusCode == 200) {
      final jsonListings = json.decode(response.body)['listings'];
      return List<Listing>.from(jsonListings.map((jsonListing) => Listing.fromJson(jsonListing)));
    } else {
      throw Exception('Failed to load listings');
    }
  }


  Future<FilterModel> fetchFilterModel() async {

    final response = await http.get(Uri.parse(AppUri.filterurl));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
        print(jsonData);
        return FilterModel.fromJson(jsonData['filters']);

    } else {
      throw Exception('Failed to load filter data');
    }
  }
}