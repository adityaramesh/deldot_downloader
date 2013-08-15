#! /usr/bin/ruby

if ARGV.length != 2
	puts "Usage: ./" + $PROGRAM_NAME + " <filename> <framerate>"
	puts "Example: ./" + $PROGRAM_NAME + " out/video.avi 8"
	exit
end

`ffmpeg -r #{ARGV[1]} -start_number 1 -i out/frames/frame_%d.jpg -vcodec mjpeg -q:v 1 -an #{ARGV[0]}`
