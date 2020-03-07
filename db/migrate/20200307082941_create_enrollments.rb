class CreateEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_table :enrollments do |t|
      t.belongs_to :user
      t.belongs_to :event
      t.string :rsvp
      t.timestamps
    end
  end
end
