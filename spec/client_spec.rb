require('spec_helper')

describe(Client) do
  describe('#initialize') do
    it('It initializes new instances of the class') do
      client = Client.new(id: nil, name: 'Bob Collymore', stylist_id: nil)
      expect(client).to(be_an_instance_of(Client))
    end
  end

  describe('#id') do
    it('It returns the id of instances') do
      client = Client.new(id: nil, name: 'Bob Collymore', stylist_id: nil)
      client.save
      expect(client.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#name') do
    it('It returns the name of instances') do
      client = Client.new(id: nil, name: 'Bob Collymore', stylist_id: nil)
      client.save
      expect(client.name).to(eq('Bob Collymore'))
    end
  end

  describe('#stylist_id') do
    it('It returns the stylist_id of instances') do
      client = Client.new(id: nil, name: 'Bob Collymore', stylist_id: 1)
      client.save
      expect(client.stylist_id).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#save') do
    it('It saves a new client to the database') do
      client = Client.new(id: nil, name: 'Bob Collymore', stylist_id: nil)
      client.save
      expect(Client.all).to(eq([client]))
    end
  end

  describe('#delete') do
    it('It deletes a client from the database') do
      client = Client.new(id: nil, name: 'Bob Collymore', stylist_id: nil)
      client2 = Client.new(id: nil, name: 'Bob Collymore', stylist_id: nil)
      client.save
      client2.save
      Client.delete(client.id)
      expect(Client.all).to(eq([client2]))
    end
  end

  describe('.find') do
    it('It finds a specified client when given the id') do
      client = Client.new(id:nil,name:"Bob Collymore",stylist_id:nil)
      client2 = Client.new(id:nil,name:"Bob Collymore",stylist_id:nil)
      client.save
      client2.save
      expect(Client.find(client.id)).to(eq(client))
    end
  end

  describe('.all') do
    it('The database is initially empty') do
      expect(Client.all).to(eq([]))
    end

    it('It saves new instances of classes') do
      client1 = Client.new(id:nil,name:"Bob",stylist_id:nil)
      client1.save
      client2 = Client.new(id:nil,name:"Collymore",stylist_id:nil)
      client2.save
      expect(Client.all).to(eq([client1,client2]))
    end

    it('It saves new instances of classes in the order they are saved in') do
      client1 = Client.new(id:nil,name:"Bob",stylist_id:nil)
      client2 = Client.new(id:nil,name:"Collymore",stylist_id:nil)
      client2.save
      client1.save
      expect(Client.all).to(eq([client2,client1]))
    end
  end

  describe('#==')do
    it('It sees clients with equal id and name as equal') do
      client1 = Client.new(id:nil,name:"Bob Collymore",stylist_id:nil)
      client2 = Client.new(id:nil,name:"Bob Collymore",stylist_id:nil)
      expect(client1).to(eq(client2))
    end
  end

  describe('#update')do
    it('It updates the name of a client when the stylist_id is nil') do
      client = Client.new(id:nil,name:"Bob Collymore",stylist_id:nil)
      client.save
      client.update(name:'Lewinski')
      expect(client.name).to(eq('Lewinski'))
    end

    it('It updates the name of a client when the stylist_id is not nil') do
      client = Client.new(id:nil,name:"Bob Collymore",stylist_id:1)
      client.save
      client.update(name:'Lewinski')
      expect(client.name).to(eq('Lewinski'))
    end

    it('It updates the stylist_id of a client when it is nil') do
      client = Client.new(id:nil,name:"Bob Collymore",stylist_id:nil)
      client.save
      client.update(stylist_id:2)
      expect(client.stylist_id).to(eq(2))
    end

    it('It updates the name and stylist_id of a client when it is nil') do
      client = Client.new(id:nil,name:"Bob Collymore",stylist_id:nil)
      client.save
      client.update(name:'Lewinski',stylist_id:2)
      expect(client.stylist_id).to(eq(2))
      expect(client.name).to(eq('Lewinski'))
    end

    it('It updates the name and stylist_id of a client when it is already assigned') do
      client = Client.new(id:nil,name:"Bob Collymore",stylist_id:1)
      client.save
      client.update(name:'Lewinski',stylist_id:2)
      expect(client.stylist_id).to(eq(2))
      expect(client.name).to(eq('Lewinski'))
    end
  end

  describe('#stylist')do
    it('It returns a clients stylist') do
      stylist = Stylist.new(id:nil,name:"Jimek")
      stylist.save
      client = Client.new(id:nil,name:"Bobi Collymore",stylist_id:stylist.id)
      client.save
      expect(client.stylist).to(eq(stylist))
    end
  end
end
