class AddRepostAndQuoteToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :repost, null: true, foreign_key: { to_table: :posts }
    add_reference :posts, :quote, null: true, foreign_key: { to_table: :posts }
  end
end
