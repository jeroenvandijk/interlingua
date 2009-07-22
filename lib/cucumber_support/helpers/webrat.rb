module CucumberSupport
  module Helpers
    module Webrat

      def i_fill_in(value, field_name)
        fill_in(field_name, :with => value)
      end
      
      def i_follow(link)
        click_link(link)
      end

      def i_go_to(page)
        visit guessed_path_to(page)
      end
      alias :i_am_on_page :i_go_to
      
      def i_press(button)
        click_button(button)
      end

      # Assert whether text or a table exist on the current response
      def i_should_see(content)
        if content.respond_to?(:hashes)
          content.raw.each_with_index { |row, i| 
            response.should have_selector("table > tr:nth-child(#{i+1})") {|tr| 
              row.each_with_index { |column, j| tr.should have_selector(":nth-child(#{j+1})") { |td| # td is not explicitly declared because we also have to deal with th's, making the code more complex
                  td.should contain(column)
                }
              }
            }
          }
        else
          response.should contain(content)
        end
      end
      
      # Method to return parts of a page using webrat
      def show_scope(scope)
        within(scope) { |scope| puts scope.send(:scoped_dom).inspect }
      end
      
    end
  end
end