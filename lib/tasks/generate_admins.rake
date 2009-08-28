namespace :SkuleClubs do
  desc "Generates default admin for each club. Also creates a super admin with the parameters super=your_name pass=your_pass" 
  task :admin_seed => :environment do |task, args|
    #pass in parameters super=your_name pass=your_pass
    #Note: these parameters are optional
    @name = args[:super]
    @pass = args[:pass]
    if !@name.blank? && !Admin.find(:first, :conditions => {:login => @name})
      @admin = Admin.new
      @admin.login = @name
      if !@pass.blank? && @pass.length > 5
        @admin.password = @pass
        @admin.password_confirmation = @pass
      else
        @admin.password = "qwerty"
        @admin.password_confirmation = "qwerty"
      end
      @admin.super_admin = true
      @admin.event = @admin.updates = @admin.member = @admin.group = @admin.file = @admin.gallery = false
      if !@admin.save
        puts "No Super Admin Today!"
      end
    end
    
    # The user name is the same as the club name (With capitals, spaces, exclamation marks, etc.)
    #   The pass is the reverse of the club name without spaces 
    #   If the club name (without spaces is less than 6 characters)
    #   the pass is padded with 0s until there are at least 6 chars
    @clubs = Club.find(:all)
    @clubs.each do |club|
      if !Admin.find(:first, :conditions => {:login => club.name})
        @pass = club.name.gsub(/ /,'').reverse
        #Add some padding if too short
        until(@pass.length > 5)
          @pass += "0"
        end
        @admin = Admin.new
        @admin.login = club.name
        @admin.password = @pass.to_s
        @admin.password_confirmation = @pass.to_s
        @admin.super_admin = false
        @admin.event = @admin.updates = @admin.member = @admin.group = @admin.file = @admin.gallery = false
        @admin.club_id = club.id
        if !@admin.save_with_validation(false)
          puts "ERROR: Could not generate admin for " + club.name + " --------\n"
        else
          #puts club.name + " " + @pass + "\n"
        end
      end
    end
  end
end
