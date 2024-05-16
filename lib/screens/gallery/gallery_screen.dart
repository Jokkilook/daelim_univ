import 'dart:convert';
import 'package:daelim_univ/common/widgets/app_scaffold.dart';
import 'package:daelim_univ/models/gallery_item.dart';
import 'package:daelim_univ/provider/auth_controller.dart';
import 'package:daelim_univ/provider/gallery_controller.dart';
import 'package:daelim_univ/router/app_router.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final _controller = Get.put(GalleryController());

  late final ScrollController _scrollController;

  GalleryItem? _galleryItem;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller.fetchGallery();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppBar(
          title: const Text("갤러리"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _controller.fetchGallery(),
          child: const Icon(Icons.refresh),
        ),
        child: Obx(
          () => _controller.rxGalleryItem.value == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(10),
                    itemCount:
                        _controller.rxGalleryItem.value?.hits.length ?? 0,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      var item = _controller.rxGalleryItem.value?.hits[index];

                      return InkWell(
                        onTap: () async {
                          // if (item?.largeImageURL != null) {
                          //   await precacheImage(
                          //       Image.network(item?.largeImageURL ?? "").image,
                          //       context);
                          // }

                          if (context.mounted) {
                            context.pushNamed(
                              AppScreen.galleryDetail,
                              pathParameters: {
                                "id": (item?.id ?? -1).toString(),
                              },
                            );
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Hero(
                            tag: item?.id ?? "",
                            child: Image.network(
                              item?.webformatURL ?? "",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        )
        //const Placeholder(),
        );
  }
}
