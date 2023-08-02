# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
30.times do
  FactoryBot.create(:employee)
end

FactoryBot.create(
  :vacation,
  employee: Employee.first,
  start_date: 1.day.ago,
  end_date: 20.days.from_now
)

Employee.second.update(hire_date: 677.days.ago)
