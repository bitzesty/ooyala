require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "ooyala"
    gem.summary = %Q{Ruby gem to access the Ooyala API}
    gem.description = %Q{Ruby gem to access the Ooyala API}
    gem.email = "matthew.c.ford@gmail.com"
    gem.homepage = "http://github.com/bitzesty/ooyala"
    gem.authors = ["Matthew Ford"]
    gem.add_dependency("httparty", ">=0.0.4")
    # gem.add_development_dependency("fakeweb", ">=1.2.5")
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "--format pretty"
    t.rcov = true
    t.rcov_opts = %w{--exclude features\/}
  end
rescue LoadError
  task :features do
    abort "Cucumber or rcov is not available. In order to run features, you must: sudo gem install cucumber relevance-rcov"
  end
end
task :default => :features

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ooyala #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
