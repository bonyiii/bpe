# frozen_string_literal: true
require 'factory_girl_rails' if Rails.env.test?

# rubocop:disable Metrics/BlockLength
namespace :ci do
  desc 'Run CI Tasks'
  task build: :environment do
    build_frontend
    Rake::Task['ci:factory_lint'].invoke
    sh 'rubocop app lib spec config'
    sh 'rubycritic app lib --no-browser -f json'
    sh 'rspec'
  end

  desc 'Verify that all FactoryGirl factories are valid'
  task factory_lint: :environment do
    if Rails.env.test?
      begin
        DatabaseCleaner.start
        factories_to_lint = FactoryGirl.factories.reject do |factory|
          factory.name =~ /^user/
        end
        FactoryGirl.lint factories_to_lint
      ensure
        DatabaseCleaner.clean
      end
    else
      system("bundle exec rake factory_girl:lint RAILS_ENV='test'")
    end
  end

  def build_frontend
    # sh 'nvm use 6.9.4'
    Rake::Task['project:build_frontend'].invoke
  end
end

task ci: ['ci:build']
