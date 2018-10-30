# frozen_string_literal: true

require "json"

module Utilities
  class YoutubeDl
    def self.get_metadata(url)
      cmd = "youtube-dl --print-json --skip-download  #{url}"
      execute(cmd) do |response|
        Utilities::Video.new(response)
      end
    end

    def self.get_list(url)
      cmd = "youtube-dl -J #{url} --skip-download --flat-playlist"
      execute(cmd) do |response|
        Utilities::VideoList.new(response)
      end
    end

    def self.execute(cmd, &block)
      response = `#{cmd}`
      if response.present? && block_given?
        block.call(JSON.parse(response))
      else
        nil
      end
    end
  end
end
