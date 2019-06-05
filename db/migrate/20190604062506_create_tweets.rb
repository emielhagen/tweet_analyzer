class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :query
      t.text :body
      t.string :sentiment
      t.decimal :score

      t.timestamps
    end
  end
end
