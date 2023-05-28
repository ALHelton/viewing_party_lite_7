require "rails_helper"
RSpec.describe Movie do
  describe "Movie POROs" do
    before :each do
      @godfather = Movie.new({
        original_title: "Godfather",
        vote_average: 3.45,
        id: 849,
        genres: [{id: 18, name: "Drama"}, {id: 80, name: "Crime"}],
        runtime: 181,
        overview: "A movie about love and horror",
        cast: [{adult: false,
                gender: 2,
                id: 3084,
                known_for_department: "Acting",
                name: "Marlon Brando",
                original_name: "Marlon Brando",
                popularity: 14.838,
                profile_path: "/fuTEPMsBtV1zE98ujPONbKiYDc2.jpg",
                cast_id: 5,
                character: "Don Vito Corleone",
                credit_id: "52fe422bc3a36847f8009357",
                order: 0},
          {adult: false,
           gender: 2,
           id: 1158,
           known_for_department: "Acting",
           name: "Al Pacino",
           original_name: "Al Pacino",
           popularity: 37.187,
           profile_path: "/fMDFeVf0pjopTJbyRSLFwNDm8Wr.jpg",
           cast_id: 6,
           character: "Don Michael Corleone",
           credit_id: "52fe422bc3a36847f800935b",
           order: 1}],
        total_results: 2,
        results: [{author: "futuretv",
                   author_details: {name: "", username: "futuretv", avatar_path: "/path", rating: 10.0}},
          {author: "hady",
           author_details: {name: "", username: "hady", avatar_path: "/path", rating: 8.0}}],
        backdrop_path: "/tmU7GeKVybMWFButWEGl2M4GeiP.jpg"
      })
    end

    it "is a Movie Object" do
      expect(@godfather).to be_an_instance_of(Movie)
    end
    it "attributes" do
      expect(@godfather.name).to eq("Godfather")
      expect(@godfather.name).to be_a(String)
      expect(@godfather.vote_average).to eq(3.45)
      expect(@godfather.vote_average).to be_a(Float)
      expect(@godfather.movie_id).to eq(849)
      expect(@godfather.movie_id).to be_a(Integer)
      expect(@godfather.genres).to eq(["Drama", "Crime"])
      expect(@godfather.genres).to be_a(Array)
      expect(@godfather.raw_runtime).to eq(181)
      expect(@godfather.raw_runtime).to be_a(Integer)
      expect(@godfather.runtime).to eq([3, 1])
      expect(@godfather.runtime).to be_a(Array)
      expect(@godfather.description).to eq("A movie about love and horror")
      expect(@godfather.description).to be_a(String)
      expect(@godfather.cast_members).to eq({"Al Pacino" => "Don Michael Corleone", "Marlon Brando" => "Don Vito Corleone"})
      expect(@godfather.cast_members).to be_a(Hash)
      expect(@godfather.count_of_reviews).to eq(2)
      expect(@godfather.count_of_reviews).to be_a(Integer)
      expect(@godfather.author_information).to be_a(Hash)
      expect(@godfather.image).to be_a(String)
      expect(@godfather.image).to include(".jpg")
    end
  end
end
