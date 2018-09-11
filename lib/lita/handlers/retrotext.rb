require 'rubygems'
require 'net/http'
require 'uri'
require 'json'
require 'nokogiri'

class Net::HTTPResponse
  def ensure_success
    unless kind_of? Net::HTTPSuccess
      warn "Request failed with HTTP #{@code}"
      each_header do |h,v|
        warn "#{h} => #{v}"
      end
      abort
    end
  end
end

module Lita
  module Handlers
    class RetroText < Handler

      route(
        /^retro\s([a-zA-Z0-9_]+)\s([a-zA-Z0-9_]+)\s([a-zA-Z0-9_]+)/i,
        :create,
        :command => true,
        :help => {
            "retro TOP_TEXT MIDDLE_TEXT _BOTTOM_TEXT" => "Will create a retro text image"
        }
      )

      ###
      # Creates the text
      def create(response)
        top = response.matches.first[0].tr("_", " ")
        middle = response.matches.first[1].tr("_", " ")
        bottom = response.matches.first[2].tr("_", " ")
        puts("generating image with top text: #{top} | middle text: #{middle} | bottom text: #{bottom}")
        server = rand(9) + 1
        uri_prefix = "http://photofunia.com"
        uri_string = "#{uri_prefix}/categories/all_effects/retro-wave?server=#{server}"

        res = nil
        tries = 0

        loop do
            puts(uri_string)
            uri = URI.parse(uri_string)
            res = Net::HTTP.post_form(
                uri,
                "current-category" => "all_effects",
                "bcg" => 5,
                "txt" => 4,
                "text1" => top,
                "text2" => middle,
                "text3" => bottom
            )
            uri_string = uri_prefix + res['location'] if res['location']
            unless res.kind_of? Net::HTTPRedirection
              res.ensure_success
              break
            end
            if tries == 10
              puts "Timing out after 10 tries"
              break
            end
            tries += 1
          end

        url = extract_url(res.body)

        response.reply("#{url}")
      end

      def extract_url(body)
        doc = Nokogiri::HTML(body)
        a = doc.xpath("//a")
        url = ""
        for i in a do
          text = i.text.delete(" ").strip
          if text == "Large"
            puts(i['href'])
            url = i['href']
          end
        end

        url
      end

      Lita.register_handler(self)
    end
  end
end