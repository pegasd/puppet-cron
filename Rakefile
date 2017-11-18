require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'metadata-json-lint/rake_task'
require 'puppet-strings/tasks'
require 'rubocop/rake_task'
require 'yamllint/rake_task'

PuppetLint.configuration.relative     = true
PuppetLint.configuration.ignore_paths = %w[spec/fixtures/**/*.pp spec/_fixtures/**/*.pp]

desc 'Validate manifests, templates, ruby, and yaml files'
task :validate do
  Dir['manifests/**/*.pp', 'types/**/*.pp'].each do |manifest|
    sh "bundle exec puppet parser validate --noop #{manifest}"
  end
  Dir['templates/**/*.epp'].each do |epp_template|
    sh "bundle exec puppet epp validate --noop #{epp_template}"
  end

  Dir['spec/**/*.rb', 'lib/**/*.rb'].each do |ruby_file|
    sh "ruby -c #{ruby_file}" unless ruby_file.match?(%r{spec/fixtures})
  end
  Dir['templates/**/*.erb'].each do |template|
    sh "erb -P -x -T '-' #{template} | ruby -c"
  end

  [:metadata_lint, :lint, :rubocop, :yamllint].each do |test|
    Rake::Task[test].invoke
  end
end

YamlLint::RakeTask.new do |t|
  t.paths = %w[
    spec/**/*.yaml
    data/**/*.yaml
    data/*.yaml
    *.yaml
  ]
end
