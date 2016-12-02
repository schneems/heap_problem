require 'json'
require 'objspace'
require 'fileutils'
require 'stringio'
require 'pp'

FileUtils.mkdir_p("tmp")

ObjectSpace.trace_object_allocations_start

def run
  string = "i am a string #{rand(0..100)}"
  $address = "0x#{ (string.object_id << 1).to_s(16) }"
  puts "Address of string is: #{$address}"

  string.singleton_class.instance_eval do
  end

  string
  return nil
end

run

# ===== CALLING GC HERE =====

GC.start

# ===========================

ObjectSpace.dump_all(output: File.open('tmp/heap.json','w'))

output = `grep #{ $address } tmp/heap.json`
actual = output.each_line.map.select do |line|
  if JSON.parse(line)["address"] == $address
    puts "Found in heap dump:"
    puts "  #{line}"
    true
  end
end.length

expected = 0
result   = expected == actual ? "PASS" : "FAIL"
puts "\n#{result} expected: #{expected} actual: #{actual}"

exit(1) unless expected == actual
