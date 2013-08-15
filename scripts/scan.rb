#! /usr/bin/ruby

File.readlines('dat/camlist.txt').each do |line|
	Process.fork{exec "./scripts/download.rb #{line.strip}"}
end
