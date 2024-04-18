#!/usr/bin/perl
use strict;
use warnings;
use Bio::Seq;
use Bio::Perl;
my $obj = Bio::Seq->new(-seq => 'CGCCGAAGAAGCATCGTTAAAGTCTCTCTTCACCCTGCCGTCATGTCTAAGTCAGAGTCTCCT',
                         -id  => 'myseq',

                         -alphabet => 'dna');

my $rev_com = revcom( $obj->seq() );
my $seq_id = $obj->id;

print "DNA sequence: ".$obj->seq()."\n";
print "Reverse complement: ".$rev_com->seq()."\n";
 my $output = Bio::SeqIO->new( -file   => ">".$seq_id.".fsa",-format => "fasta");
 
$output->write_seq($rev_com);