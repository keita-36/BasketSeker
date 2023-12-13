class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :datetime
      t.text :location
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
