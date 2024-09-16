import 'dart:ui';

import 'package:elevate_flutter_filtration_task/API/api_manage.dart';
import 'package:elevate_flutter_filtration_task/Model/categorysource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            'Flutter Task',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
        body: FutureBuilder<List<CategorySource>>(
            future: ApiManager.getSource(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    children: [
                      Text("no connection"),
                      ElevatedButton(
                          onPressed: () {
                            ApiManager.getSource();
                            setState(() {});
                          },
                          child: Text('Try Again'))
                    ],
                  ),
                );
              } else {
                List<CategorySource> products = snapshot.data!;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: Colors.blue)),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Card(
                                      shadowColor: Colors.black,
                                      child: Icon(
                                        Icons.favorite_outline,
                                        color: Colors.blue,
                                      ))),
                              Column(
                                children: [
                                  Image.network(
                                    products[index].image!,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.2,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.11,
                                    fit: BoxFit.fill,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        products[index].title!,
                                        style: TextStyle(
                                            fontSize: 15,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Text(
                                        products[index].description!,
                                        style: TextStyle(
                                            fontSize: 15,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      SizedBox(),
                                      Text(
                                        'EGP \t' +
                                            products[index].price.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Review \t ' +
                                          "(" +
                                          products[index]
                                              .rating!
                                              .rate
                                              .toString() +
                                          ")"),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Card(
                                          color: Colors.blue,
                                          child: Icon(Icons.add,
                                              color: Colors.white, weight: 100))
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }));
  }
}
