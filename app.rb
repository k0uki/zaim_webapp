
enable :sessions
set :session_secret, '4d939250c8b435ddd88a6855b46e38c72af48b02f7bee5eafddcb103779aec732b0244f0f1e761bb6dd65e90be4e7ed08a62bc112324f75528af479ca84174ae'
set :public_folder, File.dirname(__FILE__) + '/public'
config_file File.dirname(__FILE__) + '/config/app.yml'

get '/' do
  @logged_in = authorize?
  erb :index
end

get '/zaim/money' do
  set_consumer
  fetch_money_by_genre
end

get '/zaim/category' do
  set_consumer
  fetch_category
end

get '/auth' do
  set_consumer
  api_config = settings.zaim_api
  request_token = @consumer.get_request_token(oauth_callback: api_config['callback_url'])
  session[:request_token] = request_token.token
  session[:request_secret] = request_token.secret
  redirect to(request_token.authorize_url(:oauth_callback => api_config['callback_url']))
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
  api_config = settings.zaim_api
  @consumer = OAuth::Consumer.new(ENV['ZAIM_KEY'], ENV['ZAIM_SECRET'],
    site: api_config['site'],
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

def fetch_category
  m = zaim_client.get("#{settings.zaim_api['site']}/v2/home/category")
  res = JSON.parse(m.body)
  payment = {}
  res['categories'].select{|r|r['mode'] == 'payment'}.each do |r|
    payment[r['id']] = {name: r['name'], sort: r['sort']}
  end
  income = {}
  res['categories'].select{|r|r['mode'] == 'income'}.each do |r|
    income[r['id']] = {name: r['name'], sort: r['sort']}
  end
  JSON.generate({payment:payment, income: income})
end

def fetch_money_by_genre
  payment = {}
  income = {}

  q_p = {group_by: 'receipt_id', start_date: params[:start_date], end_date: params[:end_date]}
  m = zaim_client.get("#{settings.zaim_api['site']}/v2/home/money?#{URI.encode_www_form(q_p)}")
  res = JSON.parse(m.body)

  if res['money'].count < 1
    halt 400, JSON.generate({})
  end

  dates =  res['money'].map{|r| Date.parse(r['date'])}
  days = (dates.max - dates.min).to_i
  res['money'].each do |m|
    if m['mode'] == 'payment'
      payment = set_amount_by_category(payment, m)
    elsif m['mode'] == 'income'
      income = set_amount_by_category(income, m)
    end
  end

  JSON.generate({payment: payment.to_a, income: income.to_a, days: days})
end

def set_amount_by_category(r, m)
  category_id = m['category_id']
  if r.has_key?(category_id)
    r[category_id] += m['amount']
  else
    r[category_id] = m['amount']
  end
  r
end
