class AddInitialSchema < ActiveRecord::Migration
  def change
    create_table :car_manufacturers do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :car_models do |t|
      t.string :name
      t.references :car_manufacturer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
