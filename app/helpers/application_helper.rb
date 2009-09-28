# Methods added to this helper will be available to all templates in the application.
#require "base64"
#require "openssl"

module ApplicationHelper
  def currentpage(*args)
	arg1 = args[0][0]
	arg2 = args[0][1]
	if args.size == 1
		return ((controller.controller_name==arg1) && (controller.action_name==arg2))
	end
	return ((controller.controller_name==arg1) && (controller.action_name==arg2)) || currentpage(args - [[args[0]],[args[1]]])
  end
  
  def abbrev(string, maxlength)
  	if string.length > maxlength
  		return "<span title='#{string}'>"+string[0..(maxlength-2)] + "..."
  	else
  		return string
  	end
  end
    
  def summarize(string, maxlength, name, options = {}, html_options = {})

  	if string.length > maxlength
  		return string[0..maxlength] + "..." + link_to(name, options, html_options)
	else
		return string
	end 
  end

  def format_time(time)
    #return time.strftime('%a. %b. %e %l:%M %p')
    return time.strftime('%a. %b. %d %I:%M %p')
  end
  
  def proper_url(url)
    if url.blank?
      return nil
    elsif !(url.to_s =~ /https?:\/\/.*/)
     return "http://" + url.to_s
    else
      return url.to_s
    end
  end
  
  def club_image_path(club, file)
    if FileTest.exist?("public/assets/clubs/"+club.web_name+"/"+file)
  	  return compute_public_path(file, 'public/assets/clubs/'+club.web_name)
  	else
  	  return image_path("blank.gif")
  	end
  end
  
  def short_time(time)
    #return time.strftime('%b. %e, %l:%M %p')
    return time.strftime('%b. %d, %I:%M %p')
  end
  
  def truncate_string(text, length = 30, truncate_string = "...")
    return if text.nil?
    l = length - truncate_string.chars.length
    text.chars.length > length ? text[/\A.{#{l}}\w*\;?/m][/.*[\w\;]/m] + truncate_string : text
  end
  
  def display_all_tags_classes(club)
    @tagline = ''
    club.tags.each { |tag| @tagline += ' TAG_' + tag.name }
    return @tagline
  end
  
  def display_multi_line_string(text)
    return text.gsub("\n", "<br />")
  end
  
  
  #FOLLOWING DEFS USED FOR RECAPTCHA, NOT WORKING ATM
  def mailhide(email)
  
    pubkey = "01YEt2vML25j_mJdXHCZp5sA=="
    privkey = "DC8DD53D1762851B633183724D4BCD3D"
    encrypted_email = Base64.encode64(encrypt(privkey, pad_string(email, 16))).tr('+/','-_')
    
    return "http://mailhide.recaptcha.net/d?k="+pubkey+"&c="+encrypted_email
  end
  
  def pad_string(str, block_size)
    numpad = block_size - (str.length % block_size)
    return str.ljust(numpad+str.length, numpad.chr)
  end
  
  def aes(m,k,t)
    (aes = OpenSSL::Cipher::Cipher.new('aes-256-cbc').send(m)).key = Digest::SHA256.digest(k)
    aes.update(t) << aes.final
  end

  def encrypt(key, text)
    aes(:encrypt, key, text)
  end

  def decrypt(key, text)
    aes(:decrypt, key, text)
  end
end
