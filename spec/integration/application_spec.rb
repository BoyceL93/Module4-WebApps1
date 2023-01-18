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

  context "artist GET /" do
    it "returns 200 OK" do
      response = get('/artists')
      expect(response.status).to eq(200)
    end

    it "returns 200 OK with correct content" do
      response = get('/artists')
      expect(response.status).to eq(200)
      expect(response.body).to eq("Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos")
    end
  end

  context "artist POST /" do
    it "returns 200 OK with new content" do
      response = post('/artists', name: "Wild nothing", genre: "Indie")
      expect(response.status).to eq(200)

      response = get('/artists')
      expect(response.body).to eq("Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos, Wild nothing")
    end
  end
end
