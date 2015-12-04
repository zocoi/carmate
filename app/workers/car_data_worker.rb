require 'zip'
require 'csv'
require 'open-uri'

class CarDataWorker
  include Sidekiq::Worker
  def perform
    url = "http://www.fueleconomy.gov/feg/epadata/vehicles.csv.zip"
    open(url) do |file|
      Zip::File.open(file.path) do |zip_file|
        # Find specific entry
        entry = zip_file.glob('*.csv').first
        # puts entry.get_input_stream.read
        csv_str = entry.get_input_stream.read
        CSV.parse(csv_str, headers: true) do |row|
          # p row['make']
          # p row['model']
          # p row['year']
          make = CarManufacturer.find_or_create_by(name: row['make'])
          p make.name
          car_model = CarModel.find_or_create_by(name: row['model'], year: row['year'])
          p car_model.name
          p car_model.year
          unless car_model.car_manufacturer
            car_model.car_manufacturer = make
            car_model.save
          end
          p car_model.car_manufacturer_id
        end
      end
    end
    # do something
  end
end