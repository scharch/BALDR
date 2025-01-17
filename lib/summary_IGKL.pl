#!/usr/bin/perl -w
use strict;

open OUT,">Results_IGKL_rank_all.txt" or die $!;

print OUT "Sample\tChain\tMethod\tRank\tQuery\tError\tVariable coords\tModel length\tBowtie2 count\tVJ length\tVJ Bowtie2 count\tV subject id\tV % identity\tV alignment length\tV mismatches\tV gap opens\tV gaps\tV q. start\tV q. end\tV s. start\tV s. end\tV evalue\tV bit score\tJ subject id\tJ % identity\tJ alignment length\tJ mismatches\tJ gap opens\tJ gaps\tJ q. start\tJ q. end\tJ s. start\tJ s. end\tJ evalue\tJ bit score\tC subject id\tC %identity\tC alignment length\tC mismatches\tC gap opens\tC gaps\tC q. start\tC q. end\tC s. start\tC s. end\tC evalue\tC bit score\tTop V gene match\tTop J gene match\tChain type\tstop codon\tV-J frame\tProductive\tStrand\tV end\tV-J junction\tJ start\tCDR3\tCDR3_nucleotide\tCDR3_aminoacid\tOrientation\tSequence\tSequence(+)\tVJ sequence\n";

for (my $i=0; $i<=$#ARGV; $i++) {
  my @files = <$ARGV[$i]/*IGKL.filtered>;
  if ($#files < 0) { @files = <$ARGV[$i]/*IGKL>; }

  foreach my $f(@files)
  {
    my $method = "";
    if($f=~/IG-mapped_Unmapped/){$method = "IG_Unmapped";}
    elsif($f=~/FilterNonIG/){$method = "FilterNonIG";}
    elsif($f=~/Unfiltered/){$method = "Unfiltered";}
    elsif($f=~/IG-mapped/){$method = "IG";}
    elsif($f=~/Recombinome/){$method = "Recombinome";}
    elsif($f=~/IMGT/){$method = "IMGT";}

    $f=~/.*?\/+(.*).igblast/;
    my $sample = $1;
    my $chain = "Light";
  #  print OUT "$sample\t$chain\t$method\t";
    
    open IN,"$f" or die $!;
    my $rank=0;
    while(my $ln = <IN>)
    {
      $ln=~s/\r//g;
      $rank++;
  #    if($rank == 1)
  #    {
  #      print OUT "$rank\t$ln";
  #    }
  #    else
  #    {
        print OUT "$sample\t$chain\t$method\t$rank\t$ln";
  #    }
    }
    close IN;
    print OUT "\n";
  }
}

close OUT;
