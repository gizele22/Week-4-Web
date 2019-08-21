class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  # set public folder for static files
  set :public_folder, File.expand_path('../../public', __FILE__)

  # set folder for templates to ../views, but make the path absolute
  set :views, File.expand_path('../../views', __FILE__)

  enable :sessions

  require 'sinatra'

  get '/' do
    erb :index
  end

  get '/level' do
    @game_level = params['game_level']

    session['guessed_number'] = nil
    session['secret_number'] = nil

    erb :level
  end

  post '/level' do
    session['level'] = params['game_level']

    session['total_chances'] = 6
    session['counter'] = 0

    redirect to('/game')
  end

  get '/game' do
    session['secret_number'] = secret_number(session['level'])
    erb :game
  end

  post '/game' do
    session['guessed_number'] = params['guessed_number']
    if number_matched_win
      erb :result
    else
      session['counter'] += 1

      if session['counter'] == session['total_chances']
        erb :over
      else
        erb :game
      end
    end
  end

  get '/result' do
    erb :result
  end

  post '/result' do
    session['game'] = params['guessed_number']
  end

private
  def secret_number(level)
    if level == 'easy'
      rand(1..20)
    elsif level == 'medium'
      rand(21..40)
    else level == 'hard'
      rand(41..77)
    end
  end

  def run_game
    3
  end

  def count

    @count = 0
    session['level'].to_i > session['guessed_number'] = @count
    if session[guessed_number] = session['secret_number']
    erb :result
  else
    erb :game
  end
end

  def number_matched_win
    session['guessed_number'].to_i == session['secret_number']
  end

  post '/index' do
    session['name'] = params['age']
    if game_end
      erb :result
    end

  def game_end
    session[@player_name].to_i == record['age']
  end
end
