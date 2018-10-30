# frozen_string_literal: true

class AddYoutubeTypeToLink < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :youtube_type, :string
  end
end
