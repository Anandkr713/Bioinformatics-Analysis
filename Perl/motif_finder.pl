print "Please type in the filename of the protein sequence : ";
$proteinfilename = <STDIN>;
chomp $proteinfilename ;
unless ( open(PROTEINFILE, $proteinfilename)) {
    print "Cannot open file \"$proteinfilename\"\n\n";
    exit;
}
@protein = <PROTEINFILE>;
close PROTEINFILE ;
$protein = join( '', @protein);
$protein =~ s/\s//g;
do {
    print "Enter a motif to search for: ";
    $motif = <STDIN>;
    chomp $motif;
    if ($protein =~ /$motif/ ) {
        print "I found it! \n\n" ;
    } else {
        print "I couldn\'t find it. \n\n";
    }
}until ($motif =~/^\s*$/ );
exit;