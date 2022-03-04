# Flutter App demo that changes colour or mode based on the intensity of light, Using Sensor.

## 1.INSTALLATION

- Flutter Installation
  -> download the flutter file according to your OS. [Flutter Link](https://docs.flutter.dev/get-started/install)
or you can can use brew command
``` bash
brew install --cask flutter
```
- VS Code Installation -> Use [this link](https://code.visualstudio.com/Download) to download VS Code / use brew command 
``` bash
brew install --cask visual-studio-code
```
- Install Android Studio -> use [this link](https://developer.android.com/studio) to download Android Studio / use brew command
``` bash
brew install --cask android-studio
```
## 2. Writing Native Code in Flutter
Flutter uses a flexible system that allows you to call platform-specific APIs in a language that works directly with those APIs:

- Kotlin or Java on Android
- Swift or Objective-C on iOS
- C++ on Windows
- Objective-C on macOS
- C on Linux

![PlatformChannels](https://user-images.githubusercontent.com/46975685/156743506-5649792f-c73f-4e48-8127-67b6f1fb0e95.png)

For More info click on [link](https://docs.flutter.dev/development/platform-integration/platform-channels?tab=type-mappings-java-tab)

## 3. Android Sensors

Accessing Mobile Sensors using Flutter is not possible hence to get access we have to write code in native language. It's platform specified as above in section 2. We can asscess sensor using native codes in this example I have written code in Kotlin. you can install kotlin using this [link](https://kotlinlang.org/docs/command-line.html)

or use the brew command
``` bash
brew install kotlin
```
* *Note - When accessing Kotlin file using vs code I was getting errors for gradle updates, so i will suggest you to open those .kt files using Android Studio.* 

As we can see in Image in section 2 we have to make a method channel that name of the method channel should be same in both dart file and in kotlin file. As it makes it easy for them to talk or pass info among themselves. After that make an Event Channel with same name in both files.

*Like*

*For Dart File -*
```dart
static const methodChannel = MethodChannel('com.lightapp.light/method');
static const pressureChannel = EventChannel('com.lightapp.light/intensity');
```

For Android we can find the kt file in Android -> app -> main -> src -> kotlin.

*If you want to write code in java just open the java folder for that.*

*For Kotlin File -*

``` kt
private val METHOD_CHANNEL_NAME = "com.lightapp.light/method"
private val INTENSITY_CHANNEL_NAME = "com.lightapp.light/intensity"
```

Now its time to access the sensors in the Mobile Phone. you can use the method as I have written it in files or use this [link](https://developer.android.com/reference/kotlin/android/hardware/Sensor) for more info.

## 4. Changing Colours
As it being a Demo, I made a list of colors and used ternary operator. Based on the value of the intensity of light that i am getting from the sensor and ternary operator I changed the value of colours. and it was in reverse order for the Text.


## n. Results
![light_intensity_mode](https://user-images.githubusercontent.com/46975685/156742964-897f7487-847e-400b-a01d-353cd7c93849.gif)


****
