require 'yaml'

class Reference
  
  def initialize
    @refs = YAML.load_file('reference.yaml')
  end
  
  def new(name, options)
    options.each do |o|
      keys = o.keys
      vals = o.values
      @refs['references']["#{name}"]["#{keys[0]}"] = vals[0]
    end
    #@refs['references']['#{name}'] = opts
    #@refs['references']["#{name}"] = options.to_yaml
  end

  # what difs betw. editing & creating refs do i need to think about?
  def edit(name, options)
    @refs.accounts[name] = options
  end

  def find(name)
    puts "looking for: #{name}"
    @refs['references'].each_with_index do |ref_hash, index|
      if ref_hash.key?(name)
        puts ref_hash[name].to_yaml
        return
      end
    end  
    puts "No results matched #{name}" 
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

