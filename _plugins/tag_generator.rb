module Jekyll
  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      # Process the name of the file (index.html in this case)
      self.process(@name)

      # Load the layout template for the tag pages
      self.read_yaml(File.join(base, '_layouts'), 'tag.html')

      # Set data for tag page
      self.data['tag'] = tag
      self.data['title'] = "Posts tagged with \"#{tag}\""
      self.data['slug'] = Jekyll::Utils.slugify(tag) # Use Jekyll's slugify method for proper URL handling
    end
  end

  class TagGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'tag'
        dir = 'tag'
        site.tags.each do |tag, posts|
          full_tag = tag # Full tag name
          slugified_tag = Jekyll::Utils.slugify(full_tag) # Slugify the full tag

          # Create a new page for each tag
          site.pages << TagPage.new(site, site.source, File.join(dir, slugified_tag), full_tag)
        end
      end
    end
  end
end
