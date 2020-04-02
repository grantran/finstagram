configure do
  # Log queries to STDOUT in development
 if Sinatra::Application.development?
  set :database, {
  adapter: "sqlite3",
  database: "db/db.sqlite3"
  }
else
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://jzjgqylnfrbucf:462906c98d90831508b096fb36adc99915a7c90d2616290df9b8af23b84fe4cf@ec2-18-235-97-230.compute-1.amazonaws.com:5432/ddu6r2l22ikt6h')
  set :database, {
  adapter: "postgresql",
  host: db.host,
  username: db.user,
  password: db.password,
  database: db.path[1..-1],
  encoding: "utf8"
  }
​
end
​
  # Load all models from app/models, using autoload instead of require
  # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end
​
end