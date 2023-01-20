require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "album POST /" do
    it 'returns 200 OK' do
      response = post('/albums')

      expect(response.status).to eq(200)
    end

    it "returns 404 not found" do
      response = post('/album')

      expect(response.status).to eq(404)
    end

    it "returns 200 OK with correct content" do
      response = post('/albums', title: "Voyage", release_year: "2022", artist_id: "2")

      expect(response.status).to eq(200)
      
      response = get('/albums')
      expect(response.body).to include('Voyage')
    end
  end

  context "GET /artists" do
    it "returns correct content" do
      response = get('/artists')
      expect(response.body).to include('Mac Miller')
    end
  end

   context 'GET /albums/id' do
    it "returns 200 OK with album 2 details" do
      response = get('/albums/2')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('Pixies')
      expect(response.body).to include('1988')
    end
  end

  context "GET /albums" do
    it "returns 200 OK with all album details" do
      response = get('/albums')
      expect(response.status).to eq(200)
      expect(response.body).to include('Lover')
    end
  end
end
