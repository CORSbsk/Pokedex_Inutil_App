import 'package:get/get.dart';
import 'package:andercode_flutter_pokedex/models/getDataModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Getdatacontroller extends GetxController {
  final supabase = Supabase.instance.client;
  var isLoading = false.obs;
  var getDataModel = GetDataModel(results: []).obs;

  Future<void> getDataFromSupabase() async {
    isLoading.value = true;
    try {
      final data = await supabase.from('tm_pokemon').select();
      getDataModel.value = GetDataModel.fromJson({'results': data});
      isLoading.value = false;
    } catch (e) {
      print("Error en Supabase: $e");
    }
  }
}
