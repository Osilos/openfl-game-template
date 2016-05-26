adb connect 192.168.1.19:5555
adb shell am force-stop com.template.template
adb shell am start -a android.intent.action.DELETE -d package:com.template.template
adb shell input tap 1475 814
adb install bin/android/bin/bin/template-debug.apk
adb shell am start -n com.template.template/com.template.template.MainActivity