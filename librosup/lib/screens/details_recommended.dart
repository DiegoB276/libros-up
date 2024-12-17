import 'package:flutter/material.dart';

class DetailsRecommended extends StatefulWidget {
  const DetailsRecommended({
    super.key,
    required this.book,
  });

  final Map book;

  @override
  State<DetailsRecommended> createState() => _DetailsRecommendedState();
}

class _DetailsRecommendedState extends State<DetailsRecommended> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("Información del Libro"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Center(
                    child: Image.network(
                      widget.book["thumbnail"] !=
                                  null &&
                              widget
                                  .book["thumbnail"]
                                  .isNotEmpty
                          ? widget.book["thumbnail"]
                          : "https://c1.tablecdn.com/pa/google-books-api.jpg",
                      width: 150,
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Título",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          widget.book["title"],
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Categoría",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          (widget.book["categories"] != null &&
                                  widget.book["categories"]
                                      .isNotEmpty)
                              ? widget.book["categories"][0]
                              : "any",
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Autor",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          (widget.book != null &&
                                  
                                  widget.book["authors"] !=
                                      null &&
                                  widget
                                      .book["authors"].isNotEmpty)
                              ? widget.book["authors"][0]
                              : "Desconocido",
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              const Text(
                "Páginas",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                ("Total depáginas: ${widget.book["page_count"]}"),
              ),
              const SizedBox(height: 15),
              const Text(
                "Descripción",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                widget.book["description"] ??
                    "No se ha proporcionado una descripción al libro.",
              ),
              const SizedBox(height: 10),
              Center(
                child: Image.network(
                  widget.book["thumbnail"] !=
                              null &&
                          widget.book["thumbnail"]
                              .isNotEmpty
                      ? widget.book["thumbnail"]
                      : "https://c1.tablecdn.com/pa/google-books-api.jpg",
                  width: 150,
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
