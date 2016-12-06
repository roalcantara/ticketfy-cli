require 'yaml'
require 'singleton'

module Ticketfy
  module Cli
    module Util
      class Credentials
        include Singleton

        attr_reader :credentials

        FILE_NAME = '.ticketfy.yml'.freeze

        def initialize
          @credentials = read_credentials
        end

        def access_token
          @credentials[:credentials][:access_token] if @credentials.key?(:credentials)
        end

        def client
          @credentials[:credentials][:client] if @credentials.key?(:credentials)
        end

        def uid
          @credentials[:credentials][:uid] if @credentials.key?(:credentials)
        end

        def read_credentials
          File.new(FILE_NAME, 'w+') unless File.exist?(FILE_NAME)

          YAML.load_file(FILE_NAME) || { credentials: {} }
        end

        def set(access_token:, client:, uid:)
          @credentials[:credentials] = {
            access_token: access_token,
            client: client,
            uid: uid
          }

          File.open(FILE_NAME, 'r+') do |f|
            f.write(@credentials.to_yaml)
          end
        end
      end
    end
  end
end
