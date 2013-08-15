require 'rake/clean'

cxx       = ENV['CXX']
boost     = ENV['BOOST_INCLUDE_PATH']
ccbase    = ENV['CCBASE_INCLUDE_PATH']
langflags = "-std=c++11 -stdlib=libc++"
wflags    = "-Wall -Wno-return-type-c-linkage"
archflags = "-march=native"
incflags  = "-I. -I#{boost} -I#{ccbase}"
ppflags   = ""
optflags  = "-O3"
cxxflags  = "#{langflags} #{wflags} #{archflags} #{incflags} #{ppflags} #{optflags}"
programs  = ["bin/split.run"]

directory "bin"
directory "out"
directory "out/frames"
directory "out/raw"

task :default => programs

programs.each do |f|
	src = f.sub("bin", "src").ext("cpp")
	file f => [src] + ["bin"] do
		sh "#{cxx} #{cxxflags} -o #{f} #{src}"
	end
end

task :clobber => ["bin"] do
	FileList["bin/*"].each{ |f| File.delete(f) if File.file?(f) }
	FileList["out/*"].each{ |f| File.delete(f) if File.file?(f) }
end
