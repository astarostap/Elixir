class CreateDoctorVotes < ActiveRecord::Migration
  def change
    create_table :doctor_votes do |t|
      t.integer :optionNum
      t.timestamps
    end
  end
end
