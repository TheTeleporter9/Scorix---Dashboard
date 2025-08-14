import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;


void addNewTeam(String teamName, String teamScoolName) async{

  await Supabase.instance.client
  .from('teams')
  .insert(
    {'name': teamName,
    'school': teamScoolName}
    );

}


Future<Map<String, dynamic>?> getTeam() async {
  final user = supabase.auth.currentUser;
  if (user == null) return null;

  try {
    // maybeSingle() returns null if no row exists
    final data = await supabase
        .from('teams')
        .select('name, school')
        .eq('user_id', user.id)
        .maybeSingle();

    print('Team data: $data'); // This is a Map<String, dynamic>
    return data;

  } catch (e) {
    // Catch errors like RLS violations or network issues
    print('Error fetching team: $e');
    return null;
  }
}