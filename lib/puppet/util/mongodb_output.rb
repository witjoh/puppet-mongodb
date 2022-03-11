# frozen_string_literal: true

module Puppet
  module Util
    module MongodbOutput
      def self.sanitize(data)
        sanitized = +data
        # Dirty hack to remove JavaScript objects
        sanitized.gsub!(%r{\w+\((\d+).+?\)}, '\1') # Remove extra parameters from 'Timestamp(1462971623, 1)' Objects
        sanitized.gsub!(%r{\w+\((.+?)\)}, '\1')

        sanitized.gsub!(%r{^Error:.+}, '')
        sanitized.gsub!(%r{^.*warning:.+}, '') # remove warnings if sslAllowInvalidHostnames is true
        sanitized.gsub!(%r{^.*The server certificate does not match the host name.+}, '') # remove warnings if sslAllowInvalidHostnames is true mongo 3.x
        sanitized
      end
    end
  end
end
