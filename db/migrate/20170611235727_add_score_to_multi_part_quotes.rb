class AddScoreToMultiPartQuotes < ActiveRecord::Migration
  def change
    add_column :multi_part_quotes, :score, :integer
    Quote.all.each do |quote|
      quote.multi_part_quote.update_attribute :score, quote.score
    end
    remove_column :quotes, :score
  end
end
