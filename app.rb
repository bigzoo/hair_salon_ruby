require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/client')
require('./lib/stylist')
require('pg')

DB = PG.connect(dbname: 'hair_salon')

get('/')do
  @stylists = Stylist.all
  @clients = Client.all
  erb(:index)
end

get('/stylists/:id')do
  @stylist = Stylist.find(params.fetch('id').to_i)
  @clients = Client.all
  erb(:stylist)
end

get('/clients/:id')do
  @client = Client.find(params.fetch('id').to_i)
  erb(:client)
end

post('/stylists')do
  name = params.fetch('name')
  stylist = Stylist.new(name:name,id:nil)
  stylist.save
  redirect('/')
end

post('/clients')do
  name = params.fetch('name')
  client = Client.new(name:name,id:nil)
  client.save
  redirect('/')
end

post('/stylists/:id/new/client')do
  client = Client.find(params.fetch('client').to_i)
  stylist = Stylist.find(params.fetch('id').to_i)
  client.update(stylist_id:stylist.id)
  redirect('/stylists/'.concat(params.fetch('id')))
end

get('/stylists/delete/:id')do
  stylist = Stylist.find(params.fetch('id').to_i)
  Stylist.delete(stylist.id)
  redirect('/')
end

get('/stylists/:stylist_id/delete/clients/:id')do
  stylist = Stylist.find(params.fetch('stylist_id').to_i)
  client = Client.find(params.fetch('id').to_i)
  Client.delete(client.id)
  clientt = Client.new(name:client.name,id:client.id)
  clientt.save
  redirect('/')
end

get('/clients/delete/:id')do
  client = Client.find(params.fetch('id').to_i)
  Client.delete(client.id)
  redirect('/')
end
