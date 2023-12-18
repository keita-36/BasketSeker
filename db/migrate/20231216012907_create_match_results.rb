class CreateMatchResults < ActiveRecord::Migration[7.0]
  def change
    create_table :match_results do |t|
      t.references :event, null: false, foreign_key: true
      t.references :user_1, null: false, foreign_key: { to_table: :users }
      t.references :user_2, null: false, foreign_key: { to_table: :users }
      t.references :winner, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
