require 'trollop'
require './reference.rb'

opts = Trollop::options do
  opt :new, "create new ref", :type => String
  opt :find, "find ref", :type=> String
  opt :delete, "delete ref", :type => String
end

ref = Reference.new
if opts[:new]
  ref.new(opts[:new])
elsif opts[:find]
  ref.find(opts[:find])
elsif opts[:delete]
  ref.delete(opts[:delete])
else
  puts "not an acceptable entry. please try again"
end


