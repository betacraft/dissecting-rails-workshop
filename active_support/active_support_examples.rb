require 'active_support/all'
array = [1, 2, 3, 4]

# The built-in Ruby method Array#first returns the first element of the array
p array.first

# Active Support provides additional methods for arrays. Here, we require the
# core extension for arrays, which adds the Array#second method to the class
require 'active_support/core_ext/array'

# Array#second returns the second element of the array
p array.second

# Active Support also adds additional methods like Array#excluding, which
# returns a copy of the array with the specified elements removed
p %w[David Rafael Aaron Todd].excluding('Aaron', 'Todd') # => ['David', 'Rafael']

# Array#extract! removes and returns elements that satisfy a given block
numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
odd_numbers = numbers.extract!(&:odd?)
p odd_numbers # => [1, 3, 5, 7, 9]
p numbers # => [0, 2, 4, 6, 8]

# Array#from returns a new array that starts from the specified index
p %w[a b c d].from(0)  # => ['a', 'b', 'c', 'd']
p %w[a b c d].from(2)  # => ['c', 'd']
p %w[a b c d].from(10) # => []
p %w[].from(0)         # => []
p %w[a b c d].from(-2) # => ['c', 'd']
p %w[a b c].from(-10)  # => []

# Array#including returns a new array that includes the specified elements
p [1, 2, 3].including(4, 5) # => [ 1, 2, 3, 4, 5 ]

# The method Inquiry creates an object that represents a hash and provides
# methods for querying it
pets = %i[cat dog].inquiry

# Inquiry methods return true or false based on whether the hash contains the
# specified key(s)
p pets.cat?     # => true
p pets.ferret?  # => false
p pets.any?(:cat, :ferret) # => true
p pets.any?(:ferret, :alligator) # => false

# Array#second_to_last returns the second to last element of the array
p %w[a b c d e].second_to_last # => 'd'

# Array#split divides the array into subarrays based on a delimiter or block
p [1, 2, 3, 4, 5].split(3) # => [[1, 2], [4, 5]]
(1..10).to_a.split { |i| (i % 3).zero? } # => [[1, 2], [4, 5], [7, 8], [10]]

# Array#to returns a new array containing elements from the beginning up to
# the specified index
p %w[a b c d].to(0)  # => ['a']
p %w[a b c d].to(2)  # => ['a', 'b', 'c']
p %w[a b c d].to(10) # => ['a', 'b', 'c', 'd']
p %w[].to(0) # => []

####################################################
# Time and date
time = Time.now

require 'active_support/core_ext/date_time'
require 'active_support/core_ext/date'

date = time.to_date

# * after?
# Returns true if the date/time falls after date_or_time.
p date.after?(date.tomorrow) #=> false

# * before?
# Returns true if the date/time falls before date_or_time.
p date.before?(date.tomorrow) #=> true

# * beginning of (mont/quarter/year)
today = Date.today
p today.beginning_of_quarter # First day of the quarter for today's date
p today.beginning_of_month # First day of the month for today's date
p today.beginning_of_year # First day of the year for today's date

# * return monday of the week
p today.monday # The Monday of the current week for today's date

# * next occurring day
# Returns a new date/time representing the next occurrence of the specified day of week.
p today.next_occurring(:monday) # The next Monday after today's date
p today.next_occurring(:thursday) # The next Thursday after today's date

date = Time.now.to_date

# * Tomorrow
# Returns a new date/time object representing the next day
p date.tomorrow

# * Yesterday
# Returns a new date/time object representing the previous day
p date.yesterday

# * Change
# Changes the date to the specified date
p Date.new(2007, 5, 12).change(day: 1)               # => Date.new(2007, 5, 1)
p Date.new(2007, 5, 12).change(year: 2005, month: 1) # => Date.new(2005, 1, 12)

# * to_fs(format = :default)
date = Date.new(2007, 11, 10) # => Sat, 10 Nov 2007

# Formats the date according to the specified format
p date.to_fs(:db)                     # => "2007-11-10"
p date.to_formatted_s(:db)            # => "2007-11-10"
p date.to_fs(:short)         # => "10 Nov"
p date.to_fs(:number)        # => "20071110"
p date.to_fs(:long)          # => "November 10, 2007"
p date.to_fs(:long_ordinal)  # => "November 10th, 2007"
p date.to_fs(:rfc822)        # => "10 Nov 2007"
p date.to_fs(:iso8601)       # => "2007-11-10"

# * to_time(form = :local)
# Converts a Date instance to a Time, where the time is set to the beginning of the day.
date = Date.new(2007, 11, 10) # => Sat, 10 Nov 2007

# Converts the date to a Time object with the time set to the beginning of the day
p date.to_time                   # => 2007-11-10 00:00:00 +0530
p date.to_time(:local)           # => 2007-11-10 00:00:00 +0530
p date.to_time(:utc)             # => 2007-11-10 00:00:00 UTC

t = Time.now

# * ago(seconds)
# Converts Date to a Time (or DateTime if necessary) with the time portion set to the beginning of the day (0:00) and then subtracts the specified number of seconds.
p t.ago(5)             # 5 seconds before current time
p t.days_ago(3)        # 3 days before current time
p t.weeks_ago(2)       # 2 weeks before current time
p t.months_ago(2)      # 2 months before current time
p t.years_ago(2)       # 2 years before current time

# * time of day
p t.noon               # returns the time with the time portion set to 12:00
p t.midnight           # returns the time with the time portion set to 00:00
p t.midday             # same as t.noon
p t.end_of_day         # returns the time with the time portion set to 23:59:59

# * since/in
# Converts Date to a Time (or DateTime if necessary) with the time portion set to the beginning of the day (0:00) and then adds the specified number of seconds
p t.since(5)           # 5 seconds after current time
p t.days_since(3)      # 3 days after current time
p t.weeks_since(2)     # 2 weeks after current time
p t.months_since(2)    # 2 months after current time
p t.years_since(2)     # 2 years after current time

# * ranges
# gives the dateTime range of day
p t.all_day            # returns the time range for the entire day
p t.all_month          # returns the time range for the entire month
p t.all_year           # returns the time range for the entire year
p t.all_quarter        # returns the time range for the entire quarter
p t.all_week           # returns the time range for the entire week

# * beginning
p t.beginning_of_month # returns the time with the day portion set to 1 and time set to 00:00
p t.beginning_of_year  # returns the time with the day and month portion set to 1 and time set to 00:00
p t.beginning_of_quarter # returns the time with the day portion set to the first day of the quarter and time set to 00:00
p t.beginning_of_week  # returns the time with the day portion set to Monday of the week and time set to 00:00
p t.beginning_of_day   # returns the time with the time portion set to 00:00

# * end
p t.end_of_month       # returns the time with the day portion set to the last day of the month and time set to 23:59:59
p t.end_of_year        # returns the time with the day and month portion set to December 31 and time set to 23:59:59
p t.end_of_quarter     # returns the time with the day portion set to the last day of the quarter and time set to 23:59:59
p t.end_of_week        # returns the time with the day portion set to Sunday of the week and time set to 23:59:59
p t.end_of_day         # returns the time with the time portion set to 23:59:59

# * last
p t.last_month        # returns the time for the same day and time in the previous
#################################################
# Enumerable

require 'active_support/all'

# Compact blank
# Returns a new Array without the blank items. Uses Object#blank? for detection.
array = [' ', '', '    ', 2.5, 'demo', {}, false]
p array.compact_blank # => [2.5, 'demo']

# Many, one, any
# Checks if the predicate is true for any/all/none of the elements.
p array.many? { |e| e == false } # false
p array.one? { |e| e == false } # true
p array.any? { |e| e == false } # true

# Pick
# Extract the given key from the first element in the enumerable.
p [{ name: 'David' }, { name: 'Rafael' }, { name: 'Aaron' }].pick(:name)
# => 'David'

p [{ id: 1, name: 'David' }, { id: 2, name: 'Rafael' }].pick(:id, :name)
# => [1, 'David']

# Pluck
# Extract the given key from each element in the enumerable.
p [{ name: 'David' }, { name: 'Rafael' }, { name: 'Aaron' }].pluck(:name)
# => ['David', 'Rafael', 'Aaron']
p [{ id: 1, name: 'David' }, { id: 2, name: 'Rafael' }].pluck(:id, :name)
# => [[1, 'David'], [2, 'Rafael']]

# Sole
# Returns the sole item in the enumerable or raises an exception if there is not exactly one item.
p ["x"].sole          # => "x"
# Set.new.sole        # => Enumerable::SoleItemExpectedError: no item found
# { a: 1, b: 2 }.sole # => Enumerable::SoleItemExpectedError: multiple items found

# Sum
# Calculates a sum from the elements.
p [5, 15, 10].sum # => 30
p ['foo', 'bar'].sum('') # => "foobar"
p [[1, 2], [3, 1, 5]].sum([]) # => [1, 2, 3, 1, 5]

################################################################
# Hash
# * compact_blank!()
# Removes all blank values from the Hash in place and returns self.
h = { a: "", b: 1, c: nil, d: [], e: false, f: true }
p h.compact_blank!
# => { b: 1, f: true }

# * deep_merge(other_hash, &block)
# Returns a new hash with self and other_hash merged recursively.
h1 = { a: true, b: { c: [1, 2, 3] } }
h2 = { a: false, b: { x: [3, 4, 5] } }

p h1.deep_merge(h2) # => { a: false, b: { c: [1, 2, 3], x: [3, 4, 5] } }

# * except!(*keys)
# Removes the given keys from hash and returns it.
hash = { a: true, b: false, c: nil }
p hash.except!(:c) # => { a: true, b: false }

# * extract!(*keys)
# Removes and returns the key/value pairs matching the given keys.
hash = { a: 1, b: 2, c: 3, d: 4 }
p hash.extract!(:a, :b) # => {:a=>1, :b=>2}

# * slice!(*keys)
# Replaces the hash with only the given keys. Returns a hash containing the removed key/value pairs.
hash = { a: 1, b: 2, c: 3, d: 4 }
p hash.slice!(:a, :b)  # => {:c=>3, :d=>4}

#####################################################################
# Integers and numerics

# * Months / Month / years
p 2.months # => 2 months
# Returns a ActiveSupport::Duration object that represents 2 months

p 2.years # => 2 years
# Returns a ActiveSupport::Duration object that represents 2 years

p 2.days
# Returns a ActiveSupport::Duration object that represents 2 days

p 2.weeks
# Returns a ActiveSupport::Duration object that represents 2 weeks

p 2.seconds
# Returns a ActiveSupport::Duration object that represents 2 seconds

p 2.hours
# Returns a ActiveSupport::Duration object that represents 2 hours

# * multiple_of?(number)
# Check whether the integer is evenly divisible by the argument.

p 0.multiple_of?(0)  # => true
# Returns true because any number is evenly divisible by 0

p 6.multiple_of?(5)  # => false
# Returns false because 6 is not evenly divisible by 5

p 10.multiple_of?(2) # => true
# Returns true because 10 is evenly divisible by 2

# * ordinal()
# Ordinal returns the suffix used to denote the position in an ordered sequence such as 1st, 2nd, 3rd, 4th.

p 1.ordinal     # => "st"
# Returns the ordinal suffix for 1, which is "st"

p 2.ordinal     # => "nd"
# Returns the ordinal suffix for 2, which is "nd"

p 1002.ordinal  # => "nd"
# Returns the ordinal suffix for 1002, which is "nd"

p 1003.ordinal  # => "rd"
# Returns the ordinal suffix for 1003, which is "rd"

p -11.ordinal   # => "th"
# Returns the ordinal suffix for -11, which is "th"

p -1001.ordinal # => "st"
# Returns the ordinal suffix for -1001, which is "st"

# * ordinalize()
# Ordinalize returns the number with its ordinal suffix.

p 1.ordinalize     # => "1st"
# Returns "1st" because 1 has the ordinal suffix "st"

p 2.ordinalize     # => "2nd"
# Returns "2nd" because 2 has the ordinal suffix "nd"

p 1002.ordinalize  # => "1002nd"
# Returns "1002nd" because 1002 has the ordinal suffix "nd"

p 1003.ordinalize  # => "1003rd"
# Returns "1003rd" because 1003 has the ordinal suffix "rd"

p -11.ordinalize   # => "-11th"
# Returns "-11th" because -11 has the ordinal suffix "th"

p -1001.ordinalize # => "-1001st"
# Returns "-1001st" because -1001 has the ordinal suffix "st"

# bytes/kilobytes/megabytes/gigabytes, etc.
p 2.bytes  # => 2
p 2.kilobytes  # => 2048

# hours/seconds/minutes, etc.
p 2.hours.in_milliseconds  # => 7200000
p 2.days.in_seconds  # => 172800
p 2.days.in_hours  # => 48
p 7.years.in_weeks  # => 364
#######################################################################
# Misc
# * overlaps?(other)
#  Compare two ranges and see if they overlap each other
(1..5).overlaps?(4..6) # => true
(1..5).overlaps?(7..9) # => false

# * try
# helps to reduce conditional statements
# without try
unless @number.nil?
  @number.next
end

# with try
@number.try(:next)
##############################################################
# * Strings
# Define a string to work with
str = "hello world"

# * at(position)
# Return the characters at positions of the string
str.at(0)      # => "h"
str.at(1..3)   # => "ell"
str.at(-2)     # => "l"
str.at(-2..-1) # => "ld"
str.at(5)      # => " "
str.at(5..-1)  # => " world"

# * blank?
# A string is blank if it's empty or contains whitespace only
''.blank?       # => true
'   '.blank?    # => true
"\t\n\r".blank? # => true
' hello '.blank? # => false

# * camelcase(first_letter = :upper)/ camelize(first_letter = :upper)
# converts strings to UpperCamelCase. If the argument to camelize is set to :lower then camelize produces lowerCamelCase.
'active_record'.camelize                # => "ActiveRecord"
'active_record'.camelize(:lower)        # => "activeRecord"
'active_record/errors'.camelize         # => "ActiveRecord::Errors"
'active_record/errors'.camelize(:lower) # => "activeRecord::Errors"

# * classify()
# Creates a class name from a plural table name like Rails does for table names to models. 
'ham_and_eggs'.classify # => "HamAndEgg"
'posts'.classify        # => "Post"

# * dasherize()
# Replaces underscores with dashes in the string.
'pani_puri'.dasherize # => "pani-puri"

# * upcase_first()
# Converts the first character to uppercase.
'if they enjoyed The Matrix'.upcase_first # => "If they enjoyed The Matrix"
'i'.upcase_first                          # => "I"
''.upcase_first                           # => ""

# * exclude?(string)
# The inverse of String#include?. Returns true if the string does not include the other string.
"hello".exclude? "lo" # => false
"hello".exclude? "ol" # => true
"hello".exclude? ?h   # => false

# * first(limit = 1)
# Returns the first character. If a limit is supplied, returns a substring from the beginning of the string until it reaches the limit value.
str = "hello"
str.first    # => "h"
str.first(1) # => "h"
str.first(2) # => "he"
str.first(0) # => ""
str.first(6) # => "hello"

# * from(position)
# Returns a substring from the given position to the end of the string. If the position is negative, it is counted from the end of the string.
str = "hello world"
str.from(0)    # => "hello world"
str.from(6)    # => "world"
str.from(-5)   # => "world"

# * pluralize(count = nil, locale = :en)
# Returns the plural form of the word in the string.
'post'.pluralize             # => "posts"
'octopus'.pluralize          # => "octopi"
'sheep'.pluralize            # => "sheep"
'words'.pluralize            # => "words"
'the blue mailman'.pluralize # => "the blue mailmen"
'CamelOctopus'.pluralize     # => "CamelOctopi"
'apple'.pluralize(1)         # => "apple"
'apple'.pluralize(2)         # => "apples"
'ley'.pluralize(:es)         # => "leyes"
'ley'.pluralize(1, :es)      # => "ley

# * remove(*patterns)
# Returns a new string with all occurrences of the patterns removed.
str = "foo bar test"
str.remove(" test")                 # => "foo bar"
str.remove(" test", /bar/)          # => "foo "
str                                 # => "foo bar test"

# * singularize(locale = :en)
# The reverse of pluralize, returns the singular form of a word in a string.
'posts'.singularize            # => "post"
'octopi'.singularize           # => "octopus"
'sheep'.singularize            # => "sheep"
'word'.singularize             # => "word"
'the blue mailmen'.singularize # => "the blue mailman"
'CamelOctopi'.singularize      # => "CamelOctopus"
'leyes'.singularize(:es)       # => "ley"

# * squish()
# Returns the string, first removing all whitespace on both ends of the string, and then changing remaining consecutive whitespace groups into one space each.
%{ Multi-line
  string }.squish                   # => "Multi-line string"
" foo   bar    \n   \t   boo".squish # => "foo bar boo"

# * titlecase(keep_id_suffix: false)/ titleize(keep_id_suffix: false)
# Capitalizes all the words and replaces some characters in the string to create a nicer looking title.
'man from the boondocks'.titleize                       # => "Man From The Boondocks"
'x-men: the last stand'.titleize                        # => "X Men: The Last Stand"
'string_ending_with_id'.titleize(keep_id_suffix: true)  # => "String Ending With Id"

# * date / time
"13-12-2012".to_time               # => 2012-12-13 00:00:00 +0100
"06:12".to_time                    # => 2012-12-13 06:12:00 +0100
"2012-12-13 06:12".to_time         # => 2012-12-13 06:12:00 +0100
"2012-12-13T06:12".to_time         # => 2012-12-13 06:12:00 +0100
"2012-12-13T06:12".to_time(:utc)   # => 2012-12-13 06:12:00 UTC
"1-1-2012".to_datetime            # => Sun, 01 Jan 2012 00:00:00 +0000
"01/01/2012 23:59:59".to_datetime # => Sun, 01 Jan 2012 23:59:59 +0000
"2012-12-13 12:50".to_datetime    # => Thu, 13 Dec 2012 12:50:00 +0000
"1-1-2012".to_date   # => Sun, 01 Jan 2012
"01/01/2012".to_date # => Sun, 01 Jan 2012
"2012-12-13".to_date # => Thu, 13 Dec 2012

# * truncate/ truncate_words
'And they found that many people were sleeping better.'.truncate_words(5, omission: '... (continued)')
# => "And they found that many... (continued)"
'Once upon a time in a world far far away'.truncate_words(4)
# => "Once upon a time..."
'And they found that many people were sleeping better.'.truncate(25, omission: '... (continued)')
# => "And they f... (continued)"
'Once upon a time in a world far far away'.truncate(27, separator: ' ')
# => "Once upon a time in a..."
'Once upon a time in a world far far away'.truncate(27)
# => "Once upon a time in a wo..."

# * underscore()
# The reverse of camelize
'ActiveModel'.underscore         # => "active_model"
'ActiveModel::Errors'.underscore # => "active_model/errors"
