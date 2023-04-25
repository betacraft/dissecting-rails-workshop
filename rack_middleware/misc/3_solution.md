# Solution Walkthrough

## 0. Getting Started

### 0.1. Clone the dissecting-rails-workshop repo

    ```bash
    git clone git@github.com:betacraft/dissecting-rails-workshop.git
    ```

### 0.2. Switch to the `rack_middleware` branch 
Note: underscore not hyphen

        ```bash
        git switch rack_middleware
        ```

### 0.3. View the log of commits to get an overview of what we are about to do
        ```bash
        git log --oneline
        ```

### 0.4. Change the working directory to `rack_middleware`
        ```bash
        cd rack_middleware
        ```

### 0.5. Install the dependencies
        ```bash
        bundle install
        ```
### 0.6. In the following steps, we will checkout an existing commit and explore the code. 
Feel free to play around with the code and see how it affects the behaviour of the app.
When switching to the next step, you can either stash your changes or discard them.
```bash
git stash -um 'my changes to step1'
```
or
```bash
git reset --hard
```

## 1. Step 1: Basic functional Rack App
```bash
git switch -c step1 tags/v1
```
We have added the Gems `rack` and `rackup` to our Gemfile.
We have a config.ru that implements a minimal rack app that serves a static response.

Running `rackup` will start the rack server at localhost:9292 by default.
Visit `localhost:9292` in your browser to see the response.

## 2. Step 2: New rack app - SampleApp to mimic an API server
```bash
git switch -c step2 tags/v2
```
We have added a new rack app `SampleApp`.
This app simply returns an approved or declined response if the request params meet a certain condition.

Try the following requests in your browser:
```
localhost:9292?first_name=Ratnadeep&last_name=Deshmane
localhost:9292?first_name=John&last_name=Doe
localhost:9292?firstName=John&lastName=Doe
localhost:9292?firstName=Ratnadeep&lastName=Deshmane
```


## 3. Step 3: Middleware to the rescue
```bash
git switch -c step3 tags/v3
```
We have created a Rack Middleware that will convert the request params to snakecase
and the response to camelcase.
Note the use of ActiveSupport libraries to perform the transformation.

## 4. Using the Middleware with our SampleApp
```bash
git switch -c step4 tags/v4
```
Using a middleware with a rack app is so simple.
```ruby
use MiddlewareClass1
use MiddlewareClass2, '9:00', '17:00'
use MiddlewareClass3, '9:00', '12:00', respond_with: :not_found
use MiddlewareClass4, '9:00', '17:00', respond_with: :forbidden do
    # some code
end
```
Retry the requests from step 2 and see the difference.

Review the logs to see the middleware in action.

## 5. Where Rack stops and Rails starts
```bash
git switch -c step5 tags/v5
```
So far we have issued GET requests from the browser.
Let's see how it works with non GET requests, like POST, PUT etc.

We have a sample request available in `post_with_curl.sh`
Try this example with `curl` now:

```bash
curl -X POST "http://127.0.0.1:9292" \
 -H "content-type: application/json" \
 -d '{"firstName":"Ratnadeep","age":1}'
```

Surprised?

Another surprise awaits us in the logs.

## 6. Rack Middleware to the rescue again
```bash
git switch -c step6 tags/v6
```
Let's use the JSONBodyParser middleware to parse the request body.
Retry the `curl` request from step 5 and see the difference.
As easy as Plug and play. Right?

