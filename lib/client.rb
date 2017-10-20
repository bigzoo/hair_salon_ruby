class Client
  attr_reader(:id,:name,:stylist_id)

  define_method(:initialize)do |attributes|
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @stylist_id = attributes.fetch(:stylist_id, @stylist_id)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (name) VALUES ('#{name}') RETURNING id;")
    @id = result.first().fetch('id').to_i
  end

  define_singleton_method(:all)do
    results = DB.exec("SELECT * FROM clients;")
    clients = []
    results.each() do |client|
      id = client.fetch('id').to_i
      name = client.fetch('name')
      stylist_id = client.fetch('stylist_id').to_i
      new_client = Client.new(id:id,name:name,stylist_id:stylist_id)
      clients.push(new_client)
    end
    clients
  end

  define_singleton_method(:delete)do |id|
    DB.exec("DELETE FROM clients WHERE id=#{id}")
  end

  define_singleton_method(:find) do |id|
    result = DB.exec("SELECT * FROM clients WHERE id =#{id};")
    Client.new(id:id,name:result.first().fetch('name'),stylist_id:result.first().fetch('stylist_id').to_i)
  end

  define_method(:==) do |another_client|
    id.==(another_client.id)&name.==(another_client.name)
  end

  define_method(:update)do |attributes|
    @name = attributes.fetch(:name,@name)
    @stylist_id = attributes.fetch(:stylist_id,@stylist_id)
    DB.exec("UPDATE clients SET name = '#{@name}' WHERE id=#{id};")
    if @stylist_id
      DB.exec("UPDATE clients SET stylist_id = #{@stylist_id} WHERE id=#{id};")
    end
  end

  define_method(:stylist)do
    stylist = nil
    if self.stylist_id==nil
      stylist = Stylist.new(name:'Unsassinged',id:nil)
    else
      res = DB.exec("SELECT * FROM stylists WHERE id=#{self.stylist_id};")
      res.each()do |st|
        stname = st.fetch('name')
        stid = st.fetch('id').to_i
        stylist = Stylist.new(id:stid,name:stname)
      end
    end
    stylist
  end
end
