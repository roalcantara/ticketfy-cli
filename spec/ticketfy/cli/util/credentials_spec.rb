require 'spec_helper'
require 'yaml'

describe Ticketfy::Cli::Util::Credentials do
  let(:access_token) { 'E4CQnv94qEYw_mTOCGGydg' }
  let(:client) { '2VEJFG6M9h9v2qchyAvKBw' }
  let(:uid) { 'admin@ticketfy.io' }

  it 'is a Singleton' do
    expect(Ticketfy::Cli::Util::Credentials.ancestors).to include Singleton
  end

  describe '#read_credentials' do
    context "when `#{Ticketfy::Cli::Util::Credentials::FILE_NAME}` does not exist" do
      it do
        allow(File).to receive(:exist?).with(Ticketfy::Cli::Util::Credentials::FILE_NAME).and_return false
        allow(File).to receive(:new).with(Ticketfy::Cli::Util::Credentials::FILE_NAME, 'w+')
        allow(YAML).to receive(:load_file).with(Ticketfy::Cli::Util::Credentials::FILE_NAME).and_return credentials: {}
        Ticketfy::Cli::Util::Credentials.instance
      end
    end

    context "when `#{Ticketfy::Cli::Util::Credentials::FILE_NAME}` exists" do
      it do
        allow(File).to receive(:exist?).with(Ticketfy::Cli::Util::Credentials::FILE_NAME).and_return true
        expect(File).to_not receive(:new).with(Ticketfy::Cli::Util::Credentials::FILE_NAME, 'w+')
        allow(YAML).to receive(:load_file).with(Ticketfy::Cli::Util::Credentials::FILE_NAME).and_return credentials: {}

        Ticketfy::Cli::Util::Credentials.instance
      end
    end
  end

  describe '#set' do
    let(:file) { double('file like object') }

    before do
      allow_any_instance_of(Ticketfy::Cli::Util::Credentials)
        .to receive(:read_credentials).and_return credentials: {}
    end

    it 'stores `access_token`, `client` and `uid`' do
      @buffer = StringIO.new
      allow(File).to receive(:open).with(Ticketfy::Cli::Util::Credentials::FILE_NAME, 'r+').and_yield(@buffer)

      Ticketfy::Cli::Util::Credentials.instance.set(access_token: access_token, client: client, uid: uid)
    end
  end

  describe '#access_token' do
    it 'returns the stored `access_token`' do
      expect(Ticketfy::Cli::Util::Credentials.instance.access_token).to eq access_token
    end
  end

  describe '#client' do
    it 'returns the stored `client`' do
      expect(Ticketfy::Cli::Util::Credentials.instance.client).to eq client
    end
  end

  describe '#uid' do
    it 'returns the stored `uid`' do
      expect(Ticketfy::Cli::Util::Credentials.instance.uid).to eq uid
    end
  end
end
