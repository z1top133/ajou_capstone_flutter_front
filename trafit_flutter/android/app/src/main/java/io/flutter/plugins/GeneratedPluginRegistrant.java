package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
<<<<<<< HEAD
import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin;
=======
>>>>>>> 7b79f081ace62148a95778bc249d687905f1da23
import com.flutter.keyboardvisibility.KeyboardVisibilityPlugin;
import io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin;
import com.itsclicking.clickapp.fluttersocketio.FlutterSocketIoPlugin;
import io.github.ponnamkarthik.toast.fluttertoast.FluttertoastPlugin;
import io.flutter.plugins.imagepicker.ImagePickerPlugin;
<<<<<<< HEAD
import io.flutter.plugins.pathprovider.PathProviderPlugin;
=======
>>>>>>> 7b79f081ace62148a95778bc249d687905f1da23
import com.julienvignali.phone_number.PhoneNumberPlugin;
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin;
import com.tekartik.sqflite.SqflitePlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
<<<<<<< HEAD
    FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
=======
>>>>>>> 7b79f081ace62148a95778bc249d687905f1da23
    KeyboardVisibilityPlugin.registerWith(registry.registrarFor("com.flutter.keyboardvisibility.KeyboardVisibilityPlugin"));
    FlutterAndroidLifecyclePlugin.registerWith(registry.registrarFor("io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin"));
    FlutterSocketIoPlugin.registerWith(registry.registrarFor("com.itsclicking.clickapp.fluttersocketio.FlutterSocketIoPlugin"));
    FluttertoastPlugin.registerWith(registry.registrarFor("io.github.ponnamkarthik.toast.fluttertoast.FluttertoastPlugin"));
    ImagePickerPlugin.registerWith(registry.registrarFor("io.flutter.plugins.imagepicker.ImagePickerPlugin"));
<<<<<<< HEAD
    PathProviderPlugin.registerWith(registry.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"));
=======
>>>>>>> 7b79f081ace62148a95778bc249d687905f1da23
    PhoneNumberPlugin.registerWith(registry.registrarFor("com.julienvignali.phone_number.PhoneNumberPlugin"));
    SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
    SqflitePlugin.registerWith(registry.registrarFor("com.tekartik.sqflite.SqflitePlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
