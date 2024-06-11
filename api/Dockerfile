# Use the official Ruby image from the Docker Hub
FROM ruby:3.3.2

# Set the working directory inside the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install the gem dependencies
RUN bundle install

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 4567

# Set the environment variable for the database URL
ENV DATABASE_URL=postgres://postgres:password@db:5432/ourmaps_development

# Start the Sinatra app
CMD ["ruby", "app.rb"]
