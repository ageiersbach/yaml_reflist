require 'thor'
require './reference'

class CLI < Thor
  include Thor::Actions

  desc "find", "find a reference"
  def find(ref_name)
    ref = Reference.new
    ref.find(ref_name)
  end

  desc "new", "create a new reference"
  def new(name)
    ref = Reference.new
    opts = []
    
    say("need to call Reference.new with #{name}", :bold)
    
    key = ask(" (key) > ")
    until key=="quit"
      value = ask(" (val) : ")
      hash = Hash.new
      hash[key] = value
      opts << hash
     # puts opts
      key = ask(" (key) > ")
    end
    ref.new(name, opts)
  end

  desc "delete", "delete a reference"
  def delete

  end

  desc "rename", "rename a reference"
  def rename
    #do later
  end

end
