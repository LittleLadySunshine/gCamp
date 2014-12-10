def create_user

  User.create!(
  first_name: "User",
  last_name: "UserLast",
  email: "user@example.com",
  password: "password",
  password_confirmation: "password"
  )

end


def create_second_user
  User.create!(
  first_name: "Joe",
  last_name: "Jones",
  email: "joe@example.com",
  password: "password",
  password_confirmation: "password"
  )

end

def create_project

  Project.create!(name: "Project 1")
end

def create_membership(project, role, user_id, project_id)

  project.memberships.create!(
  role: role,
  user_id: user_id,
  project_id: project_id
  )

end
