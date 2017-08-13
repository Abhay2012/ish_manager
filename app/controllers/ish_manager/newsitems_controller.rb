
class IshManager::NewsitemsController < IshManager::ApplicationController

  before_action :set_lists

  def new
    @newsitem = Newsitem.new
    if params[:city_id]
      @city = City.find params[:city_id]
      @newsitem.city = @city
    end
    if params[:site_id]
      @site = Site.find params[:site_id]
      @newsitem.site = @site
    end
    authorize! :new, @newsitem
  end

  def create
    n = Newsitem.new params[:newsitem].permit!
    @resource = City.find params[:city_id] if params[:city_id]
    @resource = Site.find params[:site_id] if params[:site_id]
    authorize! :create_newsitem, @resource

    @resource.newsitems << n
    flag = @resource.save
    if flag
      @resource.touch
    else
      error = 'No Luck. ' + @resource.errors.inspect
    end
    url = params[:city_id] ? edit_city_path( @resource.id ) : edit_site_path( @resource.id )
    
    if flag
      flash[:notice] = 'Success'
      redirect_to url
    else
      flash[:alert] = error
      render :action => :new
    end
  end
  
  def destroy
    authorize! :destroy, Newsitem
    if params[:city_id]
      flag = City.find( params[:city_id] ).newsitems.find( params[:id] ).destroy
      url = edit_city_path( params[:city_id] )
    end
    if params[:site_id]
      site = Site.find( params[:site_id] )
      flag = site.newsitems.find( params[:id] ).destroy
      url = edit_site_path( params[:site_id] )
    end

    flash[:notice] = "Success? #{flag}"
    redirect_to url
  end

  def update
    if params[:site_id]
      @site = Site.find params[:site_id]
      @site.touch
      @newsitem = @site.newsitems.find params[:id]
      url = edit_site_path( @site )
    end
    if params[:city_id]
      @city = City.find params[:city_id]
      @newsitem = @city.newsitems.find params[:id]
      url = edit_city_path( @city )
    end
    authorize! :update, @newsitem
    flag = @newsitem.update_attributes params[:newsitem].permit!
    
    if flag
      flash[:notice] = 'Success'
    else
      flash[:error] = "No Luck: #{@newsitem.errors.messages}"
    end

    redirect_to url
  end
  
  def edit
    if params[:site_id]
      @site = Site.find params[:site_id]
      @newsitem = @site.newsitems.find( params[:id] )
    end
    if params[:city_id]
      @city = City.find params[:city_id]
      @newsitem = @city.newsitems.find( params[:id] )
    end
    authorize! :edit, @newsitem
  end

  private

  def set_lists
    @videos_list    = Video.list
    @galleries_list = Gallery.list
    @reports_list   = Report.list
  end

end

