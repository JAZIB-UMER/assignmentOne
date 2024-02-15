import 'dart:convert';

import 'package:assignment/apis/model_data.dart';
import 'package:assignment/apis/rest_apis.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ServicesApis {
  static Future<PrayerModel> getPrayerData() async {
    var client = http.Client();
    try {
      Uri uri = Uri.parse(RestApisUtils.baseUrl);
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        RestApisUtils.model = PrayerModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('No Internet Connection');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      client.close();
    }
    return RestApisUtils.model!;
  }
}
