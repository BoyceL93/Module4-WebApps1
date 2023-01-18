1. 

Method: POST
Path: /albums
Body params: 
    title = Voyage
    release_year = 2022
    artist_id = 2

2. 

Expected response: (200 OK)

3. 
#Request
POST /albums

#Expected response
(200 OK)

#Request
POST /album

#Expected response
(404 Not Found)

4. 

context "POST /" do
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
        expect(response.body).to eq("")
    end
end


    
