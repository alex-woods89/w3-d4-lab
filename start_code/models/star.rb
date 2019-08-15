require_relative('../db/sql_runner')

class Star

attr_reader :id
attr_accessor :first_name, :second_name

def initialize(options)
  @id = options['id'].to_i if options['id']
  @first_name = options['first_name']
  @second_name = options['second_name']
end

def save
  sql = "INSERT INTO stars (first_name, second_name)
VALUES ($1, $2)
RETURNING id"
  values = [@first_name, @second_name]
  star = SqlRunner.run(sql, values)
  @id = star[0]['id'].to_i
end

def self.delete_all
  sql = "DELETE FROM stars"
  SqlRunner.run(sql)
end

def movies
  sql = 'SELECT movies.* FROM movies
       INNER JOIN castings on castings.movie_id = movies.id
       WHERE star_id = $1'
  values = [@id]
  movies_data = SqlRunner.run(sql, values)
  return movies_data.map {|movie_data| Movie.new(movie_data) }
end
end
