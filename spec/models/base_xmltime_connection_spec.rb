require 'rails_helper'

RSpec.describe BaseXmltimeConnection, type: :model do

  let(:base_xmltime_connection) { BaseXmltimeConnection.new }

  describe 'request_api' do
    let(:args) { {first_key: "first test value", second_key: "second test value"} }

    it { expect { base_xmltime_connection.send(:request_api, args) }.to raise_error(NotImplementedError) }
  end

  describe 'query' do
    let(:args) { {first_key: "first test value", second_key: "second test value"} }

    it { expect(base_xmltime_connection.send(:query, args)).to eq "first_key=first+test+value;second_key=second+test+value" }
  end

  describe 'setup_connection_args' do
    it { expect { base_xmltime_connection.send(:setup_connection_args) }.to raise_error(NotImplementedError) }
  end

  describe 'url' do
    it { expect { base_xmltime_connection.send(:url) }.to raise_error(NotImplementedError) }
  end

  describe 'service_name' do
    it { expect { base_xmltime_connection.send(:service_name) }.to raise_error(NotImplementedError) }
  end
end