# frozen_string_literal: true

class AddYoutubeIdToLink < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :youtube_id, :text
  end
end
