#!/bin/sh

brew bundle
brew outdated carthage || brew upgrade carthage
carthage bootstrap --platform iOS --no-use-binaries --cache-builds
