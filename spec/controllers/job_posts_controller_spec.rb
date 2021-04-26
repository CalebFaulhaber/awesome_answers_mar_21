require 'rails_helper'
# rails generate rspec:controller job_posts --controller-specs --no-request-specs
# Use this command with above given flags to get rspec file for controller else you will get rspect file for the 'request'
RSpec.describe JobPostsController, type: :controller do
    # Testing CRUD actions for controller
    # new
    # create
    # edit
    # update
    # destroy
    # index
    # show 

    describe "#new" do
        it "renders the new template " do
            #Given
            # User requesting to show the form / There is nothing in given
            # When
            get(:new) # 👈🏻 we have this get method from rails-controller-testing gem, which made magically by this get mthod else we have to create manually
            # https://rspec.info/documentation/4.0/rspec-rails/RSpec/Rails/Matchers/RoutingMatchers/RouteHelpers.html#get-instance_method
            # Then
            expect(response).to(render_template(:new))# 👈🏻 We verify that the seponse will render out the template called "new" using the matcher 'render_template'
            # response is an object that represents the HTTP-Response
            # Rspec makes this available within the specs
        end
        it "sets an instance variable with a new job post" do
            #given
            # when
            get(:new)
            # then
            # assigns(:job_post) : we have this 'assign' method available form the 'rails-controller-testing' gen that allows you to grab an instance varaible, it takes symbol(:job_posts)
            expect(assigns(:job_post)).to(be_a_new(JobPost))
            # we check that the instance variable @job_post is a new instance of the class JobPost(Model) - the madel that we created in the last class 
        end
    end
    describe '#create' do
        def valid_request
            post(:create, params:{job_post: FactoryBot.attributes_for(:job_post)})  
        end
        it "creates a job post in the database" do
            #Given
            count_before=JobPost.count
            valid_request
            # 👆🏻 in this we are mocking the post request to the create method. the params of the request will look simillar to:{
            # job_post:{
            #     title: 'Senior dev',
            #     description: 'lots of pay',
            #     location: 'remote',
            #     min_salary: 500_000,
            #     max_salary: 1_000_000
            # }
            # }
            # then
            count_after=JobPost.count
            expect(count_after).to(eq(count_before+1))
            # eq is an assertion provided by Rspec that checks the value to the right of the .to is equal to the parameter passed in the method
        end
        it " redirects us to the show page for the post" do
            # given
            # when
            valid_request
            # then
            job_post= JobPost.last
            expect(response).to(redirect_to(job_post_url(job_post.id)))
            #  we are using job_post_url that need an id to direct to particular show page

        end

    end
    

end