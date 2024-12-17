import 'package:flutter/material.dart';
import 'package:librosup/screens/details_recommended.dart';
import 'package:librosup/service/api.dart';

class FilterBooksCategory extends StatefulWidget {
  const FilterBooksCategory({
    super.key,
    required this.category,
  });

  final String category;

  @override
  State<FilterBooksCategory> createState() => _FilterBooksCategoryState();
}

class _FilterBooksCategoryState extends State<FilterBooksCategory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          "Libros de ${widget.category}",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder(
        future: APIService.searchBooks(widget.category),
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
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
