class Edits < Application
  def index
    @edits = Version.all(:moderated => false, :limit => 100, :order => 'created_at DESC')
    display @edits
  end

  def update
    @edit = Version.first(params[:id])
    raise NotFound unless @edit
    if @edit.update_attributes(:moderated => true)
      if(@edit.spam)
        # send @edit.signature to Defensio with #report-false-positives
      else
        # send @edit.signature to Defensio with #report-false-negatives
      end
      if request.xhr?
        render :nothing => 200
      else
        redirect url(:edits)
      end
    else
      raise BadRequest
    end
  end
end
