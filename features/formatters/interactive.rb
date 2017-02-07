# frozen_string_literal: true
require 'cucumber/formatter/pretty'

module Interactive
  class Formatter < Cucumber::Formatter::Pretty
    def before_test_case(test_case)
      return super if ENV['INTERACTIVE_MODE'] == 'false'
      @first_step_after_background = true
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
    def before_test_step(test_step)
      return if ENV['INTERACTIVE_MODE'] == 'false'
      return if internal_hook?(test_step)
      # If any previous step failed this step satus will be failed too.
      return if [:failed, :skipped].include? @status

      # skip the first step after background execution for better formatting
      if @first_step_after_background
        @first_step_after_background = false
        return
      end

      loop do
        @io.print "\033[s" # Save cursor position
        step_info = test_step.name.to_s
        run_text_pre = 'run ['
        run_text_post = ']'
        msg = "\033[33m#{run_text_pre}\033[0m\033[34m#{step_info}"
        msg << "\033[0m\033[33m#{run_text_post}\033[0m"
        @io.print msg
        pressed_key = STDIN.respond_to?(:getch) ? STDIN.getch : STDION.gets.chomp
        @io.flush

        @io.print "\033[u" # Restore cursor position
        @io.print "\033[K" # Erase to end of line
        @io.flush

        commander_status = interactive_commander(pressed_key)
        break if commander_status == :execute_step
      end
    end

    private

    def internal_hook?(test_step)
      ['lib/cucumber/',
       'lib/capybara/',
       'paper_trail/frameworks',
       'features/support'].any? do |internal_lib_location|
        test_step.source.last.location.file.include? internal_lib_location
      end
    end

    def interactive_commander(user_input)
      case user_input
      when 'p' then binding.pry # rubocop:disable Lint/Debugger
      when 'l' then start_crowdin_in_context_mode
      when 'q' then skip_all_remaining_steps_and_quit
      when 'd' then resume_demo_mode
      else :execute_step
      end
    end

    def resume_demo_mode
      ENV['INTERACTIVE_MODE'] = 'false'
    end

    def skip_all_remaining_steps_and_quit
      raise Cucumber::Core::Test::Result::Skipped, 'Skip remaining steps'
    end

    def start_crowdin_in_context_mode
      logged_in_user = User
                       .where('current_sign_in_at IS NOT NULL')
                       .order('current_sign_in_at DESC')
                       .first
      original_locale = logged_in_user.language
      logged_in_user.update_attribute(:language, 'lol')

      page        = Capybara.page
      browser     = page.driver.browser
      main_window = browser.window_handles.first

      browser.navigate.refresh

      # flag the in-context editor iframe so capybara can switch to it
      page.execute_script("$('iframe.crowdin-jipt').attr('name', 'jipt')")
      browser.switch_to.frame 'jipt'

      # page only has this content if there were no previous crowdin login
      if page.has_content?('Sign in with your Crowdin account')
        page.fill_in('crowdin-login-field', with: ENV['CROWDIN_USERNAME'])
        page.fill_in('crowdin-password-field', with: ENV['CROWDIN_PASSWORD'])
        page.find('#crowdin-jipt-login').click
      end

      # switch back capybara context to the original main window
      browser.switch_to.window(main_window)

      @io.print "\033[s" # Save cursor position
      @io.print "    \033[33m{ Press any key to quit interactive in-context crowdin mode }\033[0m"
      @io.respond_to?(:getch) ? @io.getch : @io.gets.chomp
      @io.print "\033[u" # Restore cursor position
      @io.print "\033[K" # Erase to end of line
      @io.flush

      logged_in_user.update_attribute(:language, original_locale)
      browser.navigate.refresh
    end
  end
end
