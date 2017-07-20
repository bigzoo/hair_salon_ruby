class Stylist
  attr_reader(:id, :name)

  define_method(:initialize)do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (name) VALUES ('#{name}') RETURNING id;")
    @id = result.first().fetch('id').to_i
  end

  define_singleton_method(:all) do
    results = DB.exec("SELECT * FROM stylists;")
    stylists = []
    results.each() do |stylist|
      id = stylist.fetch('id').to_i
      name = stylist.fetch('name')
      new_stylist = Stylist.new(id:id,name:name)
      stylists.push(new_stylist)
    end
    stylists
  end

  define_singleton_method(:delete) do |id|
    DB.exec("UPDATE clients SET stylist_id = null WHERE stylist_id=#{id};")
    DB.exec("DELETE FROM stylists WHERE id=#{id};")
  end

  define_method(:update)do |attributes|
    @name = attributes.fetch(:name,@name)
    DB.exec("UPDATE stylists SET name='#{@name}' WHERE id=#{id}")
  end

  define_singleton_method(:find)do |id|
    result = DB.exec("SELECT * FROM stylists WHERE id = #{id};")
    Stylist.new(id:result.first().fetch('id').to_i,name:result.first().fetch('name'))
  end

  define_method(:==) do |another_stylist|
    name.==(another_stylist.name)&id.==(another_stylist.id)
  end

  define_method(:clients)do
    results = DB.exec("SELECT * FROM clients WHERE stylist_id=#{id};")
    clients = []
    results.each() do |client|
      client_id = client.fetch('id').to_i
      name = client.fetch('name')
      clients.push(Client.new(id:client_id,name:name,stylist_id:id))
    end
    clients
  end

  define_method(:clients_count)do
    results = DB.exec("SELECT * FROM clients WHERE stylist_id=#{id};")
    count = 0
    results.each() do |client|
      count= count+1
    end
    count
  end
end
