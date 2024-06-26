import 'dart:convert';

import 'package:daelim_univ/models/gallery_item.dart';
import 'package:daelim_univ/provider/auth_controller.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GalleryController extends GetxController {
  final authController = Get.find<AuthController>();

  Rxn<GalleryItem> rxGalleryItem = Rxn();

  List<GalleryItemHits> get galleryItemHits => rxGalleryItem.value?.hits ?? [];

  ///갤러리 목록을 가져옴
  void fetchGallery() async {
    rxGalleryItem.value = null;
    var token = authController.userData!.accessToken;

    //API 호출
    var response = await http.post(
        headers: {"authorization": "Bearer $token"},
        Uri.parse("http://121.140.73.79:60080/functions/v1/gallery"),
        body: jsonEncode({
          'q': '스테이크',
          'per_page': 100,
        })).catchError((e) {
      return http.Response('$e', 401);
    });

    var statusCode = response.statusCode;
    var body = jsonDecode(utf8.decode(response.bodyBytes));

    if (statusCode != 200) {
      Log.red("실패요~:$body");

      return;
    }

    rxGalleryItem.value = GalleryItem.fromMap(body);
  }

  ///Id를 사용하여 hits 아이템에서 검색 <br>
  /// [id] : 검색할 ID
  GalleryItemHits searchById(int id) {
    return galleryItemHits.where((element) => element.id == id).first;
  }
}
