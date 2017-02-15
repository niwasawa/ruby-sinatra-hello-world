require 'sinatra'
require 'erb'

set :environment, :production
set :port, 8888

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

not_found do
  erb :not_found
end

error 400..510 do
  @message = h env['sinatra.error'].message
  erb :error
end

# static files
get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

# matches "GET /hello/foo" and "GET /hello/bar"
get '/hello/:name' do

  # params['name'] is 'foo' or 'bar'
  # Instance variables set in route handlers are directly accessible by templates.
  @name = h params['name']

  # This renders views/hello.erb
  erb :hello
end

# params
get '/params/' do

  @list = []
  params.each do |k, v|
    @list << "#{h k} = #{h v}"
  end

  # This renders views/params.erb
  erb :params
end

# error
get '/error/' do
  raise 'Oh, this is a error sample.'
end

# ref.
# Sinatra: README
# http://www.sinatrarb.com/intro.html

