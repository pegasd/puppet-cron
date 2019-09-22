# frozen_string_literal: true

require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'
require 'metadata-json-lint/rake_task'
require 'puppet-strings/tasks'
require 'rubocop/rake_task'
require 'yamllint/rake_task'
require 'puppet_litmus/rake_tasks' if Bundler.rubygems.find_name('puppet_litmus').any?

PuppetLint.configuration.relative     = true
PuppetLint.configuration.ignore_paths = ['spec/fixtures/**/*.pp', 'spec/_fixtures/**/*.pp']

desc 'Validate and lint manifests, templates, ruby, and yaml files'
task :validate_all do
  [:validate, :metadata_lint, :lint, :rubocop, :yamllint].each do |test|
    Rake::Task[test].invoke
  end
end

YamlLint::RakeTask.new do |t|
  t.paths = ['spec/**/*.yaml', 'data/**/*.yaml', 'data/*.yaml', '*.yaml']
end
