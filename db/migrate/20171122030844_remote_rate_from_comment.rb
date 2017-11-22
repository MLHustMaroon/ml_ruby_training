class RemoteRateFromComment < ActiveRecord::Migration[5.1]
  def change
    remove_column :comments, :rate
  end
end
