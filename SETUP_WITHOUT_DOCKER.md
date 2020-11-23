### How To Run Development mode without docker
1. Download source
    1. ```git clone https://github.com/x1wins/CW-OVP.git```
    2. ```cd ./CW-OVP```
    3. ```bundle install```
2. Database
    1. postgresql with docker
        ```bash
            mkdir $HOME/docker/volumes/cw_ovp_development
            docker run --rm --name cw_ovp_development \
                  --env-file .env.dev.procfile \
                  -v $HOME/docker/volumes/cw_ovp_development:/var/lib/postgresql/data \
                  -p 5432:5432 -d postgres            
            rake db:migrate
        ```
    2. redis with docker
        ```bash
            docker run --rm --name my-redis-container -p 6379:6379 -d redis
        ```
3. App server
    1. bundle & webpacker install
        ```bash
            bundle exec rails webpacker:install 
        ```
    2. rails server & sidekiq
        > http://railscasts.com/episodes/281-foreman
        ```bash
            yarn install --check-files
            bundle exec foreman start --env .env.dev.procfile,.env.dev.s3
        ```
4. open your web browser and connect ```http://localhost:3000```       
5. Testing
    ```bash
        bundle exec rspec --format documentation
    ```
    * result
        ```bash
            EncodesController
              GET #index
                returns a success response
              GET #show
                returns a success response
              GET #new
                returns a success response
              POST #create
                with valid params
                  creates a new Encode
                  redirects to the created encode
                with invalid params
                  returns a success response (i.e. to display the 'new' template)
              DELETE #destroy
                destroys the requested encode
                redirects to the encodes list
            
            EncodesController
              routing
                routes to #index
                routes to #new
                routes to #show
                routes to #create
                routes to #destroy
            
            encodes/index
              renders a list of encodes
            
            encodes/new
              renders new encode form
            
            encodes/show
              renders attributes in <p>
            
            Finished in 2.08 seconds (files took 2.29 seconds to load)
            16 examples, 0 failures
        ```