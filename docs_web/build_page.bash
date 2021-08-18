#!/usr/bin/bash

rm -r ../docs/*
flutter build web -v --web-renderer canvaskit
cp -r -v build/web/* ../docs