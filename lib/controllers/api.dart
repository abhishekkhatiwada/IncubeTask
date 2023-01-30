import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiController extends GetxController {
  static ApiController to = Get.find();

  List data = [];
  int count = 0;
  List<String> months = [];
  String? selectedMonth;

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  Future getData() async {
    const apiUrl = 'https://staging.loksewapro.com/api/v1/gorkhapatras';
    var response = await http.get(Uri.parse(apiUrl));
    var getJson = json.decode(response.body);
    data = getJson['data']['gorkhapatras'];
    count = data.length;

    final List<String> monthsList = [
      for (int i = 0; i < count; i++) data[i]['published_month'],
    ];
    months = monthsList.toSet().toList();
    final List<String> yearList = [
      for (int i = 0; i < count; i++) data[i]['published_year'].toString(),
    ];
    List<String> year = yearList.toSet().toList();

    update();
  }

  Future sortBbyMonth(value) async {
    selectedMonth = value;
    // data.clear();
    // data = [
    //   for (int i = 0; i < count; i++)
    //     {
    //       if (data[i]['published_month'] = value)
    //         {
    //           {
    //             "title": data[i]['title'],
    //             "published_month": data[i]['published_month'],
    //             "published_at": data[i]['published_at'],
    //             "n_questions": data[i]['n_questions'],
    //           },
    //         }
    //     }
    // ];
    count = data.length;
    update();
  }
}
