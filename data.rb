require 'trello'

include Trello
include Trello::Authorization

def auth(app_key, app_secret, user_token)
  Trello::Authorization.const_set :AuthPolicy, OAuthPolicy
  OAuthPolicy.consumer_credential = OAuthCredential.new(app_key, app_secret)
  OAuthPolicy.token = OAuthCredential.new(user_token, nil)
end

def assigned_to_user_on_board(user, board)
  lists = {}
  Board.find(board).lists.each{ |l|
    lists[l.id] = {:name => l.name, :items => []}
  }
  Board.find(board).cards.select{|c|
    c.member_ids.include? user
  }.each{|c|
    lists[c.list_id][:items] << c.name
  }
  return lists
end