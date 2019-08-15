require_relative('../models/casting')

class Movie

attr_reader :id
attr_accessor :title, :genre

def initialize(options)
  @id = options['id'].to_i if options['id']
  @title = options['title']
  @genre = options['genre']
  @budget = options['budget']
end

def save
  sql = 'INSERT INTO movies (title, genre)
         VALUES ($1, $2)
         RETURNING id'
  values = [@title, @genre]
  movie = SqlRunner.run(sql, values)
  @id = movie[0]['id'].to_i
end

def self.delete_all
  sql = "DELETE FROM movies"
  SqlRunner.run(sql)
end

def stars
  sql = 'SELECT stars.* FROM stars
        INNER JOIN castings on castings.star_id = stars.id
        WHERE movie_id = $1'
  values = [@id]
  stars_data = SqlRunner.run(sql, values)
  return stars_data.map {|star_data| Star.new(star_data) }
end

# def casting_expenses
#    fee = ""
# end

end
