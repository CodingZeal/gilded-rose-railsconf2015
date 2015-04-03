begin
  require 'rake/testtask'

  Rake::TestTask.new do |t|
    t.pattern = 'test/**/*_test.rb'
  end
rescue LoadError
end

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end
