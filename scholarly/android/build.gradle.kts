// Top-level build.gradle.kts

plugins {
    // Android plugin (compatible avec AGP 8.9.1)
    id("com.android.application") version "8.9.1" apply false
    id("com.android.library") version "8.9.1" apply false

    // Kotlin plugin (à mettre au moins en 1.9.x pour AGP 8.9.1)
    id("org.jetbrains.kotlin.android") version "1.9.23" apply false

    // Flutter Gradle plugin
    id("dev.flutter.flutter-gradle-plugin") apply false

    // Google Services plugin (Firebase)
    id("com.google.gms.google-services") version "4.4.2" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
