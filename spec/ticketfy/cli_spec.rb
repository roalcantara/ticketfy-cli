require 'spec_helper'

describe Ticketfy::Cli do
  it 'has a version number' do
    expect(Ticketfy::Cli::VERSION).not_to be nil
  end
end
