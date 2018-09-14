class AddPrToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :pr, :string
  end
end
