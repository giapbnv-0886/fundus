module ApplicationHelper
  def log_in user
    session[:user_id] = user.id
  end

  def link_to_add_blogs(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    blogs = f.fields_for(association, new_object, child_index: id) do |blog|
      render("cadmin/blogs/"+association.to_s.singularize + "_fields", f: blog)
    end
    content_tag(:p, name, class: "add_blogs", data: {id: id, blogs: blogs})
  end

  def get_cause_title idd
    return @cause.title if @cause = Cause.all.unscoped.find_by(id: idd)
  end

  def get_actions
    @activities = PublicActivity::Activity.all.where(owner_type: "User").order created_at: :desc
  end

  def get_notifications
    @notifications = current_user.notifications.latest
  end
end
