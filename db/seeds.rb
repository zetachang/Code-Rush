# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


books = Book.create [
  {
    :name       => "Your UNIX: The Ultimate Guide",
    :image_url  => "Your Unix.jpeg",
    :ISBN     => "0071189785",
    :description => "A book about unix" 
  },
  {
    :name => "The Ruby Programming Language", 
    :image_url => "The Ruby Programming Language.jpeg",
    :ISBN => "23123123123",
    :description => "A book written by Matz, the creator of Ruby",   
  }
]