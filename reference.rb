require 'yaml'

class Reference
  
  def initialize
    @refs = YAML.load_file('reference.yaml')
  end
  
  def new(name, options)
    @refs['references'][name] = options unless @refs.accounts[name]
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


  def test
    @refs['references'].each {|k,v| 
      puts "value of #{k} is #{v}"    
    }
  end

end

test = Reference.new
test.find("another_accout_name")
