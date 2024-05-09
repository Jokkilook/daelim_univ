// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:daelim_univ/common/widgets/app_scaffold.dart';
import 'package:get/get.dart';

class GalleryDetailScreen extends StatelessWidget {
  final int? id;
  const GalleryDetailScreen({
    super.key,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    //final controller = Get.find();
    return AppScaffold(
        enableDrawer: false,
        appBar: AppBar(
          title: const Text("갤러리 상세보기"),
        ),
        child: Text(id.toString()));
  }
}
