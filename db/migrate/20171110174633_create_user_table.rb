class CreateUserTable < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :f_name
      t.string :l_name
      t.string :email
      t.string :location
    end
  end
end
