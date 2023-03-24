import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Protocols extends StatefulWidget {
  const Protocols({super.key});

  @override
  State<Protocols> createState() => _ProtocolsState();
}

class _ProtocolsState extends State<Protocols> {
  late PdfViewerController _pdfViewerController = PdfViewerController();
  late PdfTextSearchResult _searchResult = PdfTextSearchResult();

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //PDF viewer
      body: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              'Health Protocols',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 147, 46, 46),
                ),
                onPressed: () {
                  _searchResult = _pdfViewerController.searchText('millets');

                  _searchResult.addListener(() {
                    if (_searchResult.hasResult) {
                      setState(() {});
                    }
                  });
                },
              ),
              Visibility(
                visible: _searchResult.hasResult,
                child: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Color.fromARGB(255, 124, 39, 39),
                  ),
                  onPressed: () {
                    setState(() {
                      _searchResult.clear();
                    });
                  },
                ),
              ),
              Visibility(
                visible: _searchResult.hasResult,
                child: IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_up,
                    color: Color.fromARGB(255, 156, 30, 30),
                  ),
                  onPressed: () {
                    _searchResult.previousInstance();
                  },
                ),
              ),
              Visibility(
                visible: _searchResult.hasResult,
                child: IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color.fromARGB(255, 160, 19, 19),
                  ),
                  onPressed: () {
                    _searchResult.nextInstance();
                  },
                ),
              ),
            ],
          ),
          body: Container(
              child: SfPdfViewer.asset('assets/documents/protocols.pdf',
                  enableDoubleTapZooming: true,
                  controller: _pdfViewerController,
                  currentSearchTextHighlightColor:
                      Colors.yellow.withOpacity(0.6),
                  otherSearchTextHighlightColor:
                      Colors.yellow.withOpacity(0.3)))),
    );
  }
}
