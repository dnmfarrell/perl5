# -*- buffer-read-only: t -*-
# !!!!!!!   DO NOT EDIT THIS FILE   !!!!!!!
# This file is built by regen/feature.pl.
# Any changes made here will be lost!

package feature;

our $VERSION = '1.53';

our %feature = (
    fc              => 'feature_fc',
    say             => 'feature_say',
    state           => 'feature_state',
    switch          => 'feature_switch',
    bitwise         => 'feature_bitwise',
    evalbytes       => 'feature_evalbytes',
    array_base      => 'feature_arybase',
    signatures      => 'feature_signatures',
    current_sub     => 'feature___SUB__',
    refaliasing     => 'feature_refaliasing',
    postderef_qq    => 'feature_postderef_qq',
    unicode_eval    => 'feature_unieval',
    declared_refs   => 'feature_myref',
    require_false   => 'feature_require_false',
    unicode_strings => 'feature_unicode',
);

our %feature_bundle = (
    "5.10"    => [qw(array_base say state switch)],
    "5.11"    => [qw(array_base say state switch unicode_strings)],
    "5.15"    => [qw(current_sub evalbytes fc say state switch unicode_eval unicode_strings)],
    "5.23"    => [qw(current_sub evalbytes fc postderef_qq say state switch unicode_eval unicode_strings)],
    "5.27"    => [qw(bitwise current_sub evalbytes fc postderef_qq say state switch unicode_eval unicode_strings)],
    "all"     => [qw(array_base bitwise current_sub declared_refs evalbytes fc postderef_qq refaliasing require_false say signatures state switch unicode_eval unicode_strings)],
    "default" => [qw(array_base)],
);

$feature_bundle{"5.12"} = $feature_bundle{"5.11"};
$feature_bundle{"5.13"} = $feature_bundle{"5.11"};
$feature_bundle{"5.14"} = $feature_bundle{"5.11"};
$feature_bundle{"5.16"} = $feature_bundle{"5.15"};
$feature_bundle{"5.17"} = $feature_bundle{"5.15"};
$feature_bundle{"5.18"} = $feature_bundle{"5.15"};
$feature_bundle{"5.19"} = $feature_bundle{"5.15"};
$feature_bundle{"5.20"} = $feature_bundle{"5.15"};
$feature_bundle{"5.21"} = $feature_bundle{"5.15"};
$feature_bundle{"5.22"} = $feature_bundle{"5.15"};
$feature_bundle{"5.24"} = $feature_bundle{"5.23"};
$feature_bundle{"5.25"} = $feature_bundle{"5.23"};
$feature_bundle{"5.26"} = $feature_bundle{"5.23"};
$feature_bundle{"5.28"} = $feature_bundle{"5.27"};
$feature_bundle{"5.29"} = $feature_bundle{"5.27"};
$feature_bundle{"5.30"} = $feature_bundle{"5.27"};
$feature_bundle{"5.9.5"} = $feature_bundle{"5.10"};
my %noops = (
    postderef => 1,
    lexical_subs => 1,
);

our $hint_shift   = 26;
our $hint_mask    = 0x1c000000;
our @hint_bundles = qw( default 5.10 5.11 5.15 5.23 5.27 );

# This gets set (for now) in $^H as well as in %^H,
# for runtime speed of the uc/lc/ucfirst/lcfirst functions.
# See HINT_UNI_8_BIT in perl.h.
our $hint_uni8bit = 0x00000800;

# TODO:
# - think about versioned features (use feature switch => 2)

=head1 NAME

feature - Perl pragma to enable new features

=head1 SYNOPSIS

    use feature qw(say switch);
    given ($foo) {
        when (1)          { say "\$foo == 1" }
        when ([2,3])      { say "\$foo == 2 || \$foo == 3" }
        when (/^a[bc]d$/) { say "\$foo eq 'abd' || \$foo eq 'acd'" }
        when ($_ > 100)   { say "\$foo > 100" }
        default           { say "None of the above" }
    }

    use feature ':5.10'; # loads all features available in perl 5.10

    use v5.10;           # implicitly loads :5.10 feature bundle

=head1 DESCRIPTION

It is usually impossible to add new syntax to Perl without breaking
some existing programs.  This pragma provides a way to minimize that
risk. New syntactic constructs, or new semantic meanings to older
constructs, can be enabled by C<use feature 'foo'>, and will be parsed
only when the appropriate feature pragma is in scope.  (Nevertheless, the
C<CORE::> prefix provides access to all Perl keywords, regardless of this
pragma.)

=head2 Lexical effect

Like other pragmas (C<use strict>, for example), features have a lexical
effect.  C<use feature qw(foo)> will only make the feature "foo" available
from that point to the end of the enclosing block.

    {
        use feature 'say';
        say "say is available here";
    }
    print "But not here.\n";

=head2 C<no feature>

Features can also be turned off by using C<no feature "foo">.  This too
has lexical effect.

    use feature 'say';
    say "say is available here";
    {
        no feature 'say';
        print "But not here.\n";
    }
    say "Yet it is here.";

C<no feature> with no features specified will reset to the default group.  To
disable I<all> features (an unusual request!) use C<no feature ':all'>.

=head1 AVAILABLE FEATURES

=head2 The 'say' feature

C<use feature 'say'> tells the compiler to enable the Perl 6 style
C<say> function.

See L<perlfunc/say> for details.

This feature is available starting with Perl 5.10.

=head2 The 'state' feature

C<use feature 'state'> tells the compiler to enable C<state>
variables.

See L<perlsub/"Persistent Private Variables"> for details.

This feature is available starting with Perl 5.10.

=head2 The 'switch' feature

B<WARNING>: Because the L<smartmatch operator|perlop/"Smartmatch Operator"> is
experimental, Perl will warn when you use this feature, unless you have
explicitly disabled the warning:

    no warnings "experimental::smartmatch";

C<use feature 'switch'> tells the compiler to enable the Perl 6
given/when construct.

See L<perlsyn/"Switch Statements"> for details.

This feature is available starting with Perl 5.10.

=head2 The 'unicode_strings' feature

C<use feature 'unicode_strings'> tells the compiler to use Unicode rules
in all string operations executed within its scope (unless they are also
within the scope of either C<use locale> or C<use bytes>).  The same applies
to all regular expressions compiled within the scope, even if executed outside
it.  It does not change the internal representation of strings, but only how
they are interpreted.

C<no feature 'unicode_strings'> tells the compiler to use the traditional
Perl rules wherein the native character set rules is used unless it is
clear to Perl that Unicode is desired.  This can lead to some surprises
when the behavior suddenly changes.  (See
L<perlunicode/The "Unicode Bug"> for details.)  For this reason, if you are
potentially using Unicode in your program, the
C<use feature 'unicode_strings'> subpragma is B<strongly> recommended.

This feature is available starting with Perl 5.12; was almost fully
implemented in Perl 5.14; and extended in Perl 5.16 to cover C<quotemeta>;
was extended further in Perl 5.26 to cover L<the range
operator|perlop/Range Operators>; and was extended again in Perl 5.28 to
cover L<special-cased whitespace splitting|perlfunc/split>.

=head2 The 'unicode_eval' and 'evalbytes' features

Together, these two features are intended to replace the legacy string
C<eval> function, which behaves problematically in some instances.  They are
available starting with Perl 5.16, and are enabled by default by a
S<C<use 5.16>> or higher declaration.

C<unicode_eval> changes the behavior of plain string C<eval> to work more
consistently, especially in the Unicode world.  Certain (mis)behaviors
couldn't be changed without breaking some things that had come to rely on
them, so the feature can be enabled and disabled.  Details are at
L<perlfunc/Under the "unicode_eval" feature>.

C<evalbytes> is like string C<eval>, but operating on a byte stream that is
not UTF-8 encoded.  Details are at L<perlfunc/evalbytes EXPR>.  Without a
S<C<use feature 'evalbytes'>> nor a S<C<use v5.16>> (or higher) declaration in
the current scope, you can still access it by instead writing
C<CORE::evalbytes>.

=head2 The 'current_sub' feature

This provides the C<__SUB__> token that returns a reference to the current
subroutine or C<undef> outside of a subroutine.

This feature is available starting with Perl 5.16.

=head2 The 'array_base' feature

This feature supports the legacy C<$[> variable.  See L<perlvar/$[> and
L<arybase>.  It is on by default but disabled under C<use v5.16> (see
L</IMPLICIT LOADING>, below).

This feature is available under this name starting with Perl 5.16.  In
previous versions, it was simply on all the time, and this pragma knew
nothing about it.

=head2 The 'fc' feature

C<use feature 'fc'> tells the compiler to enable the C<fc> function,
which implements Unicode casefolding.

See L<perlfunc/fc> for details.

This feature is available from Perl 5.16 onwards.

=head2 The 'lexical_subs' feature

In Perl versions prior to 5.26, this feature enabled
declaration of subroutines via C<my sub foo>, C<state sub foo>
and C<our sub foo> syntax.  See L<perlsub/Lexical Subroutines> for details.

This feature is available from Perl 5.18 onwards.  From Perl 5.18 to 5.24,
it was classed as experimental, and Perl emitted a warning for its
usage, except when explicitly disabled:

  no warnings "experimental::lexical_subs";

As of Perl 5.26, use of this feature no longer triggers a warning, though
the C<experimental::lexical_subs> warning category still exists (for
compatibility with code that disables it).  In addition, this syntax is
not only no longer experimental, but it is enabled for all Perl code,
regardless of what feature declarations are in scope.

=head2 The 'postderef' and 'postderef_qq' features

The 'postderef_qq' feature extends the applicability of L<postfix
dereference syntax|perlref/Postfix Dereference Syntax> so that postfix array
and scalar dereference are available in double-quotish interpolations. For
example, it makes the following two statements equivalent:

  my $s = "[@{ $h->{a} }]";
  my $s = "[$h->{a}->@*]";

This feature is available from Perl 5.20 onwards. In Perl 5.20 and 5.22, it
was classed as experimental, and Perl emitted a warning for its
usage, except when explicitly disabled:

  no warnings "experimental::postderef";

As of Perl 5.24, use of this feature no longer triggers a warning, though
the C<experimental::postderef> warning category still exists (for
compatibility with code that disables it).

The 'postderef' feature was used in Perl 5.20 and Perl 5.22 to enable
postfix dereference syntax outside double-quotish interpolations. In those
versions, using it triggered the C<experimental::postderef> warning in the
same way as the 'postderef_qq' feature did. As of Perl 5.24, this syntax is
not only no longer experimental, but it is enabled for all Perl code,
regardless of what feature declarations are in scope.

=head2 The 'signatures' feature

B<WARNING>: This feature is still experimental and the implementation may
change in future versions of Perl.  For this reason, Perl will
warn when you use the feature, unless you have explicitly disabled the
warning:

    no warnings "experimental::signatures";

This enables unpacking of subroutine arguments into lexical variables
by syntax such as

    sub foo ($left, $right) {
	return $left + $right;
    }

See L<perlsub/Signatures> for details.

This feature is available from Perl 5.20 onwards.

=head2 The 'refaliasing' feature

B<WARNING>: This feature is still experimental and the implementation may
change in future versions of Perl.  For this reason, Perl will
warn when you use the feature, unless you have explicitly disabled the
warning:

    no warnings "experimental::refaliasing";

This enables aliasing via assignment to references:

    \$a = \$b; # $a and $b now point to the same scalar
    \@a = \@b; #                     to the same array
    \%a = \%b;
    \&a = \&b;
    foreach \%hash (@array_of_hash_refs) {
        ...
    }

See L<perlref/Assigning to References> for details.

This feature is available from Perl 5.22 onwards.

=head2 The 'bitwise' feature

This makes the four standard bitwise operators (C<& | ^ ~>) treat their
operands consistently as numbers, and introduces four new dotted operators
(C<&. |. ^. ~.>) that treat their operands consistently as strings.  The
same applies to the assignment variants (C<&= |= ^= &.= |.= ^.=>).

See L<perlop/Bitwise String Operators> for details.

This feature is available from Perl 5.22 onwards.  Starting in Perl 5.28,
C<use v5.28> will enable the feature.  Before 5.28, it was still
experimental and would emit a warning in the "experimental::bitwise"
category.

=head2 The 'declared_refs' feature

B<WARNING>: This feature is still experimental and the implementation may
change in future versions of Perl.  For this reason, Perl will
warn when you use the feature, unless you have explicitly disabled the
warning:

    no warnings "experimental::declared_refs";

This allows a reference to a variable to be declared with C<my>, C<state>,
our C<our>, or localized with C<local>.  It is intended mainly for use in
conjunction with the "refaliasing" feature.  See L<perlref/Declaring a
Reference to a Variable> for examples.

This feature is available from Perl 5.26 onwards.

=head1 FEATURE BUNDLES

It's possible to load multiple features together, using
a I<feature bundle>.  The name of a feature bundle is prefixed with
a colon, to distinguish it from an actual feature.

  use feature ":5.10";

The following feature bundles are available:

  bundle    features included
  --------- -----------------
  :default  array_base

  :5.10     say state switch array_base

  :5.12     say state switch unicode_strings array_base

  :5.14     say state switch unicode_strings array_base

  :5.16     say state switch unicode_strings
            unicode_eval evalbytes current_sub fc

  :5.18     say state switch unicode_strings
            unicode_eval evalbytes current_sub fc

  :5.20     say state switch unicode_strings
            unicode_eval evalbytes current_sub fc

  :5.22     say state switch unicode_strings
            unicode_eval evalbytes current_sub fc

  :5.24     say state switch unicode_strings
            unicode_eval evalbytes current_sub fc
            postderef_qq

  :5.26     say state switch unicode_strings
            unicode_eval evalbytes current_sub fc
            postderef_qq

  :5.28     say state switch unicode_strings
            unicode_eval evalbytes current_sub fc
            postderef_qq bitwise

  :5.30     say state switch unicode_strings
            unicode_eval evalbytes current_sub fc
            postderef_qq bitwise

The C<:default> bundle represents the feature set that is enabled before
any C<use feature> or C<no feature> declaration.

Specifying sub-versions such as the C<0> in C<5.14.0> in feature bundles has
no effect.  Feature bundles are guaranteed to be the same for all sub-versions.

  use feature ":5.14.0";    # same as ":5.14"
  use feature ":5.14.1";    # same as ":5.14"

=head1 IMPLICIT LOADING

Instead of loading feature bundles by name, it is easier to let Perl do
implicit loading of a feature bundle for you.

There are two ways to load the C<feature> pragma implicitly:

=over 4

=item *

By using the C<-E> switch on the Perl command-line instead of C<-e>.
That will enable the feature bundle for that version of Perl in the
main compilation unit (that is, the one-liner that follows C<-E>).

=item *

By explicitly requiring a minimum Perl version number for your program, with
the C<use VERSION> construct.  That is,

    use v5.10.0;

will do an implicit

    no feature ':all';
    use feature ':5.10';

and so on.  Note how the trailing sub-version
is automatically stripped from the
version.

But to avoid portability warnings (see L<perlfunc/use>), you may prefer:

    use 5.010;

with the same effect.

If the required version is older than Perl 5.10, the ":default" feature
bundle is automatically loaded instead.

Unlike C<use feature ":5.12">, saying C<use v5.12> (or any higher version)
also does the equivalent of C<use strict>; see L<perlfunc/use> for details.

=back

=cut

sub import {
    shift;

    if (!@_) {
        croak("No features specified");
    }

    __common(1, @_);
}

sub unimport {
    shift;

    # A bare C<no feature> should reset to the default bundle
    if (!@_) {
	$^H &= ~($hint_uni8bit|$hint_mask);
	return;
    }

    __common(0, @_);
}


sub __common {
    my $import = shift;
    my $bundle_number = $^H & $hint_mask;
    my $features = $bundle_number != $hint_mask
	&& $feature_bundle{$hint_bundles[$bundle_number >> $hint_shift]};
    if ($features) {
	# Features are enabled implicitly via bundle hints.
	# Delete any keys that may be left over from last time.
	delete @^H{ values(%feature) };
	$^H |= $hint_mask;
	for (@$features) {
	    $^H{$feature{$_}} = 1;
	    $^H |= $hint_uni8bit if $_ eq 'unicode_strings';
	}
    }
    while (@_) {
        my $name = shift;
        if (substr($name, 0, 1) eq ":") {
            my $v = substr($name, 1);
            if (!exists $feature_bundle{$v}) {
                $v =~ s/^([0-9]+)\.([0-9]+).[0-9]+$/$1.$2/;
                if (!exists $feature_bundle{$v}) {
                    unknown_feature_bundle(substr($name, 1));
                }
            }
            unshift @_, @{$feature_bundle{$v}};
            next;
        }
        if (!exists $feature{$name}) {
            if (exists $noops{$name}) {
                next;
            }
            unknown_feature($name);
        }
	if ($import) {
	    $^H{$feature{$name}} = 1;
	    $^H |= $hint_uni8bit if $name eq 'unicode_strings';
	} else {
            delete $^H{$feature{$name}};
            $^H &= ~ $hint_uni8bit if $name eq 'unicode_strings';
        }
    }
}

sub unknown_feature {
    my $feature = shift;
    croak(sprintf('Feature "%s" is not supported by Perl %vd',
            $feature, $^V));
}

sub unknown_feature_bundle {
    my $feature = shift;
    croak(sprintf('Feature bundle "%s" is not supported by Perl %vd',
            $feature, $^V));
}

sub croak {
    require Carp;
    Carp::croak(@_);
}

1;

# ex: set ro:
