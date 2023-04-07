module Puppet
  module Util
    module MongodbOutput
      def self.sanitize(data)
        Puppet.debug("Sanitize, starting with #{data}")
        # Remove a line starting with {"t and a "msg" key. This happens when there is a warning or an information message
        data.gsub!(%r[^{"t"\:.+"msg"\:.+\n], '')
        # Dirty hack to remove JavaScript objects
        data.gsub!(%r{\w+\((\d+).+?\)}, '\1') # Remove extra parameters from 'Timestamp(1462971623, 1)' Objects
        data.gsub!(%r{\w+\((.+?)\)}, '\1')

        data.gsub!(%r{^Error\:.+}, '')
        data.gsub!(%r{^.*warning\:.+}, '') # remove warnings if sslAllowInvalidHostnames is true
        data.gsub!(%r{^.*The server certificate does not match the host name.+}, '') # remove warnings if sslAllowInvalidHostnames is true mongo 3.x
        Puppet.debug("Sanitize, ending with #{data}")
        data
      end
    end
  end
end
