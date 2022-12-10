#!/bin/bash
(
  leaf() {
     cd leaf
     flutter pub get
     cd ..
     echo "leaf pub get done!"
  }

  leaf_common() {
     cd leaf_common
     flutter pub get
     cd ..
     echo "leaf_common pub get done!"
  }

  leaf_component() {
     cd leaf_component
     flutter pub get
     cd ..
     echo "leaf_component pub get done!"
  }

  leaf_firebase() {
     cd leaf_firebase
     flutter pub get
     cd ..
     echo "leaf_firebase pub get done!"
  }

  leaf_manager() {
     cd leaf_manager
     flutter pub get
     cd ..
     echo "leaf_manager pub get done!"
  }

  leaf_network() {
     cd leaf_network
     flutter pub get
     cd ..
     echo "leaf_network pub get done!"
  }

  leaf_data() {
     cd leaf_data
     flutter pub get
     cd ..
     echo "leaf_data pub get done!"
  }

  leaf_navigation() {
     cd leaf_navigation
     flutter pub get
     cd ..
     echo "leaf_navigation pub get done!"
  }

  while getopts p:t: flag
  do
      case "${flag}" in
          p) package=${OPTARG};;
          t) type=${OPTARG};;
      esac
  done

  if [ -z "$package" ]; then
    echo "Start All Package Pub Getting...";
  else
    echo "Start $package Pub Getting...";
  fi

  cd packages

  if [ "$package" == "leaf" ]; then
      leaf
  elif [ "$package" == "leaf_common" ]; then
      leaf_common
  elif [ "$package" == "leaf_component" ]; then
      leaf_component
  elif [ "$package" == "leaf_firebase" ]; then
      leaf_firebase
  elif [ "$package" == "leaf_manager" ]; then
      leaf_manager
  elif [ "$package" == "leaf_network" ]; then
      leaf_network
  elif [ "$package" == "leaf_data" ]; then
      leaf_data
  elif [ "$package" == "leaf_navigation" ]; then
      leaf_navigation
  else
      leaf_data
      leaf_common
      leaf_navigation
      leaf_component
      leaf_firebase
      leaf_manager
      leaf_network
      leaf
  fi
)
