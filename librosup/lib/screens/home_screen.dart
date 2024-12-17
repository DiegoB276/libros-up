import 'package:flutter/material.dart';
import 'package:librosup/screens/filter_books_category.dart';
import 'package:librosup/service/api.dart';

import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController;
  List<Map> filters = [
    {"gen": "Deportes", "key": "te", "status": true},
    {"gen": "Comedia", "key": "com", "status": false},
    {"gen": "Automoviles", "key": "cf", "status": false},
    {"gen": "Historia", "key": "his", "status": false},
  ];

  void changeStatusFilterItem(int index) {
    setState(() {
      for (int i = 0; i < filters.length; i++) {
        {
          filters[i]['status'] = false;
        }
        filters[index]['status'] = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("Todos los Libros"),
      ),
      body: FutureBuilder(
        future: APIService.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text("No Hay Datos"),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                width: double.infinity,
                //color: Colors.grey.shade100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FilterBooksCategory(
                                category: filters[index]['gen'],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              filters[index]['gen'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                  book: snapshot.data![index],
                                ),
                              ),
                            );
                          },
                          child: Image.network(
                            (snapshot.data![index]["volumeInfo"]?["imageLinks"]
                                            ?["smallThumbnail"] !=
                                        null &&
                                    snapshot
                                        .data![index]["volumeInfo"]
                                            ?["imageLinks"]?["smallThumbnail"]
                                        .isNotEmpty)
                                ? snapshot.data![index]["volumeInfo"]
                                    ["imageLinks"]["smallThumbnail"]
                                : "https://c1.tablecdn.com/pa/google-books-api.jpg",
                            width: 120,
                            height: 120,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/placeholder.png', // Imagen local de respaldo
                                width: 120,
                                height: 120,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            snapshot.data![index]["volumeInfo"]["title"],
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
