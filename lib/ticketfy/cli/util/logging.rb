require 'logger'
require 'colorize'

module Ticketfy
  module Cli
    module Util
      module Logging
        @loggers = {}

        def verbose?
          @verbose = true if @verbose.nil?
          @verbose
        end

        def quiet!
          @verbose = false
        end

        def self.level=(level)
          @level = level
        end

        def logger
          @logger ||= Logging.logger_for(self.class.name)
        end

        def success(message)
          logger.info message.green if verbose?
        end

        def info(message)
          logger.info message.blue if verbose?
        end

        def error(message = nil, e: nil)
          unless e.nil?
            message = "#{message.nil? ? '' : "#{message}: "}#{e.message}"
            message = [message, e.backtrace.join("\n")].join("\n")
          end
          logger.error message.red if verbose?
        end

        def warning(message)
          logger.error message.yellow if verbose?
        end

        def alert(message, type: :info)
          message = ["\n#{'-' * 100}", "   #{message}", '-' * 100].join("\n")
          case type
          when :info
            info message
          when :warning
            warning message
          end
        end

        class << self
          def logger_for(classname)
            @loggers[classname] ||= configure_logger_for(classname)
          end

          def configure_logger_for(classname)
            logger = Logger.new(STDOUT)
            logger.progname = classname
            logger.datetime_format = '%Y-%m-%d %H:%M:%S'
            logger.formatter = proc do |severity, datetime, progname, msg|
              "[#{datetime}] #{severity} #{progname}: #{msg}\n"
            end
            logger.level = @level || Logger::INFO
            logger
          end
        end
      end
    end
  end
end
