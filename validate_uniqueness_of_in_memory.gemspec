Gem::Specification.new do |gem|
  gem.name    = 'validate_uniqueness_of_in_memory'
  gem.version = '0.0.2'
  gem.date = '2012-11-18'
  gem.summary = 'Use this gem to validate uniqueness in memory'

  gem.author   = ['Akiva Leeder', 'Rex Feng']
  gem.email    = 'akiva.leeder@gmail.com'
  gem.homepage = 'https://github.com/akeyva/validate_uniqueness_of_in_memory'

  # These dependencies are only for people who work on this gem
  #gem.add_development_dependency 'rspec'

  # Include everything in the lib folder
  gem.files = Dir['lib/**/*.rb']

  # Supress the warning about no rubyforge project
  gem.rubyforge_project = 'nowarning'



end