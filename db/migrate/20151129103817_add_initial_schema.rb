class AddInitialSchema < ActiveRecord::Migration
  def change
    create_table :car_manufacturers do |t|
      t.string :name, unique: true
      t.timestamps null: false
    end

    create_table :car_models do |t|
      t.string :name
      t.string :year
      t.references :car_manufacturer, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :car_models, [:name, :year], unique: true

    create_table :car_features do |t|
      t.string :name
      t.string :description
      t.timestamps null: false
    end

    create_join_table :car_models, :car_features
  end
end
