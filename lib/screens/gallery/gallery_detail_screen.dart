// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:daelim_univ/models/gallery_item.dart';
import 'package:daelim_univ/provider/gallery_controller.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:daelim_univ/common/widgets/app_scaffold.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GalleryDetailScreen extends StatefulWidget {
  final int? id;
  const GalleryDetailScreen({
    super.key,
    this.id,
  });

  @override
  State<GalleryDetailScreen> createState() => _GalleryDetailScreenState();
}

class _GalleryDetailScreenState extends State<GalleryDetailScreen> {
  int get id => widget.id ?? -1;
  final _controller = Get.find<GalleryController>();
  late final GalleryItemHits? item;

  @override
  void initState() {
    super.initState();
    item = _controller.searchById(id);

    Log.green(item);
  }

  @override
  Widget build(BuildContext context) {
    //final controller = Get.find();
    return AppScaffold(
      enableDrawer: false,
      appBar: AppBar(
        title: Text(item!.tags),
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Stack(
                children: [
                  //#region 메인 이미지
                  Positioned.fill(
                    child: Hero(
                      tag: item?.id ?? "",
                      child: Image.network(
                        item?.largeImageURL ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  //이미지 크기 출력
                  Positioned(
                    right: 5,
                    bottom: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "${item?.imageWidth ?? ""}x${item?.imageHeight ?? ""}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                  //유저 이미지 출력
                  Positioned(
                    left: 5,
                    top: 5,
                    child: Tooltip(
                      message: item?.user,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.yellow, width: 4),
                          image: DecorationImage(
                            image: Image.network(
                              item?.userImageURL ?? "",
                            ).image,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //유저 프로필
                ],
              ),
            ),
            //#region Likes, User Nick
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Like",
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      children: [
                        10.widthSpan,
                        TextSpan(
                          text: "${item?.likes ?? "0"}",
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
