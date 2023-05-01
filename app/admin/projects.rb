ActiveAdmin.register Project do
  menu priority: 2

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :body, :user_id, :state
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :body, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  filter :user
  filter :title

  index do
    selectable_column
    id_column
    column :title
    column :body
    column :surname
    column :user
     tag_column :state do |project|
      project.state_display
    end
    # toggle_bool_column :state, if: proc { |project| projects.present? }
    # toggle_bool_column :no, unless: proc { |project| projects.is_free? }

    # toggle_bool_column (:state) do |projects|
    #    projects.state? ? status_tag("yes", :ok) : status_tag( "no" )
    #   end
    
    actions
  end

    
  form do |f|
    f.inputs do
      f.input :user
      f.input :title
      f.input :body
      f.input :surname
      f.input :state do |project|
        status_tag projects.state, class: projects.state ? :pending : :complete
      end
    f.actions
    end
  end

  show do
    panel "project" do
      attributes_table_for  project do
        row :title
        row :surname
        row :body 
        row :user
        row :state, :boolean
        end
      end
    end
end

