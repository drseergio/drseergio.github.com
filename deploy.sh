#!/bin/bash
rm -rf public/*
hugo
cd public
MESSAGE="Site updated at `date +"%Y-%m-%d %H:%M:%S %Z"`"
git add .
git commit -m "${MESSAGE}"
git push origin master
cd ..
