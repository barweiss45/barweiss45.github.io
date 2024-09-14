# Use official Ruby image from Docker Hub
FROM ruby:3.2.2

# Install Node.js and npm (Jekyll uses it for assets and compiling)
RUN apt-get update && apt-get install -y nodejs npm \
    && rm -rf /var/lib/apt/lists/*

# Install Jekyll
RUN gem install bundler jekyll minima \
    && gem clean

## Check version of jekyll
RUN jekyll -v > /tmp/jekyll_version.txt

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy Gemfile and Gemfile.lock first to utilize Docker caching for gems
COPY Gemfile ./

# Install gems specified in Gemfile
RUN bundle install

# Copy the current directory into the container
COPY . .

# Expose the port Jekyll will run on
EXPOSE 4000

# Command to start Jekyll server
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]
