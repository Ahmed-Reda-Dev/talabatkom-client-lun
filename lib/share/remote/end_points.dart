// ignore: duplicate_ignore
// ignore_for_file: constant_identifier_names, duplicate_ignore

import '../locale/cache_helper.dart';

const LOGIN = 'api/login';

const MYBALANCE = 'api/myBalance';

const PROFILE = 'api/user';

// ignore: non_constant_identifier_names
String TOKEN = CacheHelper.getData(key: 'token') ?? '';

const NEARBYMARKETS = 'api/markets';
