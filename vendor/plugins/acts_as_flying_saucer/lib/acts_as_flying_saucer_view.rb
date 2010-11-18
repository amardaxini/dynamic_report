module ActionView
  
  module Helpers
    module AssetTagHelper
      
      alias_method :old_stylesheet_link_tag, :stylesheet_link_tag

      def stylesheet_link_tag_for_pdf(*sources)
        options = sources.extract_options!.stringify_keys
        options[:media] = 'print' if options["media"].blank?
        old_stylesheet_link_tag(sources, options)
      end
      
    end # AssetTagHelper
  end # Helpers
end # ActionView
