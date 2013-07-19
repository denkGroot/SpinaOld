module Spina
  module Admin
    module PagesHelper

      def template_options(template_type, current_page)
        return {} if current_page.send(template_type)

        if current_page.parent_id?
          # Use Parent Template by default.
          { selected: current_page.parent.send(template_type) }
        else
          # Use Default Template (First in whitelist)
          { selected: Engine.send("#{template_type}_whitelist").first }
        end
      end

    end
  end
end
