require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'yard'
require 'yard/rake/yardoc_task'

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb']
  # only show the files with failures
  # task.formatters = ['worst']
  # don't abort rake on failure
  task.fail_on_error = false
end

YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/**/*.rb']
  t.stats_options = ['--list-undoc']
end

task deploy: :build do
  require 'curb'
  require 'dotenv'
  Dotenv.load
  pkg_path=File.expand_path('pkg', __dir__)
  artifacts = File.join(Dir.glob(File.join(pkg_path, '*.gem')))
  puts "Deploying artifact: #{artifacts}..."
  auth_string = ENV.fetch 'BB_AUTH_STRING'
  repo_owner = ENV.fetch 'BITBUCKET_REPO_OWNER'
  repo_slug = ENV.fetch 'BITBUCKET_REPO_SLUG'
  resource = "https://#{auth_string}@api.bitbucket.org/2.0/repositories/#{repo_owner}/#{repo_slug}/downloads"
  puts "Posting to #{resource}..."
  c = Curl::Easy.new(resource)
  c.multipart_form_post = true
  c.http_post(Curl::PostField.file('files', artifacts))
end

task default: :spec
