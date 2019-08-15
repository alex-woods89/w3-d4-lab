require('pry-byebug')
require_relative('./models/star')
require_relative('./models/movie')
require_relative('./models/casting')

Casting.delete_all
Star.delete_all
Movie.delete_all

star1 = Star.new('first_name' => 'Joe', 'second_name' => 'Pesci')
star2 = Star.new('first_name' => 'Ray', 'second_name' => 'Liotta')
star1.save
star2.save

movie1 = Movie.new('title' => 'Goodfellas', 'genre' => 'Drama')
movie2 = Movie.new('title' => 'Hannibal', 'genre' => 'Thriller')
movie1.save
movie2.save

casting1 = Casting.new('movie_id' => movie1.id, 'star_id' => star1.id, 'fee' => 1000)
casting2 = Casting.new('movie_id' => movie1.id, 'star_id' => star2.id, 'fee' => 5000)
casting3 = Casting.new('movie_id' => movie2.id, 'star_id' => star2.id, 'fee' => 6000)
casting1.save
casting2.save
casting3.save



binding.pry
nil
