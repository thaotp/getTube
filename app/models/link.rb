# frozen_string_literal: true

class Link < ApplicationRecord
  extend FriendlyId
  extend Enumerize

  VALIDATE_URL = %r{\A(?:https?:\/\/)?(?:www\.)?youtube\.com(?:\S+)?\z}

  friendly_id :youtube_id, use: %i[slugged finders]
  enumerize :youtube_type, in: %i[video playlist], default: :video

  before_create :check_youtube_type!, :set_slug

  validates :url,        presence: true, uniqueness: true, format: {with:    VALIDATE_URL,
                                                                    message: "Invalid URL"}
  validates :youtube_id, presence: true, uniqueness: true

  def youtube_get_id
    if playlist?
      url = self.url.split(/[&|\?]list=([a-zA-Z0-9_-]+)/i)
      url[1].presence
    else
      url = self.url.split(%r{(vi\/|v=|\/v\/|youtu\.be\/|\/embed\/)})
      url[2].present? ? url[2].split(/[^0-9a-z_\-]/i)[0] : nil
    end
  end

  def self.create_by(id: )
    url = "https://www.youtube.com/watch?v=#{id}"
    create(url: url)
  end

  private

  def check_youtube_type!
    self.youtube_type = playlist? ? :playlist : :video
  end

  def set_slug
    self.youtube_id = youtube_get_id
    self.slug = youtube_get_id
  end

  def playlist?
    url.present? && url.scan(/playlist/).present?
  end
end
