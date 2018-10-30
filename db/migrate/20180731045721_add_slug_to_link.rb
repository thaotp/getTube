# frozen_string_literal: true

class AddSlugToLink < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :slug, :string
    add_index  :links, :slug, unique: true
  end
end
