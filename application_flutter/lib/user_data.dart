class user_data {

  static final user_data _singleton = user_data._internal();

  String? email;
  String? user_name;
  String? user_id;
  String? profile_image_url;

  factory user_data() {
    return _singleton;
  }

  user_data._internal();
}