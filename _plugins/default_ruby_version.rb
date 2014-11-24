require_relative './ruby_versions_helper'

module Jekyll
  class DefaultRubyVersion < Liquid::Tag
    include ::RubyVersionsHelper

    def render(context)
      get_default_ruby_version
    end
  end
end

Liquid::Template.register_tag('default_ruby_version', Jekyll::DefaultRubyVersion)
