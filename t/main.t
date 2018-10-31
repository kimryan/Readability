#------------------------------------------------------------------------------
# Test script for Lingua::EN::::Fathom.pm
#
# Author      : Kim Ryan, Kirk Kimmel
#------------------------------------------------------------------------------

use warnings;
use strict;
use Test::More tests => 10;

BEGIN {

  # does it load properly?
  require_ok('Lingua::EN::Fathom');
}

my $sample = q{
Returns the number of words in the analysed text file or block. A word must
consist of letters a-z with at least one vowel sound, and optionally an
apostrophe or hyphen. Items such as "&, K108, NSW" are not counted as words.
Common abbreviations such a U.S. or numbers like 1.23 will not denote the end of
a sentence.


};


my $text = Lingua::EN::Fathom->new();
$text->analyse_block($sample);

is( $text->num_chars, 313, 'sub num_chars' );
is( $text->num_words, 54,  'sub num_words' );
is( $text->num_sentences,      4,                'sub num_sentences' );
is( $text->num_text_lines,     5,                'sub num_text_lines' );
is( $text->num_blank_lines,    4,                'sub num_blank_lines' );
is( $text->num_paragraphs,     1,                'sub num_paragraphs' );

# When checking floating point values, precision can vary across hardware. So use
# a regular expression to test the first portion of the number
like( $text->percent_complex_words, qr/7.40740740740741/, 'sub percent_complex_words' );
like( $text->words_per_sentence,    qr/^13.5/, 'sub words_per_sentence' );
like( $text->fog,                   qr/^8.36296296296296/, 'sub fog' );
