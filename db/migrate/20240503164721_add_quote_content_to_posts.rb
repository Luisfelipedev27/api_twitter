class AddQuoteContentToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :quote_content, :string
  end
end
