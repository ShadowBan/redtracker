class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order("published_at desc")
    @posts = @posts.search_for(params[:q])
    @posts = @posts.tagged_with([params[:categories]], :min=>2, :on=>:categories) if params[:categories]
    @posts = @posts.where(:dev_id=>params[:dev]) if params[:dev]
    @posts = @posts.page(params[:page]).per(25)
    @categories = Post.get_tags 'categories'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
      format.js {render :partial => "stream", :locals=>{:posts=>@posts}}
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def first_post
    @post = Post.find(params[:id])
    render :text=>@post.fp_description
    # respond_to do |format|
    #   format.json { head @post }
    #   format.js {render :text=>@post.fp_description}
    # end
  end
end
