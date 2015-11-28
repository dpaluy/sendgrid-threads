require 'spec_helper'

describe SendgridThreads::ApiConnection do

  let(:connection_mock) { instance_double("ApiConnection") }
  let(:connection_params) do
    {key: 'foobar', secret: 'abc123'}
  end

  before(:all) do
    Timecop.freeze(Time.utc(2015, 11, 01, 12))
  end

  after(:all) do
    Timecop.return
  end

  it "initializes a valid connection" do
    expect(SendgridThreads::Client).to receive(:new).with(connection_params).and_return(connection_mock)
    SendgridThreads::ApiConnection.new(connection_params)
  end

  describe "v1" do
    let(:user_id) { "12345678" }
    let(:traits) do
      {email: "test@example.com", name: "Sendgrid Tester"}
    end
    let(:properties) do
      {plan: 1, subscription: 2}
    end

    before do
      allow(SendgridThreads::Client).to receive(:new).with(connection_params).and_return(connection_mock)
    end

    subject { SendgridThreads::ApiConnection.new(connection_params) }

    it "#identify" do
      expect(connection_mock).to receive(:post).with(
        "identify", {userId: user_id, traits: traits, timestamp: "2015-11-01T12:00:00Z"}
      )
      subject.identify(user_id, traits)
    end

    it "#track" do
      expect(connection_mock).to receive(:post).with(
        "track", {userId: user_id, event: "event", timestamp: "2015-11-01T12:00:00Z", properties: properties }
      )
      subject.track(user_id, "event", properties)
    end

    it "#page_view" do
      expect(connection_mock).to receive(:post).with(
        "page", {userId: user_id, name: "Page Name", timestamp: "2015-11-01T12:00:00Z", properties: properties }
      )
      subject.page_view(user_id, "Page Name", properties)
    end

    it "#remove" do
      expect(connection_mock).to receive(:post).with(
        "remove", {userId: user_id, timestamp: "2015-11-01T12:00:00Z" }
      )
      subject.remove(user_id)
    end
  end
end
