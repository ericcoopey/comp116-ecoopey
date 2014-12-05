Image Analysis
Used commands "file" and "stat" to analyze files, 1 and 3 are same, 2 was different.  Created a simple bash file to read the contents of a common password list:

while read p; do
  echo $p
  steghide extract -sf b.jpg -p $p
done < password.lst

PW was disney

It output a binary file called RunMe, running "strings RunMe" output:
blinky_the_wonder_chimp
Perhaps use your first name as an argument. :-)
Please send me an email with the subject: I believe that I will win!
%s, you are doing a heckuvajob up to this point!


1.  Partition 1 - FAT32, Partition 2 - EXT
2.  No
3.  Kali Linux 1.09 - found /etc/debian_version
4. Normal Kali install - Used kpartx to mount the image and searched it, found standard Kali tools in /bin
5. root::princess
6.  stefani::iloveyou, judas::00000000
7. Multiple pictures of celebrity stored in /home/alejandro, itinerary of upcoming shows in /home/stefani/sched.txt
8. 
9. 14 images in /home/alejandro
10.
11.  12/31/2014: The Chelsea at the Cosmopolitan of Las Vegas Las Vegas, NV 9:00 p.m. PST
2/8/2015: Wiltern Theatre, Los Angeles, CA, 9:30 p.m. PST
5/30/2015: Hollywood Bowl, Hollywood, CA, 7:30 p.m. PDT
12. Lady Gaga
