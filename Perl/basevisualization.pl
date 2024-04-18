#!/usr/bin/perl
use strict;
use warnings;
use GD::Graph::pie;

die "usage: fasta.pl filename\n" if scalar @ARGV < 1;

# get the filename
my ($filename) = @ARGV;

# Open the file on the command line
open(INFILE, $filename) or die "Can't open $filename\n";

# variables
my @header = ();		    
my @sequence = ();		    
my $count = 0;	           

# read FASTA file
my $n = -1;			    
# index of current sequence
while (my $line = <INFILE>) {
    chomp $line;		    # remove training \n from line
    if ($line =~ /^>/) { 	    # line starts with a ">"
	$n++;			    # this starts a new header
	$header[$n] = $line;	    # save header line
	$sequence[$n] = "";	    # start a new (empty) sequence
    }
    else {
	next if not @header;	    # ignore data before first header
	$sequence[$n] .= $line     # append to end of current sequence
    }
}
$count = $n+1;			  # set count to the number of sequences
close INFILE;

# remove white space from all sequences
$sequence[0] =~ s/\s//g;

my $charA = "[Aa]";
my $count_Of_A = () = $sequence[0] =~ /$charA/g;

my $charT = "[Tt]";
my $count_Of_T = () = $sequence[0] =~ /$charT/g;

my $charG = "[Gg]";
my $count_Of_G = () = $sequence[0] =~ /$charG/g;

my $charC = "[Cc]";
my $count_Of_C = () = $sequence[0] =~ /$charC/g;


my @counts = ('A '. $count_Of_A, 'T '. $count_Of_T, 'G '. $count_Of_G,'C ' .$count_Of_C);
my @data;
push(@data,$count_Of_A);
push(@data,$count_Of_T);
push(@data,$count_Of_G);
push(@data,$count_Of_C);

my @y = ( 
    @data 
);


    my $chart = GD::Graph::pie->new(600,600);
    my @chart_data = ( \@counts, \@data );
    $chart->set(
        title       => 'simple pie chart',
    );

    $chart->plot(\@chart_data);
    
    print $chart->gd->png;

exit