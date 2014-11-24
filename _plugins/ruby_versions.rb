require_relative './ruby_versions_helper'

module Jekyll
  class RubyVersions < Liquid::Tag
    include ::RubyVersionsHelper

    def render(context)
      get_all_ruby_versions.map { |version| "* #{version}" }.join("\n")
    end
  end
end

Liquid::Template.register_tag('ruby_versions', Jekyll::RubyVersions)
