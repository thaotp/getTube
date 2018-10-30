# frozen_string_literal: true

module Utilities
  class VideoFormat
    attr_reader :metadata

    def initialize(metadata)
      @metadata = metadata
    end

    # def http_headers
    #   @metadata["http_headers"]
    # end

    def name
      @metadata["format"]
    end

    # def url
    #   @metadata["url"]
    # end

    # def note
    #   @metadata["format_note"]
    # end

    def filesize
      @metadata["filesize"]
    end

    # def resolution
    #   @metadata["resolution"]
    # end

    # def ext
    #   @metadata["ext"]
    # end

    # def tbr
    #   @metadata["tbr"]
    # end

    def video_only?
      @metadata["acodec"] == "none"
    end

    def audio?
      @metadata["vcodec"] == "none"
    end

    def video?
      !video_only? && !audio?
    end

    def resolution
      @metadata["resolution"]
    end

    def type
      if video_only?
        "video_only"
      elsif audio?
        "audio"
      else
        "video"
      end
    end

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
