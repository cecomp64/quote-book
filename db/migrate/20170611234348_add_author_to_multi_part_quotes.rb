class AddAuthorToMultiPartQuotes < ActiveRecord::Migration
  def change
    add_column :multi_part_quotes, :author, :integer
    add_column :quotes, :order, :integer
    add_column :quotes, :multi_part_quote_id, :integer

    # Create Multi Part Quote for every Quote
    Quote.all.each do |quote|
      mpq = MultiPartQuote.create(author: quote.author)
      mpq.quotes << quote
      quote.save
    end

    remove_column :quotes, :author
    drop_table :multi_part_quote_entries
  end
end
