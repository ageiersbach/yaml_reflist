require 'yaml'
require 'yaml/store'

class Reference
  
  def initialize
    @refs = YAML.load_file('reference.yaml')
  end

  def delete(name)
    if @refs.key?(name)
      stor = YAML::Store.new('reference.yaml')
      stor.transaction do
        stor.delete(name)
      end
    else
      puts "could not delete #{name} -- does not exist."
    end
  end
  
  def new(name)
    
    stor = YAML::Store.new('reference.yaml')
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

  # what difs betw. editing & creating refs do i need to think about?
  def edit
    puts "Enter new name or type 'e' to edit existing"

  end

  def find(name)
    puts "looking for: #{name}"
    if @refs.key?(name)
      puts @refs.to_yaml
    else
      puts "No results matched #{name}" 
    end
  end

  def write(ref_file)
    File.open('reference.yml', 'w') { |f| f.write ref_file }
  end


  def test(name)
    opts = Hash.new
    puts "type 'quit' to end dialog"
    print " > "
    key = gets.chomp
    until key=="quit"
      print " : "
      value = gets.chomp
      opts[key] = value
      puts 
      print " > "
      key = gets.chomp
    end
    yaml_stuff = Hash.new(name)
    yaml_stuff[name] = opts
    puts yaml_stuff.to_yaml
  end

end

