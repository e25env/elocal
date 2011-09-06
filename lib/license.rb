class License
  require 'yaml'
  require 'ftools'
 
  CACHE_LOCATION  = File.join('config')
  CACHE_FILE      = 'license.yml'
  CACHE_PATH      = File.join(File.expand_path(CACHE_LOCATION), CACHE_FILE)
 
  def initialize
    ensure_cache_exists
    load_settings
  end
 
  def run
    # do stuff here
    flush
  end
 
  private
 
  def method_missing(symbol, *args, &block)
    string = symbol.to_s # need for '=' method
 
    if @options.key?(symbol)
      @options[symbol]
    elsif string.index('=') + 1 == string.length && @options.key?(string.gsub('=', '').intern)
      @options[string.gsub('=', '').intern] = *args
    else
      super(symbol, *args, &block)
    end
  end
 
  def load_settings
    @options = {}
    imports = YAML.load_file(CACHE_PATH)
    if imports
      imports.each_pair do |key, value|
        if not key.is_a? Symbol
          imports[key.to_sym] = value
          imports.delete(key)
        end
      end
 
      @options = imports.merge(@options)
      end
    end
 
  def ensure_cache_exists
    File.makedirs(CACHE_LOCATION)
    File.new(CACHE_PATH, 'a+') unless File.exists?(CACHE_PATH) 
  end
 
  def flush
    File.open(CACHE_PATH, 'w') do |f|
      f.puts(YAML::dump(@options))
    end
  end
end