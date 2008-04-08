class Edits < Application
  def index
    @edits = Version.all
    display @edits
  end

  def update
    @edit = Version.first(params[:id])
    raise NotFound unless @spam
    if @edit.update_attributes(:moderated => true)
      if(@edit.spam)
        # send @edit.signature to Defensio with #report-false-positives
      else
        # send @edit.signature to Defensio with #report-false-negatives
      end
      redirect url(:edits)
    else
      raise BadRequest
    end
  end
end
