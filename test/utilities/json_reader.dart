import 'dart:convert';
import 'dart:io';

dynamic jsonReader(String name) {
  final dir = Directory.current.path;

  return jsonDecode(File('$dir/test/utilities/fake_data/$name').readAsStringSync());
}
