class CreateTethysAggregates < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :tethys_aggregates, id: :uuid do |t|
      t.string :aggregate_type
      t.integer :version, default: -1

      t.timestamps
    end
  end
end
