#!/usr/bin/perl

## 6801/6803 disassembler
## Michael Shimniok
## www.bot-thoughts.com

use Getopt::Std;

$labelPrefix = "_L";

sub usage() {
	printf STDERR "dis.pl [-a] [-c] [-b 0xNNNN] [-e 0xMMMM] [-l 0xPPPP] filename\n";
	printf STDERR "\t-b 0xNNNN specifies the file offset at which to start\n";
	printf STDERR "\t-e 0xMMMM specifies the file offset at which to end\n";
	printf STDERR "\t-l 0xPPPP specifies the load address of the code (e.g., 0xD000)\n";
	exit -1;
}

my $firstByte = 0;
my $lastByte = -1;
my $startAddr = 0;

# Command Line Options
my %opt = ();
getopts('acb:l:', \%opt) || usage();
$printAddr = defined $opt{a};
$printCodes = defined $opt{c};
if ($#ARGV == 0) {
	$filename = $ARGV[0];
} else {
	usage();
}
## Beginning address specifies where in the file to start disassembling
if (defined $opt{b}) {
	$firstByte = hex($opt{b});
}
## Ending address specifies where in the file to stop disassembling
if (defined $opt{e}) {
	$lastByte = hex($opt{e});
}
## Load address is the address where you want the first assembly instruction to start
if (defined $opt{l}) {
	$startAddr = hex($opt{l});
}

# read config file
open(my $cfg, "<", "dis.cfg") || die "can't open config";
while (<$cfg>) {
	chomp;
	next if (/^#/);
	my($op, $bytes, $mne, $mode) = split(',');
	$op =~ tr/A-F/a-f/;
	$BYTES{$op} = $bytes;
	$MNE{$op} = $mne;
	$MODE{$op} = $mode;
}
close($cfg);

# read labels file
open(my $labels, "<", "labels.cfg") || die "can't open labels";
while (<$labels>) {
	chomp;
	($addr, $label) = split(/,/);
	if ($LBL{$label}++) {
		printf "duplicate label %s\n", $label;
	}
	$LABEL{hex $addr} = $label;
}
close($labels);


# Read each operand and keep track of address references
open(my $bin, "<", $filename) || die "can't open bin";
seek $bin, $firstByte, 0 && die "problem seeking";
binmode $bin;
$addr = $startAddr;
%LINE = ();
while (read $bin, my $x, 1) {

	my $opAddr = $addr++;
	
	# Get opcode in hex
	$op = sprintf "%02x", unpack "C", $x;
	$op =~ tr/A-F/a-f/;
	$LINE{$opAddr}->{"op"} = $op;

	# initialize
	my $arg = $oper = ();
	my $bc = $BYTES{$op};
	my $line = "";

	unless (exists $MODE{$op}) {
		printf "\n\n### %04x: unrecognized opcode %02x\n\n", $addr, $op;
	}

	# if We're not in inherent mode, there are 2-3 bytes of operand
	if ($bc > 1) {
		# Get the 1st operand byte
		read $bin, my $x, 1;
		$a1 = unpack "C", $x;
		$addr++;
		
		if ($bc == 3) {
			# read 2nd operand byte
			read $bin, my $y, 1;
			$addr++;
			$a2 = unpack "C", $y;
		}
		
		# Figure out address references
		my $mode = $MODE{$op};
		if ($mode eq 'direct' && $bc == 2) {
			$REF{$a1}++;
		} elsif ($mode eq 'extend' && $bc == 3) {
			$LINE{$opAddr}->{"o2"} = $a2;
			$REF{ ($a1<<8)|$a2 }++;
		} elsif ($mode eq 'relative' && $bc == 2) {
			#printf "\n########## \$a1 = %d\n%04x\n\n", $a1, $addr + $a1;
			$a1 = unpack "c", $x; # signed, relative addressing
			$REF{ $opAddr+2+$a1 }++;
		}
		$LINE{$opAddr}->{"o1"} = $a1;
			
	}		
}
close($bin);

print " "x6 if ($printAddr);
print " "x12 if ($printCodes);
print " "x8;
printf "org \$%04x\n", $startAddr;

# For each opcode address, disassemble and print result
foreach $addr (sort keys %LINE) {
	my $op = $LINE{$addr}->{"op"};
	my $bc = $BYTES{$op};
	my $a1 = "";
	my $a2 = "";
	my $operand = "";

	if (exists $LINE{$addr}->{"o1"}) {
		$a1 = $LINE{$addr}->{"o1"};
		$operand .= sprintf "%02x", $a1;
		if (exists $LINE{$addr}->{"o2"}) {
			$a2 = $LINE{$addr}->{"o2"};
			$operand .= sprintf "%02x", $a2;
		}
	}
	
	# Format and Print Operand
	#
	# relative $xxxx (calculated by oper address + $oper which is signed -127 to 128)
	# immed #$xx or #$xxxx
	# direct $xx (addresses first 256 bytes in mem)
	# index VAR,X or ,X if VAR is 0
	# extend $xxxx
	my $oper = "";
	my $mode = $MODE{$op};
	if ($bc > 1) {
		if ($mode eq 'immed' && $bc == 2) {
			$oper .= sprintf "#\$%02x", $a1;
		} elsif ($mode eq 'immed' && $bc == 3) {
			my $calcAddr = ($a1<<8)|$a2;
			if (exists $LABEL{$calcAddr}) {
				$oper .= sprintf "#%s", $LABEL{$calcAddr};
			} else {
				$oper .= sprintf "#\$%04x", $calcAddr;
			}
		} elsif ($mode eq 'direct' && $bc == 2) {
			if (exists $LABEL{$a1}) {
				$oper .= $LABEL{$a1};
			} else {
				$oper .= (exists $REF{$a1}) ? "D" : "\$";	
				$oper .= sprintf "%02x", $a1;
			}
		} elsif ($mode eq 'extend' && $bc == 3) {
			my $calcAddr = ($a1<<8)|$a2;
			if (exists $LABEL{$calcAddr}) {
				$oper .= $LABEL{$calcAddr};
			} else {
				#$oper .= "**** " if ($calcAddr > d000 && $calcAddr < $startAddr);
				$oper .= (exists $REF{$calcAddr}) ? $labelPrefix : "\$";
				$oper .= sprintf "%04x", $calcAddr;
			}
		} elsif ($mode eq 'index' && $bc == 2) {
			$oper .= sprintf "\$%02x", $a1 if ($a1 != 0);
			$oper .= ",X";
		} elsif ($mode eq 'relative' && $bc == 2) {
			##$a1 -= 256 if ($a1 > 127); # calculate relative from operand
			my $calcAddr = $addr + 2 + $a1;
			#printf "\n########## \$a1 = %d\n%04x\n\n", $a1, $addr + $a1;
			$oper .= (exists $REF{$calcAddr}) ? $labelPrefix : "\$";
			$oper .= sprintf "%04x", $calcAddr;
		} else {
			printf "\n\n####### unrecognized mode #######\n\n";
		}
	}

	# Print address, opcode byte, operand bytes, label, mnemonic, operand
	printf "%04x: ", $addr if ($printAddr);
	printf "%-4s %-6s ", $op, $operand if ($printCodes);
	$label = ($REF{$addr}) ? sprintf "%s%04x:", $labelPrefix, $addr : "";
	printf "%-7s ", $label;
	printf "%-5s %s", $MNE{$op}, $oper;	
	printf "\n";
}

exit;

