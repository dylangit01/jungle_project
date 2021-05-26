class CategoriesController < ApplicationController

  ### MVC workflow:
  # Whenever the user makes http requests, according to "routes.rb", different endpoints/url has been sent to specific controller accordingly; So the routes.rb defines the routes based on RESTful API.
  
  # When the route comes to the controller, the "Active Record" methods wrote in Controller based on different Class of the database setup(in this case is "Category"), and then assigned query results to instance variable, in this case, is @category; 
  
  # These instance variables can be passed into the view files, and the view file's name metches with the controller method's name, in this case is "show"; so the @category and @products are available into the "show.html.erb" file;

  # In show.html.erb, it renders the partial file: <%= render @products %> with @products available;

  # Eventually all view files will go to the global view file: layouts/application.html.erb, and this layouts/application.html.erb file has rails method: <%= yield %>, which will according to different url to render matched view files; (This application file has <%= render 'layouts/top_nav' %> at top, that's why we always see the "Rendered layouts/_top_nav.html.erb" running for every http request)

  def show
    @category = Category.find(params[:id])
    @products = @category.products.order(created_at: :desc)
  end

end
