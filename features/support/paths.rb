# frozen_string_literal: true
module NavigationHelpers
  def path_to(page_name, query_arguments = {})
    case page_name
    when /the home\s?page/
      '/'

    else
      defult_regex_match(page_name, query_arguments)
    end
  end

  private

  def defult_regex_match(page_name, query_arguments)
    page_name =~ /the (.*) page/
    path_components = Regexp.last_match(1).split(/\s+/)
    send(path_components.push('path').join('_').to_sym, query_arguments)
  rescue Object => e
    puts e.message
    raise "Can't find mapping from \"#{page_name}\" to a path.\n" \
          "Now, go and add a mapping in #{__FILE__}"
  end
end

World(NavigationHelpers)
