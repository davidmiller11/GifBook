# bookmarks_controller.rb
class BookmarksController < ApplicationController

  def index
    # news feed / homepage
    @bookmarks = Bookmark.all
    # add bookmark search form in index file
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def results
    @search_terms = params[:search_terms]
    @giphy_urls_ary = GetGiphy.search_giphy(@search_terms)
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(new_bookmark_params)
    @gif = Gif.create(gif_url: params[:gif_url])

    if @bookmark.valid?
      @bookmark.save
      redirect_to @bookmark
    else
      flash[:notice] = "#{@bookmark.errors}"
      render 'new'
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.update(bookmark_params)
      redirect_to @bookmark
    else
      render 'edit'
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
  end

  private
    def new_bookmark_params
      return params.require(:bookmark).permit(:user_id, :title, :description)
    end

end
