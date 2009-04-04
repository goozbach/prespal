#!/usr/bin/perl
use strict;
use warnings;
use GD::Barcode::QRcode; 

print GD::Barcode::QRcode->new(@ARGV, {Ecc => 'L', Version=>4, ModuleSize => 5})->plot->gif;
