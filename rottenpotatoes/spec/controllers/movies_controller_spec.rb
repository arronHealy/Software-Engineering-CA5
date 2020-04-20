require 'rails_helper'

describe MoviesController, type: 'controller' do

  describe "#director" do
    context "When specified movie has a director" do
      it "should find movies with the same director" do
        # create fake movie to be assigned in movie controller 
        @fake_movie = double({title: 'thor', director: 'stan lee'})

        # create fake list of movies to be returned as movies with same director
        @fake_movies = [double({title: 'iron man', director: 'stan lee'}), double({title: 'Avengers', director: 'stan lee'})]
        
        # stub Movie.find method in movie controller to return fake movie defined above 
        allow(Movie).to receive(:find).and_return(@fake_movie)

        # stub Movie.where method in movie controller to return fake list of movies with same director
        allow(Movie).to receive(:where).and_return(@fake_movies)
        
        # send post to search_directors method in movie controller with fake id for movie
        post :search_directors, {:id => 6}

        # expect movie controller variables to be populated with fake movies created above and flash notice is not set
        expect(assigns(:movie)).to eq(@fake_movie)
        expect(flash[:notice]).to eq(nil)
        expect(assigns(:movies)).to eq(@fake_movies)
      end
    end

    context "When specified movie has no director" do
      it "should redirect to the movies page" do
        
        # create fake movie to be assigned in movie controller 
        @fake_movie = double({title: 'hulk', director: ''})

        # stub Movie.find method in movie controller to return fake movie defined above 
        allow(Movie).to receive(:find).and_return(@fake_movie)

        # send post to search_directors method in movie controller with fake id for movie
        post :search_directors, {:id => 6}

        # expect the response to redirect you to movies home page and flash notice to be set
        expect(flash[:notice]).to eq("'hulk' has no director info")
        expect(@response).should redirect_to movies_path
      end
    end
  end

  describe "create movie controller method" do
    context "When a new movie is created" do
      it "should redirect to the movies page" do

        # stub Movie.find method in movie controller to return fake movie defined above 
        allow(Movie).to receive(:create)

        # post new movie data to controller
        post :create, :movie => {:title => 'thor', :director => 'stan lee'}
        
        # expect the response to redirect you to movies home page and flash notice to be set
        expect(flash[:notice]).to eq("thor was successfully created.")
        expect(@response).should redirect_to movies_path
      end
    end
  end

  describe "destroy movie controller method" do
    context "When specified movie is deleted" do
      it "should redirect to the movies page" do
        # define fake movie to delete
        @fake_movie = double(Movie, :title => 'hulk', :director => 'stan lee', :id => 3)

        # stub movie find method and return the fake movie
        allow(Movie).to receive(:find).and_return(@fake_movie)

        # stub destroy method on fake movie
        allow(@fake_movie).to receive(:destroy)

        # post to destroy method with matching id
        post :destroy, {:id => 3}

        # expect response to redirect to movies page and flash notice set
        expect(flash[:notice]).to eq("Movie 'hulk' deleted.")
        expect(@response).should redirect_to movies_path
      end
    end
  end

end