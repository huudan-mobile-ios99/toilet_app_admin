class MyString {
  static const int DEFAULTNUMBER = 111111;
  static const String ADRESS_LOCAL = "localhost";
  static const String ADRESS_SERVER = "30.0.0.53";
  static const String BASE = 'http://192.168.101.58:8095/';

  static const String list_ranking = '${BASE}list_ranking';
  static const String create_ranking = '${BASE}add_ranking';
  static const String update_ranking = '${BASE}update_ranking';
  static const String delete_ranking = '${BASE}delete_ranking';
  static const String delete_ranking_all_and_add = '${BASE}delete_ranking_all_create_default';


  static const CREATE_FEEDBACK = '${BASE}create_feedback';
  static const LIST_FEEDBACK = '${BASE}list_feedback';
  static const LIST_FEEDBACK_W_STATUS = '${BASE}list_feedback_status';
  static const SAVE_TOKEN = '${BASE}add_token';
  static const UPDATE_FEEDBACK = '${BASE}update_feedback_status';

  static const String FIREBASE_APP_NAME = 'toilet-info';
  static const String FIREBASE_apiKey ='AIzaSyCLKulk9yiyhy6P7_d5tNSeV837CVmlUBA';
  static const String FIREBASE_appId ='1:551431577143:android:5aee9625784e48ca7669b2';

  static const String FIREBASE_messagingSenderId = '551431577143';
  static const String FIREBASE_projectId = 'toilet-info';
  static const String FIREBASE_auth_domain = 'toilet-info.firebaseapp.com';
  static const String FIREBASE_url ='https://toilet-info-default-rtdb.asia-southeast1.firebasedatabase.app';
  static const String FIREBASE_storage_bucket = 'toilet-info.appspot.com';
  static const String FIREBASE_measurementId = 'G-RSN4SQ0LP2';
}
