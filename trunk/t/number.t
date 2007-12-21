#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
plan tests => 3 +
              5;

use_ok('HTML::Template::Pluggable');
use_ok('HTML::Template::Plugin::Dot');
use_ok('HTML::Template::Plugin::Dot::Helpers');

my $t1 = HTML::Template::Pluggable->new(
    scalarref       => \q{<tmpl_var name="Number.format_picture(some.value, '#,###,###.##')">=<tmpl_var some.value>},
    global_vars     => 1,
    case_sensitive  => 1,
    die_on_bad_params => 0,
    );
$t1->param( some => { value => 3_105_345.239_5 } );
my $o1 = $t1->output;
# diag("output: ", $o1);
like( $o1, qr/3,10/ );


my $t2 = HTML::Template::Pluggable->new(
    scalarref       => \q{<tmpl_if Number.gt(some.value,3)><tmpl_var name="Number.format_picture(some.value, '#,###,###.##')">=<tmpl_var some.value><tmpl_else>No</tmpl_if>},
    global_vars     => 1,
    case_sensitive  => 1,
    die_on_bad_params => 0,
    );
$t2->param( some => { value => 3_105_345.239_5 } );
my $o2 = $t2->output;
# diag("output: ", $o2);
like( $o2, qr/3,10/ );

$t2->param( some => { value => 1.053_45 } );
my $o3 = $t2->output;
# diag("output: ", $o3);
like( $o3, qr/No/ );

{
   package My::Obj;
   use overload q{""} => \&stringify, '0+' => \&stringify;
   
   sub new { bless {id=>3}, shift }
   sub stringify { return $_[0]->{id} }
}

my $t3 = HTML::Template::Pluggable->new(
    scalarref       => \q{<tmpl_if name="Number.lt(some.obj, 'A')">Yes<tmpl_else>No</tmpl_if> (<tmpl_var some.value> <tmpl_var some.obj>)},
    global_vars     => 1,
    case_sensitive  => 1,
    die_on_bad_params => 0,
    );
$t3->param( some => { value => 3_105_345.239_5, obj => My::Obj->new  } );
my $o4 = $t3->output;
# diag("output: ", $o4);
like( $o4, qr/Yes/ );

my $t4 = HTML::Template::Pluggable->new(
    scalarref       => \q{<tmpl_loop o.v:h><tmpl_var h.n> <tmpl_var name="Number.format_price(h.n)"></tmpl_loop>},
    global_vars     => 1,
    case_sensitive  => 1,
    die_on_bad_params => 0,
    );
$t4->param( o => { v => [ { n => 1.25 }, { n => 2.25 } ] } );
my $o5 = $t4->output;
# diag("output: ", $o4);
like( $o5, qr/Yes/ );


__END__
t/number....1..8
ok 1 - use HTML::Template::Pluggable;
ok 2 - use HTML::Template::Plugin::Dot;
ok 3 - use HTML::Template::Plugin::Dot::Helpers;
ok 4
ok 5
ok 6
ok 7
Bare word 'h.n' not allowed in argument list to 'format_price' in dot expression 'Number.format_price(h.n)' at /usr/share/perl5/Class/Trigger.pm line 51
# Looks like you planned 8 tests but only ran 7.
# Looks like your test died just after 7.
dubious
	Test returned status 255 (wstat 65280, 0xff00)
DIED. FAILED test 8
	Failed 1/8 tests, 87.50% okay
Failed 1/1 test scripts, 0.00% okay. 1/8 subtests failed, 87.50% okay.
Failed Test Stat Wstat Total Fail  Failed  List of Failed
-------------------------------------------------------------------------------
t/number.t   255 65280     8    2  25.00%  8
