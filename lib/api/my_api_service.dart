import 'package:dio/dio.dart';
import 'package:toilet_admin/model/feedback_model.dart';
import 'package:toilet_admin/model/feedback_model_w_status.dart';
import 'package:toilet_admin/utils/mystring.dart';
// const CREATE_FEEDBACK = 'http://localhost:8080/create_feedback';
// const LIST_FEEDBACK = 'http://localhost:8080/list_feedback';

class MyAPIService {
  Dio dio = Dio();

  Future<dynamic> saveToken({String? value, String? name}) async {
    Map<String, dynamic> body = {
      "value": value,
      "name": name,
    };
    final response = await dio.post(
      MyString.SAVE_TOKEN,
      data: body,
      options: Options(
          contentType: Headers.jsonContentType,
          sendTimeout: const Duration(seconds: 10)),
    );
    return response.data;
  }

  Future createFeedBack({
    driver,
    star,
    content,
    experience,
  }) async {
    Map<String, dynamic> body = {
      "driver": "$driver" ?? "DEFAUTL DRIVER",
      "star": star ?? 5,
      "content": "$content" ?? "DEFAULT CONTENT",
      "experience": experience ?? "DEFAULT EXP",
      "createdAt": DateTime.now().toString()
    };
    final response = await dio.post(
      MyString.CREATE_FEEDBACK,
      data: body,
      options: Options(
          contentType: Headers.jsonContentType,
          sendTimeout: const Duration(seconds: 10)),
    );
    return response.data;
  }

  Future<FeedbackModel> fetchFeedBack() async {
    final response = await dio.get(
      MyString.LIST_FEEDBACK,
      options: Options(
        contentType: Headers.jsonContentType,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
      ),
    );
    return FeedbackModel.fromJson(response.data);
  }

  //feedback with status
  Future<FeedbackModelWStatus> fetchFeedBackwstatus() async {
    final response = await dio.get(
      MyString.LIST_FEEDBACK_W_STATUS,
      options: Options(
        contentType: Headers.jsonContentType,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
      ),
    );
    // print(response.data);
    // return (response.data);
    return FeedbackModelWStatus.fromJson(response.data);
  }

  //call_service
  Future<FeedbackModelWStatus> fetchCallService() async {
    final response = await dio.get(
      "http://localhost:8095/call_service",
      options: Options(
        contentType: Headers.jsonContentType,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
      ),
    );
    print('${response.data}');
    return (response.data);
  }

  //update feedback with status
  Future<dynamic> updateFeedBackwstatus(id) async {
    final response = await dio.post(
      MyString.UPDATE_FEEDBACK,
      data: {
        "id": id,
        "isprocess": true,
      },
      options: Options(
        contentType: Headers.jsonContentType,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
      ),
    );
    // print(response.data);
    return (response.data);
  }
}
