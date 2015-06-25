class LinkedinController < ApplicationController

  def index
    @authorize_url = get_authorize_url
    # @githubers = Githuber.where(published: true).limit(100).order('followers_count DESC')
    # @title = "Les #{@githubers.size} freelances francophones les plus suivis sur GitHub"
    # @tab = 'githubers'
    # respond_to do |format|
    #   format.html
    #   format.json {
    #     render :json => @githubers
    #   }
    # end
  end

  def create
    # begin
    #   user = Github.users.get user:params[:login]
    # rescue Exception
    #   return render :status => 200
    # end
    # if !user
    #   return render :status => 200
    # end
    # update_or_create(user, 0, params[:login])
  end

  protected

  def get_authorize_url
    client_id = ENV['linkedin_client_id']
    client_secret = ENV['linkedin_client_secret']
    client = LinkedIn::Client.new(client_id, client_secret)
    request_token = client.request_token({}, :scope => "r_basicprofile,r_emailaddress,rw_company_admin,w_share")
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    return request_token.authorize_url
  end

# irb(main):009:0> client.authorize_from_request(rtoken, rsecret, 41871)
# => ["470eaa48-2b45-4cbd-8cf4-b6d74f694d32", "baeaee41-ef25-44a7-8194-7ab7588076b6"]
# irb(main):010:0> client.authorize_from_access("470eaa48-2b45-4cbd-8cf4-b6d74f694d32", "baeaee41-ef25-44a7-8194-7ab7588076b6")
# => ["470eaa48-2b45-4cbd-8cf4-b6d74f694d32", "baeaee41-ef25-44a7-8194-7ab7588076b6"]
# irb(main):011:0>
# irb(main):012:0*
# irb(main):013:0*
# irb(main):014:0*
# irb(main):015:0* client.profile
# => #<LinkedIn::Mash first_name="Xavier" headline="Full stack web & mobile apps developer" id="4otfRZLtjr" last_name="Carpentier" site_standard_profile_request=#<LinkedIn::Mash url="https://www.linkedin.com/profile/view?id=44947736&authType=name&authToken=nsnF&trk=api*a4091004*s4156324*">>
# irb(main):016:0> client.profile(:id => '114217847')
# LinkedIn::Errors::NotFoundError: (404): Not Found
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/lib/ruby/gems/2.2.0/gems/linkedin-1.0.0/lib/linked_in/helpers/request.rb:54:in `raise_errors'
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/lib/ruby/gems/2.2.0/gems/linkedin-1.0.0/lib/linked_in/helpers/request.rb:16:in `get'
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/lib/ruby/gems/2.2.0/gems/linkedin-1.0.0/lib/linked_in/api/query_helpers.rb:27:in `simple_query'
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/lib/ruby/gems/2.2.0/gems/linkedin-1.0.0/lib/linked_in/api/people.rb:22:in `profile'
# 	from (irb):16
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/bin/irb:11:in `<main>'
# irb(main):017:0> client.profile(:url => 'https://fr.linkedin.com/pub/jonathan-path/32/302/35b/en')
# LinkedIn::Errors::GeneralError: (400): [invalid.param.url]. Public profile URL is not correct, {url=https://fr.linkedin.com/pub/jonathan-path/32/302/35b/en}; should be {https://www.linkedin.com/pub/[member-name/]x/y/z}
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/lib/ruby/gems/2.2.0/gems/linkedin-1.0.0/lib/linked_in/helpers/request.rb:49:in `raise_errors'
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/lib/ruby/gems/2.2.0/gems/linkedin-1.0.0/lib/linked_in/helpers/request.rb:16:in `get'
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/lib/ruby/gems/2.2.0/gems/linkedin-1.0.0/lib/linked_in/api/query_helpers.rb:27:in `simple_query'
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/lib/ruby/gems/2.2.0/gems/linkedin-1.0.0/lib/linked_in/api/people.rb:22:in `profile'
# 	from (irb):17
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/bin/irb:11:in `<main>'
# irb(main):018:0> client.profile(:url => 'https://fr.linkedin.com/pub/jonathan-path/32/302/35b')
# => #<LinkedIn::Mash first_name="Jonathan" headline="Founder, coach & blogger for freelancers at FreelanceBoost" id="oVxyVTzm3T" last_name="Path" site_standard_profile_request=#<LinkedIn::Mash url="https://www.linkedin.com/profile/view?id=114217847&authType=name&authToken=HHqk&trk=api*a4091004*s4156324*">>
# irb(main):019:0> client.profile(:url => 'https://www.linkedin.com/pub/jonathan-path/32/302/35b')
# => #<LinkedIn::Mash first_name="Jonathan" headline="Founder, coach & blogger for freelancers at FreelanceBoost" id="oVxyVTzm3T" last_name="Path" site_standard_profile_request=#<LinkedIn::Mash url="https://www.linkedin.com/profile/view?id=114217847&authType=name&authToken=HHqk&trk=api*a4091004*s4156324*">>
# irb(main):020:0> jo = client.profile(:url => 'https://www.linkedin.com/pub/jonathan-path/32/302/35b')
# => #<LinkedIn::Mash first_name="Jonathan" headline="Founder, coach & blogger for freelancers at FreelanceBoost" id="oVxyVTzm3T" last_name="Path" site_standard_profile_request=#<LinkedIn::Mash url="https://www.linkedin.com/profile/view?id=114217847&authType=name&authToken=HHqk&trk=api*a4091004*s4156324*">>
# irb(main):021:0> jo.num-connections
# NameError: undefined local variable or method `connections' for main:Object
# 	from (irb):21
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/bin/irb:11:in `<main>'
# irb(main):022:0> jo['num-connections']
# => nil
# irb(main):023:0> jo.location
# => nil
# irb(main):024:0> jo['location']
# => nil
# irb(main):025:0> jo.first_name
# => "Jonathan"
# irb(main):026:0> jo
# => #<LinkedIn::Mash first_name="Jonathan" headline="Founder, coach & blogger for freelancers at FreelanceBoost" id="oVxyVTzm3T" last_name="Path" site_standard_profile_request=#<LinkedIn::Mash url="https://www.linkedin.com/profile/view?id=114217847&authType=name&authToken=HHqk&trk=api*a4091004*s4156324*">>
# irb(main):027:0> client.profile(:email => 'contact@jonathanpath.com', :fields => ['id'])
# => #<LinkedIn::Mash total=0>
# irb(main):028:0> client.profile(:email => 'mail@xavier-carpentier.com', :fields => ['id'])
# => #<LinkedIn::Mash total=0>
# irb(main):029:0> client.add_share(:comment => 'is playing with the LinkedIn Ruby gem')
# => #<Net::HTTPCreated 201 Created readbody=true>
# irb(main):030:0> client.profile
# => #<LinkedIn::Mash first_name="Xavier" headline="Full stack web & mobile apps developer" id="4otfRZLtjr" last_name="Carpentier" site_standard_profile_request=#<LinkedIn::Mash url="https://www.linkedin.com/profile/view?id=44947736&authType=name&authToken=nsnF&trk=api*a4091004*s4156324*">>
# irb(main):031:0> me = client.profile
# => #<LinkedIn::Mash first_name="Xavier" headline="Full stack web & mobile apps developer" id="4otfRZLtjr" last_name="Carpentier" site_standard_profile_request=#<LinkedIn::Mash url="https://www.linkedin.com/profile/view?id=44947736&authType=name&authToken=nsnF&trk=api*a4091004*s4156324*">>
# irb(main):032:0> me.location
# => nil
# irb(main):033:0> me.picture_url
# => nil
# irb(main):034:0> me.email-address
# NameError: undefined local variable or method `address' for main:Object
# 	from (irb):34
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/bin/irb:11:in `<main>'
# irb(main):035:0> me.headline
# => "Full stack web & mobile apps developer"
# irb(main):036:0> me.first_name
# => "Xavier"
# irb(main):037:0> me.last_name
# => "Carpentier"
# irb(main):038:0> me.industry
# => nil
# irb(main):039:0> me.num-connections
# NameError: undefined local variable or method `connections' for main:Object
# 	from (irb):39
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/bin/irb:11:in `<main>'
# irb(main):040:0> me.connections
# => nil
# irb(main):041:0> me.['first_name']
# SyntaxError: (irb):41: syntax error, unexpected '[', expecting '('
# me.['first_name']
#     ^
# (irb):41: syntax error, unexpected ']', expecting end-of-input
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/bin/irb:11:in `<main>'
# irb(main):042:0> me['first_name']
# => "Xavier"
# irb(main):043:0> me['num-connections']
# => nil
# irb(main):044:0> me['num-connections-capped']
# => nil
# irb(main):045:0> me['id']
# => "4otfRZLtjr"
# irb(main):046:0> client.picture_urls(:id => '4otfRZLtjr')
# => #<LinkedIn::Mash all=["https://media.licdn.com/mpr/mprx/0_Yz_abbLx42-7vnzsZX7hTQoxgYa7vzzsMBj_TQnlro7uAqbqRLGGi2f2-r3"] total=1>
# irb(main):047:0> client.connections
# LinkedIn::Errors::AccessDeniedError: (403): Access to connections denied
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/lib/ruby/gems/2.2.0/gems/linkedin-1.0.0/lib/linked_in/helpers/request.rb:52:in `raise_errors'
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/lib/ruby/gems/2.2.0/gems/linkedin-1.0.0/lib/linked_in/helpers/request.rb:16:in `get'
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/lib/ruby/gems/2.2.0/gems/linkedin-1.0.0/lib/linked_in/api/query_helpers.rb:27:in `simple_query'
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/lib/ruby/gems/2.2.0/gems/linkedin-1.0.0/lib/linked_in/api/people.rb:36:in `connections'
# 	from (irb):47
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/bin/irb:11:in `<main>'
# irb(main):048:0> client.network_updates
# LinkedIn::Errors::AccessDeniedError: (403): Access to network denied
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/lib/ruby/gems/2.2.0/gems/linkedin-1.0.0/lib/linked_in/helpers/request.rb:52:in `raise_errors'
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/lib/ruby/gems/2.2.0/gems/linkedin-1.0.0/lib/linked_in/helpers/request.rb:16:in `get'
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/lib/ruby/gems/2.2.0/gems/linkedin-1.0.0/lib/linked_in/api/query_helpers.rb:27:in `simple_query'
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/lib/ruby/gems/2.2.0/gems/linkedin-1.0.0/lib/linked_in/api/share_and_social_stream.rb:36:in `network_updates'
# 	from (irb):48
# 	from /Users/carpentierxqvier/.rbenv/versions/2.2.0/bin/irb:11:in `<main>'
# irb(main):049:0> user = client.profile(:fields => %w(num-connections))
# => #<LinkedIn::Mash num_connections=500>
# irb(main):050:0> user.num_connections
# => 500
# irb(main):051:0> user = client.profile(:fields => %w(location))
# => #<LinkedIn::Mash location=#<LinkedIn::Mash country=#<LinkedIn::Mash code="fr"> name="Strasbourg Area, France">>
# irb(main):052:0> user.location.name
# => "Strasbourg Area, France"
# irb(main):053:0>
# user = client.profile(:fields => %w(email-address))


end
