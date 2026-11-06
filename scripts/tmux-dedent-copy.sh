#!/usr/bin/env perl
# tmux copy-mode pipe: strip common indent (+ Claude Code "● "/"⎿" gutter),
# then put result in tmux buffer and Wayland clipboard.
use strict;
use warnings;
use utf8;
binmode STDIN, ':encoding(UTF-8)';

local $/;
my $s = <STDIN> // '';
my $nl = $s =~ /\n\z/;
my @l = split /\n/, $s, -1;
pop @l if $nl;
exit 0 unless @l;

s/[ \t]+$// for @l;

# first line starting with Claude Code marker: drop marker, skip it in indent calc
my $skip_first = $l[0] =~ s/^ *[●⎿] +//;

my $min;
for my $i (($skip_first ? 1 : 0) .. $#l) {
    next if $l[$i] eq '';
    my ($ind) = $l[$i] =~ /^( *)/;
    $min = length $ind if !defined $min || length $ind < $min;
}
$min //= 0;

if ($min) {
    for my $i (($skip_first ? 1 : 0) .. $#l) {
        $l[$i] =~ s/^ {0,$min}//;
    }
}

my $out = join("\n", @l) . ($nl ? "\n" : '');

for my $cmd ('tmux load-buffer -', 'wl-copy') {
    open my $fh, '|-', $cmd or next;
    binmode $fh, ':encoding(UTF-8)';
    print $fh $out;
    close $fh;
}
