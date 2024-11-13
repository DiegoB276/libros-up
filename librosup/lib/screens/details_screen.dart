import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.book,
  });

  final Map book;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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
                      width: 150,
                      height: 300,
                      widget.book["volumeInfo"]["imageLinks"]["thumbnail"],
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width*0.5,
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
                          widget.book["volumeInfo"]["title"],
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
                          (widget.book["volumeInfo"]["categories"] != null &&
                                  widget.book["volumeInfo"]["categories"]
                                      .isNotEmpty)
                              ? widget.book["volumeInfo"]["categories"][0]
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
                          widget.book["volumeInfo"]["authors"][0],
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
              const Text(
                "Descripción",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(widget.book["volumeInfo"]["description"] ??
                  "No se ha proporcionado una descripción al libro."),
              const Text(
                "Categoría",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                (widget.book["volumeInfo"]["categories"] != null &&
                        widget.book["volumeInfo"]["categories"].isNotEmpty)
                    ? widget.book["volumeInfo"]["categories"][0]
                    : "any",
              ),
              const SizedBox(height: 10),
              Center(
                child: Image.network(
                  width: 300,
                  height: 300,
                  widget.book["volumeInfo"]["imageLinks"]["smallThumbnail"],
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
