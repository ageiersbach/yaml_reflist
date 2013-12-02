require 'trollop'
require_relative 'reference'

opts = Trollop::options do
  opt :path, "file path", :type => String
  opt :new, "create new ref", :type => String
  opt :find, "find ref", :type=> String
  opt :delete, "delete ref", :type => String
end
if opts[:path]
  ref = Reference.new(opts[:path])
else
  ref = Reference.new('reference.yaml')
end
if opts[:new]
  ref.new(opts[:new])
elsif opts[:find]
  ref.find(opts[:find])
elsif opts[:delete]
  ref.delete(opts[:delete])
else
  puts "not an acceptable entry. please try again"
end


