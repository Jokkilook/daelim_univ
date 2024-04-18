import 'dart:convert';

import 'package:daelim_univ/common/widgets/app_scaffold.dart';
import 'package:daelim_univ/models/gallery_item.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  bool _isLoading = false;
  GalleryItem? _galleryItem;

  void _showLoading() {
    _isLoading = true;
  }

  void _hideLoading() {
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppBar(
          title: const Text("갤러리"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            setState(() {
              _showLoading();
            });
            //API 호출
            var response = await http
                .post(
                    Uri.parse(
                        "http://121.140.73.79:60080/functions/v1/gallery"),
                    body: jsonEncode({
                      'q': '딸기',
                      'per_page': 100,
                    }))
                .catchError((e) {
              return http.Response('$e', 401);
            });

            var statusCode = response.statusCode;

            if (statusCode != 200) {
              Log.red("실패요~");
              return;
            }

            var body = jsonDecode(utf8.decode(response.bodyBytes));

            setState(() {
              _galleryItem = GalleryItem.fromMap(body);
            });

            Log.green(statusCode);
            Log.green(_galleryItem);
            print("${_galleryItem?.hits.length ?? 0}");

            setState(() {
              _hideLoading();
            });
            //then 쓰는 법
            // var response = http
            //     .get(Uri.parse("https://121.140.73.79:18443/functions/v1/hello")).then((value) => {});
          },
          child: const Icon(Icons.refresh),
        ),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: _galleryItem?.hits.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  var item = _galleryItem?.hits[index];

                  return Image.network(
                    item?.webformatURL ?? "",
                    fit: BoxFit.cover,
                  );
                },
              )

        //const Placeholder(),
        );
  }
}
