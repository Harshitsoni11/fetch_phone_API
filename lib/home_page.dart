import 'dart:async';
import 'dart:convert';

import 'package:assignment_flutter/Comman_widget/button_image.dart';
import 'package:assignment_flutter/Filter_page.dart';
import 'package:assignment_flutter/Services/phone_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'Comman_widget/comman_button.dart';

import 'Services/app_uri.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController pageController;
  int pageNo = 0;
  TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<String> searchResults = [];
  List<String> searchmodel=[];
  bool isSearching = true;

  @override
  void initState() {
    pageController = PageController();

    super.initState();
  }

  Future<void> _makeAPICall(String query) async {
    // Replace this URL with your POST API endpoint

    if (query.isEmpty) {
      setState(() {
        searchResults.clear();
        searchmodel.clear();
      });
    }

    // Make the POST API call using http package



    Response response = await http.post(Uri.parse(AppUri.searchmodelurl), body: {
      "searchModel":jsonEncode(query)
    },headers: {'Content-Type': 'application/json'},);
  //  print(response.statusCode); // Check the response status code
 //   print(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      // If the API call is successful, parse the response and update the UI

      Map<String, dynamic> data = json.decode(response.body);
      //print(data);
      List<String> makes = List<String>.from(data['makes']);
      List<String> models = List<String>.from(data['models']);

      print(makes.length);



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
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), ()
    {
      _makeAPICall(query);
    });

  }
  @override
  void dispose() {
    pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PhoneService phoneService = PhoneService();
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
          child: InkWell(
            onTap: (){

            },
            child: TextFormField(
              controller: _searchController,

              onChanged: (query) => _onSearchChanged(query),

              decoration: InputDecoration(
              prefixIcon: IconButton(
                onPressed: (){
                  if(isSearching==false){
                    isSearching=true;
                  }else{
                    isSearching=false;
                  }

                  setState(() {

                  });
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
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
          ),
        )
      ),
      body:  isSearching ? SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Buy Top Brands',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: Buttonlist.logoimage
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Card(
                                color: Colors.white,
                                elevation: 12.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Image.network(e),
                                ),
                              ),
                            ))
                        .toList()),
              ),

              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    pageNo = index;
                    setState(() {});
                  },
                  itemBuilder: (_, index) {
                    return AnimatedBuilder(
                      animation: pageController,
                      builder: (ctx, child) {
                        return child!;
                      },
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                              Text("Hello you tapped at ${index + 1} "),
                            ),
                          );
                        },
                      
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: 8, left: 8, top: 24, bottom: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Colors.amberAccent,
                          ),
                          child: Image.network(fit:BoxFit.fill
                          ,Buttonlist.pageimg[index]),
                        ),
                      ),
                    );
                  },
                  itemCount: 5,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                      (index) => GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.circle,
                        size: 12.0,
                        color: pageNo == index
                            ? const Color(0xff17173d)
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Shop by',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CommanButton(
                      icon: Icons.mobile_screen_share,
                      title: 'Bestselling\nMobiles',
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CommanButton(
                      icon: Icons.verified_outlined,
                      title: 'Verified\nDevices only',
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CommanButton(
                      icon: Icons.mobile_friendly,
                      title: 'Like New\nConditions',
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CommanButton(
                      icon: Icons.add_task_outlined,
                      title: 'Phones With\nWarrenty',
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text(
                    'Best Deals Near You',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30.0)),
                          ),
                          builder: (BuildContext context) {
                            return FilterPage();
                          },
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Text(
                          'Filter ↑↓',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              FutureBuilder(
                  future: phoneService.fetchListings(),
                  builder: (context, snapshot) {
                    return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                          mainAxisExtent: 300,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  16.0,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .end, // Align the icon to the right
                                      children: [
                                        // Other widgets in the row if needed.
                                        Icon(
                                          Icons.favorite_border,
                                          color: Colors.red,
                                        ), // Your icon here
                                      ]),
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                    child: Image.network(
                                      snapshot.data![index].defaultImage,
                                      height: 160,

                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "₹ ${snapshot.data![index].listingNumPrice}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .merge(
                                                const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(snapshot.data![index].model
                                            .toString()),
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              snapshot
                                                  .data![index].deviceStorage
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "condition: ${snapshot.data![index].deviceCondition}",
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              snapshot
                                                  .data![index].listingLocation
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                snapshot
                                                    .data![index].listingDate
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        });
                  })
            ],
          ),
        ),
      )
          : SafeArea(child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Brand',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          ),
          Expanded(
            child: ListView.builder( itemCount: searchResults.length,
            itemBuilder: (context,index)=> Text(

                searchResults[index])),
          ),

          SizedBox(height: 5,),
          
          Expanded(child: ListView.builder(itemCount: searchmodel.length,itemBuilder: (context,index)=> Text(searchmodel[index]))),
        ],
      )),
    );
  }
}


