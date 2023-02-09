import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_app/common/http_client_service.dart';
import 'package:gallery_app/model/image_dataset/image_dataset.dart';
import 'package:gallery_app/provider/provider.dart';

class HomeController {
  final BuildContext context;
  final WidgetRef ref;

  HomeController({required this.context, required this.ref});
  var endListLength = 8;

  Future<void> requestImage() async {
    var apiUrl = '/photos';
    Map<String, dynamic> parameter = {};
    parameter["page"] = ref.read(pageListProvider);
    HttpClientService().requestTo(
        url: apiUrl,
        method: HttpMethod.GET,
        parameters: parameter,
        isDisplayLoading: false,
        success: (result) {
          if (result is List<dynamic>) {
            for (var item in result) {
              ref
                  .read(imageListProvider.notifier)
                  .addItem(ImageDataset.fromJson(item));
            }
            if (result.isNotEmpty) {
              ref.read(pageListProvider.notifier).state =
                  ref.read(pageListProvider.notifier).state + 1;
            }
          }
        },
        failure: (error) {
          endListLength = endListLength - 8;
        });
  }
}
