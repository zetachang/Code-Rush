class ApplicationController < ActionController::Base
  protect_from_forgery
  protected
    def current_shelf
      Bookshelf.find(session[:bookshelf_id])
    rescue  ActiveRecord::RecordNotFound
      bookshelf = Bookshelf.create(:name => 'Bob')
      session[:bookshelf_id] = bookshelf.id
      bookshelf
    end
end
