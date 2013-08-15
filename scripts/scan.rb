#! /usr/bin/ruby

if ARGV.length != 1
	puts "Usage: ./" + $PROGRAM_NAME + " <minutes>"
	puts "Example: ./" + $PROGRAM_NAME + " 60"
	exit
end

t = ARGV[0].to_i
if t <= 0
	puts "Error: time must be a positive integer."
	exit
end

pl = []
t1 = Time.new
File.readlines('dat/camlist.txt').each do |line|
	pl.push Process.fork{exec "./scripts/download.rb #{line.strip}"}
end

t2 = Time.now
while ((t2 - t1) / 60).to_i < t
	sleep 60
	t2 = Time.now
end

pl.each do |p|
	Process.kill("TERM", p)
end

pl.each do |p|
	Process.wait(p)
end
