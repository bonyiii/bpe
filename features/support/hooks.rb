# frozen_string_literal: true
Before do |scenario|
  Rails.logger.info { "\n" }
  Rails.logger.info "STARTING SCENARIO: #{scenario.name} ".ljust(100, '=')
end

After do |scenario|
  if ENV['INTERACTIVE_MODE'] == 'true' && ENV['LIVE_MODE'] == 'true'
    wait_text = "All steps finished, hit \u23CE  to close browser"
    print "    \033[33m#{wait_text}\033[0m"
    pressed_key = STDIN.getch

    binding.pry if pressed_key == 'p' # rubocop:disable Lint/Debugger
  end

  Rails.logger.info "ENDING SCENARIO: #{scenario.name} ".ljust(100, '=')
end
