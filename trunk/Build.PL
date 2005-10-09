use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'HTML::Template::Plugin::Dot::Helpers',
    license             => 'perl',
    dist_author         => 'Rhesa Rozendaal <rhesa@cpan.org>',
    dist_version_from   => 'lib/HTML/Template/Plugin/Dot/Helpers.pm',
    requires => {
        'Test::More'				  => 0,
		'HTML::Template::Plugin::Dot' => 0.96,
		'HTML::Template::Pluggable'   => 0.12,
		'Number::Format'			  => 0,
    },
    add_to_cleanup      => [ 'HTML-Template-Plugin-Dot-Helpers-*' ],
	create_makefile_pl  => 'traditional',
	create_readme       => 1,
		
);

$builder->create_build_script();
