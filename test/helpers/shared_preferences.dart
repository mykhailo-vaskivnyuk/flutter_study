import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void setUpSharedPreferencesMock() {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();
}

void tearDownSharedPreferencesMock() {
  SharedPreferencesAsyncPlatform.instance = null;
}
