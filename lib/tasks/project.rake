# frozen_string_literal: true

namespace :project do
  task :build_frontend do
    system 'npm --no-color install -g yarn'
    system 'yarn install'
    system 'npm --no-color run build'
  end
end

if Rake.application.tasks.map(&:name).include?('assets:precompile')
  Rake::Task['assets:precompile'].enhance ['project:build_frontend']
end
