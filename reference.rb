require 'yaml'
require 'yaml/store'

class Reference
  
  def initialize(file)
    @file = file
    @refs = YAML.load_file(@file)
  end

  def delete(name)
    if @refs.key?(name)
      stor = YAML::Store.new(@file)
      stor.transaction do
        stor.delete(name)
      end
    else
      puts "could not delete #{name} -- does not exist."
    end
  end
  
  def new(name)
    stor = YAML::Store.new(@file)
    stor.transaction do
      if stor[name]
        puts "#{name} already exists." 
        print "edit? (y/n) "
        response = gets.chomp
        if response=='y'
          edit
        end
      else
        options = get_options
        stor[name] = options
        puts "created #{name}"
      end
    end
  end

  def get_options

    options = []
    puts "Enter 'quit' for key to Finish"
    print " > "
    key = gets.chomp
    until key=="quit"
      print " (val) : "
      value = gets.chomp
      puts
      hash = Hash.new
      hash[key] = value.to_s
      options << hash
      print " (key) > "
      key = gets.chomp
    end
    return options
  end

  def edit
    puts "Enter new name or type 'e' to edit existing"
  end

  def find(name)
    if name
      puts "looking for: #{name}"
    else
      puts "If you are looking for a specific entry, please try entering it
      again." 
      list
    end
    
    found_entry = false
    @refs.keys.each do |key|
      if key.downcase.include? name.downcase
        puts
        puts "#{key}"
        puts @refs[key].to_yaml
        found_entry = true;
      end
    end
    if found_entry==false
      puts "No entries found for #{name}"
    end
  end

  def list
    puts "Listing entries for #{@file}"
    list = @refs.keys
    list.sort_by!{|a| a.downcase }
    list.each do |item|
      puts " - #{item}"
    end
  end

end

