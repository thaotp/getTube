# frozen_string_literal: true

require "json"

module Utilities
  class Video
    attr_reader :formats

    def initialize(metadata)
      @metadata = metadata
      @formats = @metadata["formats"].map do |fm|
        ::Utilities::VideoFormat.new(fm)
      end
    end

    # def thumbnail
    #   @metadata["thumbnail"]
    # end

    # def fulltitle
    #   @metadata["fulltitle"]
    # end

    # def duration
    #   @metadata["duration"]
    # end

    # def view_count
    #   @metadata["view_count"]
    # end

    def url
      @metadata["webpage_url"]
    end

    # def uploader
    #   @metadata["uploader"]
    # end

    private

    def method_missing(method, *args, &block)

      if @metadata[method.to_s].present?
        @metadata[method.to_s]
      else
        super
      end
    end

  end
end
