# Ruby on Rails case: Chat Application
Create a chat app using the latest version of Rails.

### Requirements:

- Users should be able to sign up and be authenticated
- Users should have a display name
- Users should be able to join and leave chat rooms
- Chat rooms can have many users at a time
- Users can send message to chat rooms
- Messages should be real time
- Messages should contain text
- Messages should be persisted in a database

### Technology to focus on:
- ActiveRecord
    - Migrations
    - Queries
- Hotwire
    - Turbo Frames
    - Turbo Streams
    - Stimulus
- Unit and rspec testing

# Solution Approach:

To implement the chat app in Rails, I followed a structured approach that involved leveraging various tools and frameworks to ensure a feature-rich application.

1. Devise Authentication Setup in Rails 7:
I began by setting up authentication using Devise in Rails 7. Devise is a widely-used authentication solution for Rails applications that provides a comprehensive set of features out of the box. By integrating Devise, I was able to implement secure user authentication, registration, and password management functionalities seamlessly within the application.

2. Implementing a Chat Application with Turbo:
Next, I implemented the chat functionality using Turbo, a framework that simplifies building modern web applications with minimal JavaScript. Leveraging Turbo's capabilities, I created a real-time chat experience by utilizing Rails' built-in WebSocket framework. This allowed users to engage in conversations and receive messages instantly, enhancing the overall user experience.

3. Integrating Stimulus for Dynamic Behavior:
To add dynamic behavior to the application's frontend, I integrated Stimulus, a JavaScript framework that enhances HTML with minimal JavaScript code. Stimulus enabled me to create interactive components and enhance user interaction without relying on heavy client-side frameworks. By applying Stimulus controllers and data attributes to HTML elements, I achieved dynamic behavior such as form validation, auto-complete functionality, and interactive UI components.

By following this approach and leveraging the power of Devise, Turbo, and Stimulus, I successfully implemented a chat application in Rails that provides secure authentication, real-time messaging.


## Setup:
1.  Install ruby `3.2.2`
2. `gem install bundler`
3. `bundle install`
4. `rails db:setup`
5. `rails server`

## Tests:
- bundle exec rspec spec
