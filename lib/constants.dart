import 'models/user_model.dart';

const kHost = "http://192.168.137.11:3001/";

const kApiPath = '${kHost}api';

String signup(UserModel userModel) => '$kApiPath/signup';