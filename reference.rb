require 'yaml'
require 'yaml/store'

class Reference
  
  def initialize
    @refs = YAML.load_file('reference.yaml')
  end
  
  def new(name, options)
    stor = YAML::Store.new('reference.yaml')
    stor.transaction do
      if stor[name]
        #have thor handle this exception?
        #return stor[name]
      else
        stor[name] = options
      end
    end
  end

  # what difs betw. editing & creating refs do i need to think about?
  def edit(name, options)
    @refs.accounts[name] = options
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

