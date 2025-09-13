plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android") // ✅ correct plugin name
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.scholarly"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // This must match the package name you registered in Firebase
        applicationId = "com.example.scholarly"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Temporary debug signing, replace with your own release key later
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase Bill of Materials (keeps versions aligned)
    implementation(platform("com.google.firebase:firebase-bom:34.2.0"))

    // Firebase products
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")      // ✅ Firebase Authentication
    implementation("com.google.firebase:firebase-firestore") // ✅ Cloud Firestore
}
