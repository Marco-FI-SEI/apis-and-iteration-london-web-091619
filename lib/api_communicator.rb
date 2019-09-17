require 'rest-client'
require 'json'
require 'pry'

# get a Ruby hash from API call
def get_response
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
end

# get character info
def get_all_character_info(response)
  characters = response["results"]
end

# return film urls for specified character
def get_character_film_urls(all_character_info, character_name)
  all_character_info.each do |character_info|
    name = character_info.first[1].downcase
    if name == character_name
      films = character_info["films"]
      return films
    end
  end
end

# Query the API to get film instances
def get_film_info(films)
  film_objects = []
  films.each do |film|
    film_string = RestClient.get(film)
    film_hash = JSON.parse(film_string)
    film_objects.push(film_hash)
  end
  return film_objects
end

# retrieve film titles from film info
def get_film_titles(films_info)
  film_titles = []
  films_info.each do |info|
    film_titles.push(info.first[1])
  end
  return film_titles
end

def print_movies(films)
  films.each do |title|
    puts title
  end
end

# Call above methods
def show_character_movies(character)
  response = get_response
  all_character_info = get_all_character_info(response)
  character_films_urls = get_character_film_urls(all_character_info, character)
  film_info = get_film_info(character_films_urls)
  film_titles = get_film_titles(film_info)
  print_movies(film_titles)
end
