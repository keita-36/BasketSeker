class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :datetime
      t.decimal :latitude, precision: 10, scale: 7, null: false #緯度
      t.decimal :longitude, precision: 10, scale: 7, null: false #経度
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
