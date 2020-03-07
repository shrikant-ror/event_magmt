users_csv = Rails.root.join("public", "csv", "users.csv")
events_csv = Rails.root.join("public", "csv", "events.csv")

SmarterCSV.process(users_csv).each do |u|
  user = User.new
  user.username = u[:username]
  user.email = u[:email]
  user.phone = u[:phone]
  user.save!
end

SmarterCSV.process(events_csv).each do |e|
  event = Event.new
  event.title = e[:title]
  event.start_time = DateTime.parse(e[:starttime])
  event.end_time = DateTime.parse(e[:endtime])
  event.description = e[:description]
  event.all_day = e[:allday] == 'true'
  # This will assing first user as organizer
  event.organizer = User.first
  event.save!

  # Enroll users for envets
  users_rsvp = e.with_indifferent_access["users#rsvp"]
  next if users_rsvp.blank?
  users_rsvp = users_rsvp.split(";")
  users_rsvp.each do |u_rsvp|
    u_rsvp = u_rsvp.split("#")
    user = User.find_by(username: u_rsvp[0])
    enrollment = Enrollment.new
    enrollment.user = user
    enrollment.event = event
    enrollment.rsvp = u_rsvp[1]
    enrollment.save!
  end
  puts "Completed enrollment for event: #{e[:title]}"
end
