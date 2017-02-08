require 'jumpstart_auth'

class MicroBlogger
	attr_reader :client
	def initialize
		puts "Initializing MicroBlogger"
		@client = JumpstartAuth.twitter
	end


	def tweet(message)

		if message.length >140
			puts "Your message must be 140 characters or less."
		else
			@client.update(message)
			return message
			#puts "tweeted #{message}"
		end
	end


	def dm(target, message)
		puts "trying to send #{target} this direct message: "
		puts message
		screen_names = @client.followers.collect{ |follower| @client.user(follower).screen_name}
		if screen_names.include?(target)
			message = "d @#{target} #{message}"
			tweet(message)
			puts "sent #{message} to @#{target}"
		else 
			puts "You can only direct message people who follow you."
		end
	end

	def run
		command = ""
		while command != "q"
			printf "enter command: "
			input = gets.chomp.split(" ")
			command = input[0]
			case command
			when "q"
				puts "goodbye!"
			when "t"
				message = tweet(input[1..-1].join(" "))
				puts "tweeted #{message}"
			when "d"
				dm(input[1],input[2..-1].join(" "))
			else
				puts "wtf is #{command}"
			end
		end
	end


end

blogger = MicroBlogger.new
blogger.run