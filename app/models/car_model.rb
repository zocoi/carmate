class CarModel < ActiveRecord::Base
  belongs_to :car_manufacturer

  def full_name
    "#{car_manufacturer.name} #{name} #{year}"
  end
end
