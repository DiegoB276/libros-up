import 'package:flutter/material.dart';
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
    {"gen": "Terror", "key": "te", "status": true},
    {"gen": "Ciencia Ficción", "key": "cf", "status": false},
    {"gen": "Más Descargados", "key": "md", "status": false},
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

  void getData() async {
    final data = await APIService.getData();
    print(data);
  }

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    getData();
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
        toolbarHeight: 80,
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: "Buscar Libros",
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffB4B4B4), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xffB4B4B4), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        /*Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Buscar Libros",
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xffB4B4B4), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xffB4B4B4), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: ListView.builder(
                itemCount: filters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: MaterialButton(
                      onPressed: () => changeStatusFilterItem(index),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      textColor: Colors.white,
                      color: filters[index]["status"]
                          ? Colors.brown
                          : Colors.orange,
                      child: Text(
                        filters[index]["gen"],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),*/
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
          return GridView.builder(
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
                                )),
                      );
                    },
                    child: Image.network(
                      snapshot.data![index]["volumeInfo"]["imageLinks"]
                          ["smallThumbnail"] ?? "https://c1.tablecdn.com/pa/google-books-api.jpg",
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      snapshot.data![index]["volumeInfo"]["title"],
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
