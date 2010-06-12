use inc::Module::Install;
name 'Board';
all_from 'lib/Board.pm';

requires 'Text::MicroTemplate';
requires 'CGI';
requires 'DBIx::Skinny';
requires 'Path::Class';
requires 'FindBin::libs';
requires 'Class::Accessor::Fast';
requires 'Config::INI';
requires 'Config';
requires 'HTTP::Message';
requires 'HTTP::Headers';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
