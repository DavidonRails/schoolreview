module InstitutionUsers
  def find_users_of(institution)
    user_list = []
    institution.programs.each do |program|
      program.users.each do |user|
        user_list << user unless user_list.include?(user)
      end
    end
    user_list
  end
end
