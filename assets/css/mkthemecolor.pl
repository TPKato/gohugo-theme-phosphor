#!/usr/bin/perl

# blue:		#0033bb
# green:	#008000
# red:		#dc143c
# yellow:	#ffd700

use strict;

sub usage {
    print STDERR "Usage: \n";
    print STDERR "  $0 [color in RRGGBB (hex) format]\n";
}

if ($#ARGV != 0) {
    usage();
    exit(1);
}

my @base = map { hex($_) } ($ARGV[0] =~ /(..)(..)(..)/);

print ":root {\n";
printf "  --theme-color: #%02x%02x%02x;\n\n", @base;

my $Ndark = 16;
for (my $i = 0; $i < $Ndark; $i++) {
    my $r = $base[0] * $i / $Ndark;
    my $g = $base[1] * $i / $Ndark;
    my $b = $base[2] * $i / $Ndark;
    printf "  --theme-color-dark%02d: #%02x%02x%02x;\n", $Ndark - $i, $r, $g, $b;
}

print "\n";

my $Nbase = 16;
for (my $i = 1; $i <= $Nbase; $i++) {
     my $r = $base[0] + (0xff - $base[0]) * $i / $Nbase;
     my $g = $base[1] + (0xff - $base[1]) * $i / $Nbase;
     my $b = $base[2] + (0xff - $base[2]) * $i / $Nbase;
    printf "  --theme-color%02d: #%02x%02x%02x;\n", $i, $r, $g, $b;
}

print "\n";

my $Npale = 4;
for (my $i = 1; $i < $Npale; $i++) {
    my $d = ($Nbase - 1) / $Nbase;

    my $r = $base[0] + (0xff - $base[0]) * $d * (1 + $i / ($Nbase * $Npale));
    my $g = $base[1] + (0xff - $base[1]) * $d * (1 + $i / ($Nbase * $Npale));
    my $b = $base[2] + (0xff - $base[2]) * $d * (1 + $i / ($Nbase * $Npale));
    printf "  --theme-color-pale%02d: #%02x%02x%02x;\n", $i, $r, $g, $b;
}

print "}\n";
