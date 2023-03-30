#!/usr/bin/perl
#Copyright 2023 CloudXaaS
#https://cloudxaas.com/
#https://github.com/cloudxaas/gorepomaintenance
#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#save this file in the parent directory of the go repository
use strict;

if (scalar(@ARGV) != 1) {
        die("Needs the directory as argument e.g. ./gotestall.pl ./");
}

my @dirs = ($ARGV[0]);

while (@dirs) {
        my $thisdir = shift @dirs;
        opendir my $dh, $thisdir;
        while (my $entry = readdir $dh) {

                next if $entry eq '.';
                next if $entry eq '..';

                my $fullname = "$thisdir/$entry";
                if ($fullname =~ m!_test.go!o) {
                        #print "FOUND: $fullname\n$thisdir\n"; 
                        #print "Testing file
                        system('go test '.$thisdir);
                        last;
                }else{  
                        if (-d $fullname) {
                                push @dirs, $fullname;
                        }
                }
        }
}
