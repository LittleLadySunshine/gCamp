require 'rails_helper'

describe MembershipsController do
   describe '#destroy' do
      it 'prevents members with role of members from deleting other members' do

      user = create_user

      project = create_project

      create_membership(project, "member", user.id, project.id)

      second_user = create_second_user

      second_member = create_membership(project, "member", second_user.id, project.id)

      session[:user_id] = user.id

      delete :destroy, project_id: project.id, id: second_member.id

      expect(response.status).to eq(404)
    end
   end
 end
