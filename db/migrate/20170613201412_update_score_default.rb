class UpdateScoreDefault < ActiveRecord::Migration
  def change
    change_column :multi_part_quotes, :score, :integer, default: 0

    MultiPartQuote.all.each{|mpq| mpq.update_attribute(:score, 0) if(mpq.score.nil?)}
  end
end
