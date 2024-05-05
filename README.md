NAME: Luis Felipe Taveira Barbosa

### Installation

Follow the steps below

```sh
$ cd api_twitter

$ docker-compose build

$ docker-compose run web bundle exec rails db:create

$ docker-compose run web bundle exec rails db:migrate

$ docker-compose run web bundle exec rake db:create_users

$ docker-compose up
```

### Running Tests

Use the following commands to run the automated tests.

```sh
$ docker-compose run web bundle exec rspec
```

### Enpoints

```sh
# POST/ ENDPOINT TO CREATE A POSTS FOR USER_1 ON USER PROFILE PAGE
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "content=my content" http://localhost:3000/api/v1/users/1/create_post

# POST/ ENDPOINT TO CREATE A POSTS FOR USER_2 ON USER PROFILE PAGE
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "content=my content" http://localhost:3000/api/v1/users/2/create_post

# GET/ ENDPOINT TO RETURN THE LAST 5 USER_1 POSTS ON USER PROFILE PAGE
curl -X GET "http://localhost:3000/api/v1/users/1"

# GET/ ENDPOINT TO RETURN ALL POSTS BY USER WITH (SHOW MORE) USING OFFSET
curl -X GET "http://localhost:3000/api/v1/users/1/?offset=5"

# GET/ ENDPOINT TO RETURN ALL POSTS ON HOMEPAGE
curl -X GET "http://localhost:3000/api/v1/posts"

# GET/ ENDPOINT TO RETURN ALL POSTS BY USER ON HOMEPAGE
# (If you want to see other users, change the user_id)

curl -X GET "http://localhost:3000/api/v1/posts?user_id=1"

# GET/ ENDPOINT TO RETURN (ALL) FILTERED POSTS BY START AND END DATE
# Note: Pay attention to the dates on which the records were created in your local machine

curl -X GET "http://localhost:3000/api/v1/posts?start_date=2024-03-01&end_date=2024-08-05"

# GET/ ENDPOINT TO RETURN (ONLY MINE) FILTERED POSTS BY START AND END DATE
curl -X GET "http://localhost:3000/api/v1/posts?user_id=1&start_date=2024-03-01&end_date=2024-08-05"

# GET/ WITH OFFSET TO RETURN MORE POSTS
curl -X GET "http://localhost:3000/api/v1/posts?user_id=1&start_date=2024-03-01&end_date=2024-05-02&offset=10"

# POST/ ENDPOINT TO CREATE A POST FOR USER_1 ON HOMEPAGE
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "content=my content&user_id=1" http://localhost:3000/api/v1/posts

# POST/ ENDPOINT TO CREATE A REPOST WITH COMMENT
curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "user_id=1&quote_content=Its my retweet" http://localhost:3000/api/v1/posts/1/repost

```
### Critique

If I had more time, I would like to improve some parts of this project:

Tests: Although we have some tests implemented, test coverage could be improved. I would add more unit and integration tests to ensure all functionality is working as expected.

Authentication and Authorization: Currently, any user can create posts and reposts for any other user. I would add authentication and authorization to ensure users can only create posts and reposts for themselves.

Scalability
If this project grew and had many users and posts, I believe the first part that would fail would be the database. With many users and posts, database queries may start to slow down, affecting application performance.

To scale this product, I would take the following steps:

Database Query Optimization: I would review all database queries to ensure they are optimized. This may involve adding indexes to the database or modifying queries to reduce the amount of data being fetched.

Caching: I would implement caching to reduce the load on the database. This could involve caching entire pages, page fragments, or database query results.

Horizontal Scaling: If the application is still experiencing performance issues after optimizing queries and implementing caching, I would consider horizontal scaling. This would involve adding more servers to distribute the load.

Microservices: If the application becomes very large and complex, I would consider breaking it down into microservices. This would allow each part of the application to scale independently.

In terms of technology and infrastructure, I would consider using a managed database service to handle the database, a caching service like Redis for caching, and a container orchestration service like Kubernetes to manage horizontal scaling. and the implementation of microservices.
