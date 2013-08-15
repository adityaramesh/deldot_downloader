#! /usr/bin/ruby

require 'rake'

i = 1
n = FileList["out/raw/*"].length
FileList["out/raw/*"].each do |f|
	FileList["out/frames/*"].each{ |l| File.delete(l) if File.file?(l) }
	`./bin/split.run #{f} 1> /dev/null`
	# We do not want to discard the output of FFmpeg, because we can miss
	# some important errors.
	`./scripts/make_video.rb out/#{File.basename(f)}.avi 8`
	puts "Converted #{i}/#{n}."
	i = i + 1
end
