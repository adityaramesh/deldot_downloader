<!--
  ** File Name:	README.md
  ** Author:	Aditya Ramesh
  ** Date:	08/14/2013
  ** Contact:	_@adityaramesh.com
-->

# Introduction

This projects contains a set of programs that download and transcode the live
traffic camera streams from the Delaware Department of Transportation website.

# Requirements

This projects depends on the following list of non-standard software:

- Ruby
- Rake
- Curl
- FFmpeg
- A C++11 compiler (e.g. `clang++`, `g++`)
- `ccbase`

# Installation

Run the following commands:

	rake
	chmod +x scripts/*

# Usage

Here is a sample trial run:

	./scripts/download.rb CAM123 60
	./bin/split.run out/data/data_0
	./scripts/make_video.rb out/video.avi 8
