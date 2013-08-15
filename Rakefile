require 'rake/clean'

cxx       = ENV['CXX']
boost     = ENV['BOOST_INCLUDE_PATH']
ccbase    = ENV['CCBASE_INCLUDE_PATH']
langflags = "-std=c++11"
wflags    = "-Wall -Wno-return-type-c-linkage -Wno-unused-local-typedefs"
archflags = "-march=native"
incflags  = "-I. -I#{boost} -I#{ccbase}"
ppflags   = ""
optflags  = "-O3"
cxxflags  = "#{langflags} #{wflags} #{archflags} #{incflags} #{ppflags} #{optflags}"
dirs      = ["bin", "out", "out/frames", "out/raw"]
programs  = ["bin/split.run"]

task :default => dirs + programs

dirs.each do |d|
	directory d
end

programs.each do |f|
	src = f.sub("bin", "src").ext("cpp")
	file f => [src] + ["bin"] do
		sh "#{cxx} #{cxxflags} -o #{f} #{src}"
	end
end

task :clobber => ["bin"] do
	FileList["bin/*"].each{ |f| File.delete(f) if File.file?(f) }
	FileList["out/data/*"].each{ |f| File.delete(f) if File.file?(f) }
	FileList["out/frames/*"].each{ |f| File.delete(f) if File.file?(f) }
end
