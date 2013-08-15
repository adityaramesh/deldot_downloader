/*
** File Name:	split.cpp
** Author:	Aditya Ramesh
** Date:	08/14/2013
** Contact:	_@adityaramesh.com
*/

#include <cstddef>
#include <fstream>
#include <ios>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <string>
#include <vector>
#include <boost/algorithm/string/predicate.hpp>
#include <boost/lexical_cast.hpp>
#include <ccbase/format.hpp>

static inline std::streamsize
get_frame(std::istream& is, std::vector<char>& buf)
{
	using boost::lexical_cast;
	using boost::starts_with;

	static const std::string b{"--RaNd0m"};
	static const std::string cl{"Content-length: "};

	std::string line{};

	do {
		std::getline(is, line);
	}
	while (is.good() && !starts_with(line, b));

	do {
		std::getline(is, line);
	}
	while (is.good() && !starts_with(line, cl));

	if (is.eof()) {
		return false;
	}
	else if (is.bad()) {
		throw std::runtime_error{"Error finding start of frame."};
	}

	std::size_t n;

	try {
		auto s = line.substr(cl.length(), line.length() - cl.length() - 1);
		n = boost::lexical_cast<std::size_t>(std::move(s));
	}
	catch (boost::bad_lexical_cast& e) {
		throw std::runtime_error{"Error parsing content length."};
	}

	if (n <= 0) {
		throw std::runtime_error{"Content length not positive."};
	}

	if (buf.size() < n) {
		buf.resize(n);
	}

	std::getline(is, line);
	if (!(line.length() == 1 && line[0] == '\r')) {
		throw std::runtime_error{"Expected \"\\r\\n\" before frame contents."};
	}
	
	is.read(buf.data(), n);

	if (is.bad()) {
		throw std::runtime_error{"Error reading frame contents."};
	}
	else {
		return true;
	}
}

int main(int ac, char** av)
{
	if (ac != 2) {
		cc::println("Usage: $0 data_file.", av[0]);
		return EXIT_SUCCESS;
	}

	std::ifstream is{av[1], std::ios::binary};
	std::vector<char> buf(50000);
	std::string bn{"out/frames/frame_"};

	for (std::size_t i = 1; get_frame(is, buf); ++i) {
		std::ofstream os{bn + boost::lexical_cast<std::string>(i) + ".jpg", std::ios::binary};
		if (!os) {
			cc::writeln(std::cerr, "Error opening \"$0\".", bn +
				boost::lexical_cast<std::string>(i) + ".jpg");
			return EXIT_FAILURE;
		}
		cc::println("Writing frame $0.", i);
		os.write(buf.data(), buf.size());
	}
	return EXIT_SUCCESS;
}
