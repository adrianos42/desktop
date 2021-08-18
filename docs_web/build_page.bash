#!/usr/bin/bash

rm -r ../docs/*
flutter build web -v
cp -r -v build/web/* ../docs