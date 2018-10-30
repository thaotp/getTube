# frozen_string_literal: true

require "json"

module Utilities
  class VideoList
    attr_reader :id, :uploader_id, :uploader_url, :title, :webpage_url, :entries

    def initialize(data)
      @data = data
      @id = data['id']
      @uploader_id = data['uploader_id']
      @uploader_url = data['uploader_url']
      @webpage_url = data['webpage_url']
      @title = data['title']
      @entries = set_entries
    end

    def set_entries
      @data['entries'].map do |entry|
        entry["full_url"] = "https://www.youtube.com/watch?v=#{entry['id']}"
        entry["thumbnail"] = "https://img.youtube.com/vi/#{entry['id']}/0.jpg"
        entry
      end
    end
  end
end
