CONSUMER_KEY = '1153a3e38a00db982e9f93ed7799362f93720278'
CONSUMER_SECRET = 'b2b2bf024d6132b7d784126733ea71ef9f9b303e'
CALLBACK_URL = 'http://localhost:9292/auth/callback'
API_URL = 'https://api.zaim.net/v2/'

enable :sessions
set :session_secret, '4d939250c8b435ddd88a6855b46e38c72af48b02f7bee5eafddcb103779aec732b0244f0f1e761bb6dd65e90be4e7ed08a62bc112324f75528af479ca84174ae'
set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
  if authorize?
    set_consumer
    m = zaim_client.get("#{API_URL}home/money")
    "now get your money! #{JSON.parse(m.body)}"
  else
    "hello world!"
  end
end

get '/auth' do
  set_consumer
  request_token = @consumer.get_request_token(oauth_callback: CALLBACK_URL)
  session[:request_token] = request_token.token
  session[:request_secret] = request_token.secret
  redirect to(request_token.authorize_url(:oauth_callback => CALLBACK_URL))
end

get '/auth/callback' do
  if session[:request_token] && params[:oauth_verifier]
    set_consumer
    @request_token = OAuth::RequestToken.new(@consumer, session[:request_token], session[:request_secret])
    access_token = @request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
    session[:access_token] = access_token.token
    session[:access_secret] = access_token.secret
    redirect to('/')
  else
    redirect to('/auth/clear')
  end
end

get '/auth/clear' do
  session.clear
  redirect to('/')
end

private
def set_consumer
  @consumer = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET,
    site: 'https://api.zaim.net',
    request_token_path: '/v2/auth/request',
    authorize_url: 'https://auth.zaim.net/users/auth',
    access_token_path: '/v2/auth/access')
end

def authorize?
  session[:access_token] && session[:access_secret]
end

def zaim_client
  @client ||= OAuth::AccessToken.new(@consumer, session[:access_token], session[:access_secret])
end
