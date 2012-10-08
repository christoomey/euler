# This is my solution script for Project Euler problem 7. It
# uses the [Sieve of Eratosthenes](http://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)
# to determine the list of primes.

def primes_to_n n
  non_primes = []
  non_primes[1] = 1
  (2..(n/2)).each do |factor|
    ((factor*2)..n).step(factor).each do |multiple_of_factor|
      non_primes[multiple_of_factor] = 1
    end
  end
  (1..n).reject {|i| non_primes[i]}
end

def main
  primes = primes_to_n 1000000
  puts primes[10000]
end

main
