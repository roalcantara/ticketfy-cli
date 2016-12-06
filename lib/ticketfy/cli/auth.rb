module Ticketfy
  module Cli
    class Auth
      include Ticketfy::Cli::Util::Logging
      include Ticketfy::Cli::Util::Configurable

      def initialize(environment: :production, verbose: false)
        initialize_configurable(environment: environment)
        quiet! unless verbose
      end

      def admin(email:, password:)
        sign_in model: :admin, email: email, password: password
      end

      def agent(email:, password:)
        sign_in model: :agent, email: email, password: password
      end

      def customer(email:, password:)
        sign_in model: :customer, email: email, password: password
      end

      private

      def sign_in(model:, email:, password:)
        response = Curl.post(sign_in_path(model: model), email: email, password: password) do |curl|
          curl.verbose = verbose?
        end
        save_credentials(response)
        info response.body_str if verbose?
        JSON.parse(response.body_str)
      end

      def sign_in_path(model:)
        "#{Settings.endpoint}/#{model}_auth/sign_in"
      end

      def save_credentials(response)
        http_headers = response.header_str.split(/[\r\n]+/).map(&:strip)
        headers = Hash[http_headers.flat_map { |s| s.scan(/^(\S+): (.+)/) }]
        Ticketfy::Cli::Util::Credentials
          .instance.set access_token: headers['Access-Token'],
                        client: headers['Client'],
                        uid: headers['Uid']
        info headers.to_s if verbose?
      end
    end
  end
end
