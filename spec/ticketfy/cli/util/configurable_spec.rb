require 'spec_helper'

describe Ticketfy::Cli::Util::Configurable do
  subject { Object.new.extend(described_class) }

  describe '#initialize_configurable' do
    [:production, :development, :test].each do |environment|
      context "when environment is `#{environment}`" do
        it "loads the `#{environment}` settings" do
          subject.initialize_configurable(environment: environment)
        end
      end
    end
  end
end
