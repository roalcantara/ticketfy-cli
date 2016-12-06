require 'spec_helper'

describe Ticketfy::Cli::Auth do
  it { expect(Ticketfy::Cli::Auth.ancestors).to include Ticketfy::Cli::Util::Logging }
  it { expect(Ticketfy::Cli::Auth.ancestors).to include Ticketfy::Cli::Util::Configurable }
  subject { Ticketfy::Cli::Auth.new }

  describe '#admin' do
    let(:email) { 'admin@ticketfy.io' }
    let(:password) { 'qazwsx' }
    let(:response) do
      %{
        {
          "data":{"id":2,"email":"admin@ticketfy.io","provider":"email","name":"Admin",
            "uid":"admin@ticketfy.io","nickname":null,"image":null,"type":"admin"}
        }
      }
    end
    let(:headers) do
      {
        'Server': 'Cowboy', 'Date': 'Sat, 03 Dec 2016 23:46:45 GMT', 'Connection': 'keep-alive',
        'X-Frame-Options': 'SAMEORIGIN', 'X-Xss-Protection': '1; mode=block',
        'X-Content-Type-Options': 'nosniff', 'Content-Type': 'application/json; charset=utf-8',
        'Access-Token': 'abQs97uxjYVYuezjMWl7Cg', 'Token-Type': 'Bearer',
        'Client': 'OZaevvo8Wx6hbAXXSe1M4w', 'Expiry': '1482018406', 'Uid': 'admin@ticketfy.io',
        'Etag': 'W/\'bf0890d4d391d005ef230e5b13c96e46\'', 'X-Runtime': '0.222963',
        'Cache-Control': 'max-age=0, private, must-revalidate', 'Transfer-Encoding': 'chunked',
        'X-Request-Id': '05ad600f-34a7-4f3e-872c-22e5c57a5584', 'Via': '1.1 vegur'
      }
    end

    it do
      stub_request(:post, 'http://ticketfy-api.herokuapp.com/admin_auth/sign_in')
        .with(body: {email: email, password: password})
        .to_return(status: 200, body: response, headers: headers)

      subject.admin email: email, password: password
    end
  end

  describe '#agent' do
  end

  describe '#customer' do
  end  
end
