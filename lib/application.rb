$:.unshift(File.join(File.dirname(__FILE__), "lib"))
require 'sinatra'
require 'haml'
require 'lists_features'
# require 'digest/sha1'



get '/features' do
  @features = ListsFeatures.features
  haml :features
end











# # ---
# require 'gherkin'
# require 'gherkin/formatter/json_formatter'
# require 'gherkin/parser/parser'

# before do
#   @conf = YAML::load(File.open('lib/conf.yml'))
# end

# configure do
#   mime_type :json, 'application/json'
# end

# helpers do
  
#   # fish some gherkinese from a feature file
#   def get_gherkin(feature)
#     io = StringIO.new
#     f = Gherkin::Formatter::JSONFormatter.new(io)
#     p = Gherkin::Parser::Parser.new(f, false, 'root')
#     p.parse(IO.read("../features/#{feature}.feature"), __FILE__, 0)
#     io.string
#   end

# end

# # feature index
# get '/features' do ||
  
#   @wallies = {}
#   Dir.glob('../features/*.feature').each do |feature|
#     feature.sub!('../features/','').sub!('.feature', '') # @fixme tidier file system path from Dir.glob ?
#     wally = JSON.parse(get_gherkin(feature))
#     @wallies[feature] = wally
#   end
  
#   erb :features
# end

# # feature index
# get '/features/:feature' do |feature|
#   @feature = feature
#   @wally = JSON.parse(get_gherkin(feature))
#   erb :feature
# end

# get '/features/:feature/json' do |feature|
#   content_type :json
#   get_gherkin(feature)
# end

# # scenario
# get '/features/:feature/:scenario' do |feature, scenario|
#   @feature = feature
#   @scenario = scenario
#   @wally = JSON.parse(get_gherkin(feature))
#   erb :scenario
# end

# get '/tags/:tag' do |tag|

#   @wallies = {}
#   Dir.glob('../features/*.feature').each do |feature|
#     feature.sub!('../features/','').sub!('.feature', '') # @fixme tidier file system path from Dir.glob ?
#     wally = JSON.parse(get_gherkin(feature))
#     @wallies[feature] = wally
#   end
  
#   @tag = tag
#   erb :tag

# end







