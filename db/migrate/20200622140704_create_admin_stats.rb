class CreateAdminStats < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_stats do |t|
      t.string :description
      t.decimal :value, default: 0.00

      t.timestamps
    end
  end
end
