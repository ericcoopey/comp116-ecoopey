require 'packetfu'

filename = ARGV.first
incident_number = 0

if filename != nil  # was a log file passed to the program?
	line_num = 0
	errors = 0
	File.open(filename).each do |line|
		begin
			#parse the log file line
			if line.include? "GET" or line.include? "POST" or line.include? "OPTIONS"
				matches = /^(\S+).*\s(.*)\sHTTP\S*\s(\d+)/.match(line)
			else
				matches = /^(\S+).*\s(.*)\s\S*\s(\d+)/.match(line)
			end
			#parsed data
			ip = matches[1]
			url = String.try_convert(matches[2])
			status = Integer(matches[3])
			payload = matches[4]

			#evaluate alerts
			if line.include? "Nmap"
				puts "#{incident_number += 1}. ALERT: Nmap Scan is detected from #{ip} (HTTP) (#{payload})!"
			elsif status > 399 and status < 500
				puts "#{incident_number += 1}. ALERT: HTTP Error is detected from #{ip} (HTTP) (#{url})!"
			elsif url.index("\\") == 0
				puts "#{incident_number += 1}. ALERT: Shellcode is detected from #{ip} (HTTP) (#{url})!"
			end
		rescue
			#continue on any parsing errors
			errors += 1
			next
		end
	end				
else # no log file, so read live stream
	#card signatures
	visa = /4\d{3}(\s|-)?\d{4}(\s|-)?\d{4}(\s|-)?\d{4}/
	mastercard = /5\d{3}(\s|-)?\d{4}(\s|-)?\d{4}(\s|-)?\d{4}/
	discover = /6011(\s|-)?\d{4}(\s|-)?\d{4}(\s|-)?\d{4}/
	am_exp = /3\d{3}(\s|-)?\d{6}(\s|-)?\d{5}/

	stream = PacketFu::Capture.new(:start => true, :iface => 'eth0', :promisc => true)

	loopholder = false

	while loopholder==false do
		stream.stream.each do |p|
			thispacket = PacketFu::Packet.parse(p)
			if !thispacket.is_ip? or (thispacket.class.name != "PacketFu::TCPPacket" and thispacket.class.name != "PacketFu::UDPPacket")
				next
			end
			if thispacket.class.name == "PacketFu::UDPPacket"
				packet_body = thispacket.payload
			else
				packet_body = thispacket.payload
				flag_val = thispacket.tcp_header.tcp_flags.to_i
				#null scan
				if flag_val == 0
					puts "#{incident_number+=1}. ALERT: NULL scan is detected from #{thispacket.ip_header.ip_saddr} (#{thispacket.proto.last})!"
				#christmas tree
				elsif (flag_val == 41)
					puts "#{incident_number+=1}. ALERT: Xmas scan is detected from #{thispacket.ip_header.ip_saddr} (#{thispacket.proto.last})!"
				end
			end

			#listen for credit card
			if (packet_body.match(mastercard) != nil or packet_body.match(visa) != nil or packet_body.match(discover) != nil or packet_body.match(am_exp) != nil)
				puts "#{incident_number+=1}. ALERT: Credit card leaked in the clear from #{thispacket.ip_header.ip_saddr} (#{thispacket.proto.last})!"
			#nmap scan
			elsif (packet_body.match("Nmap") != nil)
				puts "#{incident_number+=1}. ALERT: Nmap scan is detected from #{thispacket.ip_header.ip_saddr} (#{thispacket.proto.last})!"
			end
		end # stream do
	end # while stream
end
