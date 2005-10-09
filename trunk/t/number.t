
use Test::More;
plan tests => 3 +
			  4;

use_ok('HTML::Template::Pluggable');
use_ok('HTML::Template::Plugin::Dot');
use_ok('HTML::Template::Plugin::Dot::Helpers');

my $t1 = HTML::Template::Pluggable->new(
	scalarref		=> \q{<tmpl_var name="Number.format_picture(some.value, '#,###,###.##')">=<tmpl_var some.value>},
	global_vars		=> 1,
	case_sensitive	=> 1,
	die_on_bad_params => 0,
	);
$t1->param( some => { value => 3105345.2395 } );
my $o1 = $t1->output;
# diag("output: ", $o1);
like( $o1, qr/3,10/ );


my $t2 = HTML::Template::Pluggable->new(
	scalarref		=> \q{<tmpl_if Number.gt(some.value,3)><tmpl_var name="Number.format_picture(some.value, '#,###,###.##')">=<tmpl_var some.value><tmpl_else>No</tmpl_if>},
	global_vars		=> 1,
	case_sensitive	=> 1,
	die_on_bad_params => 0,
	);
$t2->param( some => { value => 3105345.2395 } );
my $o2 = $t2->output;
# diag("output: ", $o2);
like( $o2, qr/3,10/ );

$t2->param( some => { value => 1.05345 } );
my $o3 = $t2->output;
# diag("output: ", $o3);
like( $o3, qr/No/ );

{
   package My::Obj;
   use overload '""' => \&stringify, '0+' => \&stringify;
   
   sub new { bless {id=>3}, shift }
   sub stringify { return shift()->{id} }
}

my $t3 = HTML::Template::Pluggable->new(
	scalarref		=> \q{<tmpl_if name="Number.lt(some.obj, 'A')">Yes<tmpl_else>No</tmpl_if> (<tmpl_var some.value> <tmpl_var some.obj>)},
	global_vars		=> 1,
	case_sensitive	=> 1,
	die_on_bad_params => 0,
	);
$t3->param( some => { value => 3105345.2395, obj => My::Obj->new  } );
my $o4 = $t3->output;
diag("output: ", $o4);
like( $o4, qr/Yes/ );

__END__
