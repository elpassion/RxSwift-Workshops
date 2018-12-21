#!/bin/sh

brew bundle
brew outdated carthage || brew upgrade carthage
carthage bootstrap \
  --platform macOS \
  --no-use-binaries \
  --cache-builds
