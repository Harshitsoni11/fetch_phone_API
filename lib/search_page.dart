
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Services/app_uri.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

    List<String> searchResults = [];
  List<String> searchmodel=[];

  Future<void> _makeAPICall(String query) async {

    // Make the POST API call using http package

    var data={
      'searchModel':query.toString()
    };
    var response = await http.post(
        Uri.parse(AppUri.searchmodelurl,),body: data

    );

    print(response.body);
    if (response.statusCode == 200) {

      // If the API call is successful, parse the response and update the UI

      final data = json.decode(response.body);

      List<String> makes = List<String>.from(data['makes']);
      List<String> models = List<String>.from(data['models']);


      setState(() {
        searchResults = makes;
        searchmodel=models;

      });
    } else {
      // Handle API error here
      setState(() {
        searchResults.clear();
        searchmodel.clear();
      });
    }
  }


  void _onSearchChanged(String query) {
    _makeAPICall(query);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff17173d),
          leading: IconButton(
            icon: const Icon(
              Icons.segment_outlined,
              size: 30,
            ), // Add your prefix icon here
            onPressed: () {
              // Implement action for the prefix icon here
            },
          ),
          title: const Center(child: Text('Oru Phones')),
          actions: const [
            Center(child: Text('India')),
            Icon(
              Icons.location_on_rounded,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.notifications,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ), //
          ],
          bottom: PreferredSize(
            preferredSize: const Size(30, 30),
            child: TextFormField(

              onTap: (){

              },
              onChanged: (query) => _onSearchChanged(query),

              decoration: InputDecoration(
                suffixIcon: IconButton(onPressed: (){
                  Navigator.pop(context);
                },icon: Icon(Icons.clear),),

                filled: true,
                fillColor: Colors.white,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                hintText: 'Search with make and model',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(50.0)),
              ),),
          )
      ),
      body: searchResults.isNotEmpty? SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Brand',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: searchResults.map((result) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(result.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              Text(
                'Mobile Model',
                style: TextStyle(fontSize: 15),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: searchmodel.map((model) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(model,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ) : Center(child: CircularProgressIndicator()),
    );

  }
}

//
// class _SearchBarState extends State<SearchBar> {
//
//
//   List<String> searchResults = [];
//   List<String> searchmodel=[];
//
//   Future<void> _makeAPICall(String query) async {
//
//     // Make the POST API call using http package
//
//     var data={
//       'searchModel':query.toString()
//     };
//     var response = await http.post(
//         Uri.parse(AppUri.searchmodelurl,),body: data
//
//     );
//
//     print(response.body);
//     if (response.statusCode == 200) {
//
//       // If the API call is successful, parse the response and update the UI
//
//       final data = json.decode(response.body);
//
//       List<String> makes = List<String>.from(data['makes']);
//       List<String> models = List<String>.from(data['models']);
//
//
//       setState(() {
//         searchResults = makes;
//         searchmodel=models;
//
//       });
//     } else {
//       // Handle API error here
//       setState(() {
//         searchResults.clear();
//         searchmodel.clear();
//       });
//     }
//   }
//
//
//   void _onSearchChanged(String query) {
//     _makeAPICall(query);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Text('Hello');
//     // return Scaffold(
//     //   // appBar: AppBar(
//     //   //     backgroundColor: const Color(0xff17173d),
//     //   //     leading: IconButton(
//     //   //       icon: const Icon(
//     //   //         Icons.segment_outlined,
//     //   //         size: 30,
//     //   //       ), // Add your prefix icon here
//     //   //       onPressed: () {
//     //   //         // Implement action for the prefix icon here
//     //   //       },
//     //   //     ),
//     //   //     title: const Center(child: Text('Oru Phones')),
//     //   //     actions: const [
//     //   //       Center(child: Text('India')),
//     //   //       Icon(
//     //   //         Icons.location_on_rounded,
//     //   //         size: 30,
//     //   //       ),
//     //   //       SizedBox(
//     //   //         width: 10,
//     //   //       ),
//     //   //       Icon(
//     //   //         Icons.notifications,
//     //   //         size: 30,
//     //   //       ),
//     //   //       SizedBox(
//     //   //         width: 10,
//     //   //       ), //
//     //   //     ],
//     //   //     bottom: PreferredSize(
//     //   //       preferredSize: const Size(30, 30),
//     //   //       child: TextFormField(
//     //   //
//     //   //         onTap: (){
//     //   //
//     //   //         },
//     //   //         onChanged: (query) => _onSearchChanged(query),
//     //   //
//     //   //         decoration: InputDecoration(
//     //   //           suffixIcon: IconButton(onPressed: (){
//     //   //             Navigator.pop(context);
//     //   //           },icon: Icon(Icons.clear),),
//     //   //           prefixIcon: IconButton(
//     //   //             icon: const Icon(
//     //   //               Icons.search,
//     //   //               color: Colors.grey,
//     //   //             ), onPressed: () {  },
//     //   //           ),
//     //   //           filled: true,
//     //   //           fillColor: Colors.white,
//     //   //           contentPadding:
//     //   //           const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//     //   //           hintText: 'Search with make and model',
//     //   //           enabledBorder: OutlineInputBorder(
//     //   //             borderRadius: BorderRadius.circular(50.0),
//     //   //             borderSide: const BorderSide(
//     //   //               color: Colors.white,
//     //   //               width: 2.0,
//     //   //             ),
//     //   //           ),
//     //   //           border: OutlineInputBorder(
//     //   //               borderSide: const BorderSide(
//     //   //                 width: 2,
//     //   //                 color: Colors.white,
//     //   //               ),
//     //   //               borderRadius: BorderRadius.circular(50.0)),
//     //   //         ),),
//     //   //     )
//     //   // ),
//     //
//     //   // body: SafeArea(
//     //   //   child: SingleChildScrollView(
//     //   //     padding: const EdgeInsets.all(16.0),
//     //   //     child: Column(
//     //   //       crossAxisAlignment: CrossAxisAlignment.start,
//     //   //       children: [
//     //   //         Text(
//     //   //           'Brand',
//     //   //           style: TextStyle(fontSize: 15),
//     //   //         ),
//     //   //         const SizedBox(height: 5),
//     //   //         Column(
//     //   //           crossAxisAlignment: CrossAxisAlignment.start,
//     //   //           children: searchResults.map((result) {
//     //   //             return Padding(
//     //   //               padding: const EdgeInsets.all(8.0),
//     //   //               child: Text(result.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
//     //   //             );
//     //   //           }).toList(),
//     //   //         ),
//     //   //         SizedBox(height: 10),
//     //   //         Text(
//     //   //           'Mobile Model',
//     //   //           style: TextStyle(fontSize: 15),
//     //   //         ),
//     //   //         Column(
//     //   //           crossAxisAlignment: CrossAxisAlignment.start,
//     //   //           children: searchmodel.map((model) {
//     //   //             return Padding(
//     //   //               padding: const EdgeInsets.all(8.0),
//     //   //               child: Text(model,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
//     //   //             );
//     //   //           }).toList(),
//     //   //         ),
//     //   //       ],
//     //   //     ),
//     //   //   ),
//     //   // ),
//     // );
//   }
// }
