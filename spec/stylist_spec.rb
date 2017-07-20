require('spec_helper')
require('pry')

describe(Stylist)do
  describe('#initialize')do
    it('In initializes new instances of the class Stylist') do
      stylist = Stylist.new(id:nil,name:"Jimek")
      expect(stylist).to(be_an_instance_of(Stylist))
    end
  end

  describe('#id')do
    it("It allows ids of instances to be selected") do
      stylist = Stylist.new(id:nil,name:"Jimek")
      stylist.save
      expect(stylist.id).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#name')do
    it("It allows names of instances to be selected") do
      stylist = Stylist.new(id:nil,name:"Jimek")
      stylist.save
      expect(stylist.name).to(eq("Jimek"))
    end
  end

  describe('.all')do
    it("It is initially empty at first") do
      expect(Stylist.all).to(eq([]))
    end

    it("New instances of the class can be saved in the database") do
      stylist = Stylist.new(id:nil,name:"Jimek")
      stylist.save
      expect(Stylist.all).to(eq([stylist]))
    end
  end

  describe('#==')do
    it('It identifies stylistsas equal if they have the same name and id') do
      stylist1 = Stylist.new(id:nil,name:"Jimek")
      stylist2 = Stylist.new(id:nil,name:"Jimek")
      expect(stylist1).to(eq(stylist2))
    end
  end

  describe('.delete')do
    it('It deletes stylists from the database') do
      stylist = Stylist.new(id:nil,name:"Jimek")
      stylist.save
      Stylist.delete(stylist.id)
      expect(Stylist.all).to(eq([]))
    end
  end

  describe('.find') do
    it('It locates stylists in the database when given an id') do
      stylist = Stylist.new(id:nil,name:"Jimek")
      stylist.save
      stylist2 = Stylist.new(id:nil,name:"Lewinski")
      stylist2.save
      expect(Stylist.find(stylist2.id)).to(eq(stylist2))
    end
  end

  describe('#update')do
    it('It updates the names of stylists in the database') do
      stylist = Stylist.new(id:nil,name:"Jimek")
      stylist.save
      stylist.update(name:"Lewinski")
      expect(stylist.name).to(eq("Lewinski"))
    end
  end

  describe('#clients') do
    it('It returns the clients of a specific stylist') do
      client1 = Client.new(id:nil,name:'Bobi Collymore')
      client1.save
      client2  = Client.new(id:nil, name:'Andrew Anampiu')
      client2.save
      stylist = Stylist.new(id:nil,name:'Jimek Lewinski')
      stylist.save
      client2.update(stylist_id:stylist.id)
      expect(stylist.clients).to(eq([client2]))
    end
  end
end
