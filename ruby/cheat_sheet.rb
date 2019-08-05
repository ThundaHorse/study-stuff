# Manipulation 

# add element(s) to the end using push
people = ["Tommy", "Bex"]
p people.push("Maurice", "Abby")      # prints ["Tommy", "Bex", "Maurice", "Abby"]
p people                              # prints ["Tommy", "Bex", "Maurice", "Abby"]

# remove the last element using pop
people = ["Tommy", "Bex"]
p people.pop()                        # prints "Bex"
p people                              # prints ["Tommy"]

# add elements(s) to the front using unshift
people = ["Tommy", "Bex"]
p people.unshift("Oscar", "Matthias") # prints ["Oscar", "Matthias", "Tommy", "Bex"]
p people                              # prints ["Oscar", "Matthias", "Tommy", "Bex"]  

# remove the first element using shift
people = ["Tommy", "Bex"]
p people.shift()                      # prints "Tommy"
p people                              # prints ["Bex"]

#---------------------------------------------------------------------------------------------------#
  
# Checking Existence 
# check if an element exists in an array using include?
people = ["Tommy", "Bex", "Abby", "Maurice"]
p people.include?("Abby")   # prints true
p people.include?("Mashu")  # prints false

# find the index of an element in an array using index
people = ["Tommy", "Bex", "Abby", "Maurice"]
p people.index("Abby")      # prints 2
p people.index("Maurice")   # prints 3
p people.index("Oscar")     # prints nil
p people.index("Danny")     # prints nil

#---------------------------------------------------------------------------------------------------#

#string <> array
# convert a string into an array using split
sentence = "Hey Programmers! What's up."
p sentence.split(" ")      # prints ["Hey", "Programmers!", "What's", "up."]
p sentence.split("a")      # prints ["Hey Progr", "mmers! Wh", "t's up."]
p sentence.split("gram")   # prints ["Hey Pro", "mers! What's up."]
p sentence                 # prints "Hey Programmers! What's up."

# convert an array into a string using join
words = ["Rubies", "are", "red"]
p words.join(" ")          # prints "Rubies are red"
p words.join("-")          # prints "Rubies-are-red"
p words.join("HI")         # prints "RubiesHIareHIred"
p words                    # prints ["Rubies", "are", "red"]

#---------------------------------------------------------------------------------------------------#

#Array Enumerables 

people = ["Candace", "Jon", "Jose"]

# iterate over elements of an array using each
people.each { |person| puts person } # prints
# Candace
# Jon
# Jose

# iterate over elements of an array with index using each_with_index
people.each_with_index do |person, i|
  puts person
  puts i
  puts "-----"
end # prints
# Candace
# 0
# -----
# Jon
# 1
# -----
# Jose
# 2
# -----

#---------------------------------------------------------------------------------------------------#

#string enumerable methods 

greeting = "hello"

# iterate over characters of a string using each_char
greeting.each_char { |char| puts char } # prints
# h
# e
# l
# l
# o

# iterate over characters of a string with index using each_char.with_index
greeting.each_char.with_index do |char, i|
  puts char
  puts i
  puts "---"
end # prints
# h
# 0
# ---
# e
# 1
# ---
# l
# 2
# ---
# l
# 3
# ---
# o
# 4
# ---

#---------------------------------------------------------------------------------------------------#

# Misc

# repeat a block using times
3.times do
  puts "hi"
end # prints
# hi
# hi
# hi

# specify a range of numbers using (start..end) or (start...end)

# including end
(2..6).each {|n| puts n} # prints
# 2
# 3
# 4
# 5
# 6

# excluding end
(2...6).each {|n| puts n} # prints
# 2
# 3
# 4
# 5


#########################################################################################################
string.chomp(seperator = $/) 
# Returns a new string with the given seperator removed (if present). if $/ hasn't been changed from default Ruby seperator, chomp removes \n, \r, and \r\n 

string.strip 
# Returns a new string with leading and trailing spaces(whitespaces) removed 

string.chop 
# Returns a new string with the last character removed. 
# Note that carriage returns (\n, \r\n) are treated as single character and, in the case they are not present, a character from the string will be removed.

########################################################################################
Hash 

def group_by_marks(marks, pass_marks)
    marks.group_by {|key, value| value<pass_marks ? "Failed" : "Passed"}
end


marks = {"Ramesh":23, "Vivek":40, "Harsh":88, "Mohammad":60}
group_by_marks(marks, 30)
# {"Failed"=>[["Ramesh", 23]], "Passed"=>[["Vivek", 40], ["Harsh", 88], ["Mohammad", 60]]}


#######################################################################################

Array Procs 

def square_of_sum (my_array, proc_square, proc_sum)
    sum = proc_sum.call(my_array)
    proc_square.call(sum)
end

proc_square_number = proc { |n| n**2 }
proc_sum_array     = proc { |n| n.reduce(:+) }
my_array = gets.split().map(&:to_i)

puts square_of_sum([1,2,3], proc_square_number, proc_sum_array)
# 36 
# sum = 1+2+3 = 6 
# square = 6*6 = 36

########################################################################################
Lambdas 

# Write a lambda which takes an integer and square it
square      = -> (a) {a**2} 

# Write a lambda which takes an integer and increment it by 1
plus_one    = -> (b) {b + 1}

# Write a lambda which takes an integer and multiply it by 2
into_2      = -> (c) {c * 2}

# Write a lambda which takes two integers and adds them
adder       = -> (d,e) {d+e}

# Write a lambda which takes a hash and returns an array of hash values
values_only = -> (f) {f.values}


input_number_1 = gets.to_i
input_number_2 = gets.to_i
input_hash = eval(gets)

a = square.(input_number_1); b = plus_one.(input_number_2);c = into_2.(input_number_1); 
d = adder.(input_number_1, input_number_2);e = values_only.(input_hash)

p a; p b; p c; p d; p e



########################################################################################
Closures 
# It can be treated like a variable, which can be assigned to another variable, passed as an argument to a method. 

#  Remembers the value of variables no longer in scope.

## It remembers the values of all the variables that were in scope when the function ## ## was defined. It is then able to access those variables when it is called even if  
## they are in a different scope.

def block_message_printer
    message = "Welcome to Block Message Printer"
    if block_given?
        yield
    end
  puts "But in this function/method message is :: #{message}"
end

message = gets
block_message_printer { puts "This message remembers message :: #{message}" }

#####################################################################################

# Random Problem 
Primes 

def is_prime(n) 
  (2..(n - 1)).each do |i| 
    if (n % i == 0)
      return false  
    end
  end 
  true
end 

# Is a number a palindrome? i.e. 55, 5 -> 5 == 5 <- 5 
def palindromic(num) 
  if num.to_s.split("") == num.to_s.split("").reverse
    true 
  else 
    false 
  end 
end 
