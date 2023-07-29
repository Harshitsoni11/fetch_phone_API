

import 'package:assignment_flutter/Model/FilterModel.dart';
import 'package:assignment_flutter/Services/phone_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();


}

class _FilterPageState extends State<FilterPage> {

  PhoneService phoneService=PhoneService();


  @override
  void initState() {
    super.initState();



  }
  @override
  Widget build(BuildContext context) {


    return  FractionallySizedBox(
      heightFactor: 0.8,
      child: Column(
        children: [
          const Row(
            // mainAxisAlignment: MainAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Padding(
                  padding: EdgeInsets.only(left: 10.0,top: 15.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Filters',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text('Clear Filter',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    fontSize: 15,
                    color: Colors.red,
                  ), textAlign: TextAlign.right,),
                ),
              ]

          ),

          SizedBox(height: 5,),
          const Padding(
            padding: EdgeInsets.only(top: 8.0,left: 8.0),
            child: Align(alignment: Alignment.topLeft,child: Text('Brand',style: TextStyle(fontSize: 15),)),
          ),


         FutureBuilder(
    future: phoneService.fetchFilterModel(),
    builder: (context, AsyncSnapshot<FilterModel> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}');
    } else if (!snapshot.hasData) {
    return Text('No data available.');
    } else {
      List<String> makeFiltersWithAll = ['All', ...snapshot.data!.make];
    return Filterdata(alldata: makeFiltersWithAll);
    }
    },
    ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0,left: 8.0),
            child: Align(alignment: Alignment.topLeft,child: Text('Ram',style: TextStyle(fontSize: 15),)),
          ),
          FutureBuilder(
            future: phoneService.fetchFilterModel(),
            builder: (context, AsyncSnapshot<FilterModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return Text('No data available.');
              } else {
                List<String> makeFiltersWithAll = ['All', ...snapshot.data!.ram];
                return Filterdata(alldata: makeFiltersWithAll);
              }
            },
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0,left: 8.0),
            child: Align(alignment: Alignment.topLeft,child: Text('Storage',style: TextStyle(fontSize: 15),)),
          ),
          FutureBuilder(
            future: phoneService.fetchFilterModel(),
            builder: (context, AsyncSnapshot<FilterModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return Text('No data available.');
              } else {
                List<String> makeFiltersWithAll = ['All', ...snapshot.data!.storage];
                return Filterdata(alldata: makeFiltersWithAll);
              }
            },
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0,left: 8.0),
            child: Align(alignment: Alignment.topLeft,child: Text('Conditions',style: TextStyle(fontSize: 15),)),
          ),
          FutureBuilder(
            future: phoneService.fetchFilterModel(),
            builder: (context, AsyncSnapshot<FilterModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return Text('No data available.');
              } else {
                List<String> makeFiltersWithAll = ['All', ...snapshot.data!.condition];
                return Filterdata(alldata: makeFiltersWithAll);
              }
            },
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: (){
                Navigator.pop(context);
            },style: ElevatedButton.styleFrom(
              fixedSize: Size(double.maxFinite, 40),
              primary: const Color(0xff17173d),// Set the desired width and height
            ), child: const Text('Apply',)),
          )






        ],
      ),
    );
  }
}


class Filterdata extends StatefulWidget {
  List<String> alldata;
  Filterdata({required this.alldata});

  @override
  State<Filterdata> createState() => _FilterdataState();
}

class _FilterdataState extends State<Filterdata> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // Display 'make' filters
            ...widget.alldata.map((item) => Padding(
              padding: const EdgeInsets.all(5.0),
              child: FilterChip(label: Text(item), onSelected: (bool value) {  },),
            )).toList(),

          ],
        ),
      ),
    );
  }
}


