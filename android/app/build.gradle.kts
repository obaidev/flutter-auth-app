plugins {
    id("com.android.application")
    id("kotlin-android")

    // ✅ REQUIRED for Firebase
    id("com.google.gms.google-services")

    // Must be last
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.obaid.flutterauthdemo"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.14206865"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.obaid.flutterauthdemo"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
