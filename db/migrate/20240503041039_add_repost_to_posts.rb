class AddRepostToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :original_post, foreign_key: { to_table: :posts }
  end
end
