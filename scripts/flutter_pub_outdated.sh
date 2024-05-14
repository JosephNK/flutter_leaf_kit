#!/bin/bash
(
  cd packages/leaf_common
  dart pub outdated  -h
  cd ..
  cd packages/leaf_component
  dart pub outdated  -h
)