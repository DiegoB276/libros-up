import 'package:flutter/material.dart';
import 'package:librosup/screens/details_recommended.dart';
import 'package:librosup/service/api.dart';

class RecomendedBooksScreen extends StatefulWidget {
  const RecomendedBooksScreen({super.key});

  @override
  State<RecomendedBooksScreen> createState() => _RecomendedBooksScreenState();
}

class _RecomendedBooksScreenState extends State<RecomendedBooksScreen> {
  late TextEditingController searchController;
  bool isSearching = false;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
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
        toolbarHeight: 70,
        title: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 55,
                child: TextField(
                  controller: searchController,
                  onTap: () {
                    setState(() {
                      isSearching = false;
                    });
                  },
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
              ),
            ),
            IconButton(
              onPressed: () {
                if(searchController.text.isEmpty) return;
                setState(() {
                  isSearching = true;
                });
              },
              color: Colors.orange,
              icon: const Icon(Icons.search, size: 35,),
            ),
          ],
        ),
      ),
      body: isSearching
          ? FutureBuilder(
              future: APIService.searchBooks(searchController.text),
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
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  builder: (context) => DetailsRecommended(
                                    book: snapshot.data![index],
                                  ),
                                ),
                              );
                            },
                            child: Image.network(
                              (snapshot.data![index]["thumbnail"]),
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
                              snapshot.data![index]["title"],
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              "${snapshot.data![index]["similarity"]}",
                              style: const TextStyle(
                                fontSize: 13,
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
                );
              },
            )
          : const Center(
              child: Text("Busca un el tipo de libro que deseas."),
            ),
    );
  }
}
