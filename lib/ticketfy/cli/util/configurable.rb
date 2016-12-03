module Ticketfy
  module Cli
    module Util
      module Configurable
        CONFIG_PATH = 'config/'.freeze

        def initialize_configurable(environment:)
          Config.load_and_set_settings(Config.setting_files(CONFIG_PATH, environment))
        end
      end
    end
  end
end
