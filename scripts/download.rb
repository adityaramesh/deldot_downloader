#! /usr/bin/ruby

require 'rake'

if ARGV.length != 2
	puts "Usage: ./" + $PROGRAM_NAME + " <source> <framerate>"
	puts "Example: ./" + $PROGRAM_NAME + " CAM123 60"
	exit
end

fn = nil
l = FileList["out/raw/data*"].sort.last

if (l.nil?)
	fn = "data_0"
else
	s = l[/\d+/]
	if (s.nil?)
		puts "Found irregularly-named data file \"out/raw/${l}.\""
		puts "Please remove this file manually to continue."
		exit
	end
	n = s.to_i + 1
	fn = "data_#{n}"
end

`curl -v -0 -A "GTS VideoClient/2.5" -G -d "source=#{ARGV[0]}&framerate=#{ARGV[1]}" http://webvideoserv.deldot.gov/video.jpg > out/raw/#{fn}`
