import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<dynamic> fetchData() async {
    final response = await supabase.from('products').select();
    return response;
  }
}
