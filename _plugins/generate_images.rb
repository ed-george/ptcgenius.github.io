require 'net/http'
require 'uri'

module Jekyll
  class ImageGenerator < Generator
    safe true

    def log(msg)
      puts "[DEBUG] [ImageGenerator] - #{msg}"
    end

    def generate(site)

      # Check if we are running on production env or not
      if ENV['JEKYLL_ENV'] == 'production'
        log("Not running plugin due to JEKYLL_ENV in prod mode")
        return
      else
        log("Running ImageGenerator plugin")
      end

      # Check all decks
      site.collections['decks'].docs.each do |deck|

        if deck.data['no_image'] == true
          log("Skipping image generation for #{deck.data['slug']} as no_image set")
          return
        end

        # Generate file path - use slug (e.g. 2022-adp) as the unique file name
        filename = "assets/images/decks/#{deck.data['slug']}.png"

        # Check if file already exists; If so, skip generation
        file_exists = File.file?(filename)
        next if file_exists

        # Otherwise, generate image:

        cards = deck.data['cards']
        all_cards = cards['pokemon'] + cards['trainers'] + cards['energy']

        # Data string for Limitless image generation
        data = all_cards.map { |card| "#{card['quantity']}:#{card['set']}-#{card['number']}~int*en" }.reject(&:empty?).join(' ')

        if data
          # Define the request details
          uri = URI('https://limitlesstcg.com/tools/pnggen')
          form_data = {
            '_token' => '',
            'data' => data,
            'game' => 'PTCG'
          }

          # Make the POST request
          response = Net::HTTP.post_form(uri, form_data)

          if response.is_a?(Net::HTTPSuccess)
            # Create file in generated site (so local previews work on first generation)
            File.open("_site/#{filename}", 'wb') do |file|
              file.write(response.body)
            end

            # Create file in site assets (so local previews work on first generation)
            File.open("#{filename}", 'wb') do |file|
              file.write(response.body)
            end

            log("Image generated for #{deck.data['title']} at #{filename}")
          else
            log("Failed to generate image for #{deck.data['slug']}: #{response.code} - #{response.message}")
          end
        end
      end
    end
  end
end