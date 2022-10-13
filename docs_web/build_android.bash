#!/usr/bin/bash

flutter build apk
flutter install --use-application-binary=build/app/outputs/flutter-apk/app-release.apk