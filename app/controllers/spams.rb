class Spams < Application
  # provides :xml, :yaml, :js

  def index
    @spams = Spam.all
    display @spams
  end

  def show
    @spam = Spam.first(params[:id])
    raise NotFound unless @spam
    display @spam
  end

  def new
    only_provides :html
    @spam = Spam.new
    render
  end

  def edit
    only_provides :html
    @spam = Spam.first(params[:id])
    raise NotFound unless @spam
    render
  end

  def create
    @spam = Spam.new(params[:spam])
    if @spam.save
      redirect url(:spam, @spam)
    else
      render :new
    end
  end

  def update
    @spam = Spam.first(params[:id])
    raise NotFound unless @spam
    if @spam.update_attributes(params[:spam])
      redirect url(:spam, @spam)
    else
      raise BadRequest
    end
  end

  def destroy
    @spam = Spam.first(params[:id])
    raise NotFound unless @spam
    if @spam.destroy!
      redirect url(:spam)
    else
      raise BadRequest
    end
  end

end
