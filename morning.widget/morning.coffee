# Lovingly crafted by Rohan Likhite [rohanlikhite.com]

command: "finger `whoami` | awk -F: '{ print $3 }' | head -n1 | sed 's/^ // '"


#Refresh time (default: 1/2 minute 30000)
refreshFrequency: 30000


#Body Style
style: """

  color: #fff
  font-family: Helvetica Neue, Arial
  width: 100%;
  text-align: center;

  .container
    margin-top: 120px;
    font-weight: lighter
    font-smoothing: antialiased
    text-align: center;
    text-shadow: 2px 2px 7px rgba(0,0,0,0.1);

  .time
    font-size: 4em
    color: #fff
    font-weight: 300
    text-align: center

  .hour-1
    margin-left: -.28em;

  .hour-2
  .hour-3
  .hour-4
  .hour-5
  .hour-6
  .hour-7
  .hour-8
  .hour-9
  .hour-0
    margin-left: -.2em;

  .minute-1
    margin-right: -.28em;

  .minute-2
  .minute-3
  .minute-4
  .minute-5
  .minute-6
  .minute-7
  .minute-8
  .minute-9
  .minute-0
    margin-right: -.2em;

  .text
    font-size: 2em
    color: #fff
    font-weight: 300
    margin-top: -.3em;

  .salutation
    margin-right: -.25em;

"""

#Render function
render: -> """
  <div class="container">
  <div class="time">
  <span class="hour"></span>
  <span class="divider">:</span>
  <span class="min"></span>
  </div>
  <div class="text">
  <span class="salutation"></span>
  <span class="name"></span>
  </div>
  </div>

"""

  #Update function
update: (output, domEl) ->

  #Options: (true/false)
  showName = true;

  #Time Segmends for the day
  segments = ["morning", "afternoon", "evening", "night"]

  #Grab the name of the current user.
  #If you would like to edit this, replace "output.split(' ')" with your name
  name = output.split(' ')


  #Creating a new Date object
  date = new Date()
  hour = date.getHours()
  minutes = date.getMinutes()

  #Quick and dirty fix for single digit minutes
  minutes = "0"+ minutes if minutes < 10

  #timeSegment logic
  timeSegment = segments[0] if 4 < hour <= 11
  timeSegment = segments[1] if 11 < hour <= 17
  timeSegment = segments[2] if 17 < hour <= 24
  timeSegment = segments[3] if  hour <= 4

  #0 Hour fix
  hour= 12 if hour == 0;

  #DOM manipulation
  $(domEl).find('.salutation').text("Good #{timeSegment}")
  $(domEl).find('.name').text(" , #{name[0]}.") if showName
  $(domEl).find('.hour').text("#{hour}")
  $(domEl).find('.min').text("#{minutes}")
  $(domEl).find('.divider').removeClass('hour-1 hour-2 hour-3 hour-4 hour-5 hour-6 hour-7 hour-8 hour-9 hour-0');
  $(domEl).find('.divider').removeClass('minute-1 minute-2 minute-3 minute-4 minute-5 minute-6 minute-7 minute-8 minute-9 minute-0');
  $(domEl).find('.divider').removeClass('minute-1 minute-2 minute-3 minute-4 minute-5 minute-6 minute-7 minute-8 minute-9 minute-0');
  $(domEl).find('.divider').addClass("hour-#{hour%10} minute-#{Math.floor(minutes/10)}");
