require 'spec_helper'

describe SendgridThreads::Client do

  it 'should accept a key and a secret' do
    expect(SendgridThreads::Client.new(key: 'test', secret: 'test')).to be_an_instance_of(SendgridThreads::Client)
  end

  it 'should build the default url' do
    expect(SendgridThreads::Client.new.url).to eq('https://input.threads.io')
  end

  it 'should build a custom url' do
    expect(SendgridThreads::Client.new(url: 'http://foo.example.com').url).to eq('http://foo.example.com')
  end

  it 'accepts a block' do
    expect { |b| SendgridThreads::Client.new(&b) }.to yield_control
  end

  describe "raise exceptions" do
    before do
      stub_request(:post, "https://foobar:abc123@input.threads.io/v1/mock").
           to_return(body: {message: 'error', errors: ['Bad username / password']}.to_json, status: 400, headers: {'X-TEST' => 'yes'})
    end

    it 'should raise a SendgridThreads::Exception by default' do
      client = SendgridThreads::Client.new(key: 'foobar', secret: 'abc123')
      expect {client.post("mock")}.to raise_error(SendgridThreads::Exception)
    end

    it 'should not raise a SendgridThreads::Exception if raise_exceptions is disabled' do
      client = SendgridThreads::Client.new(key: 'foobar', secret: 'abc123', raise_exceptions: false)
      expect {client.post("mock")}.not_to raise_error
    end
  end

  describe "#post" do
    it 'should make a request to sendgrid' do
      stub_request(:post, "https://foobar:abc123@input.threads.io/v1/mock").
         with(:body => {"attrs"=>2, "params"=>1}).
         to_return(body: {message: 'success'}.to_json, status: 200, headers: {'X-TEST' => 'yes'})

      client = SendgridThreads::Client.new(key: 'foobar', secret: 'abc123')
      res = client.post("mock", {params: 1, attrs: 2})
      expect(res.status).to eq(200)
    end
  end
end
