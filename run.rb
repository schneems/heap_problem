puts "== Calling `puts` and `10.times { GC.start } "
out = `ruby pass.rb`
out.each_line do |l|
  puts "  #{l}"
end

puts
puts "== Calling only `GC.start`"
out = `ruby fail.rb`
out.each_line do |l|
  puts "  #{l}"
end
