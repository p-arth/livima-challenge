class AddInfoToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :nome, :string
    add_column :users, :cargo, :string
    add_column :users, :salário, :string
  end
end
