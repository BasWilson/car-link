import pygame 
import obd
import options
import program
import random

pygame.init()

black = (0, 0, 0) 
white = (255, 255, 255) 
green = (0, 255, 0) 
blue = (0, 0, 128) 

monitor = pygame.display.Info()

# create the display surface object 
# of specific dimension..e(X, Y). 
display_surface = pygame.display.set_mode((480, 320))
# display_surface = pygame.display.set_mode((0, 0), pygame.FULLSCREEN)

# set the pygame window name 
pygame.display.set_caption('car-link') 

# Speed
speed = '0'

speedoFont = pygame.font.Font('DS-DIGIB.ttf', 200) 

# KPH
kphFont = pygame.font.Font('DS-DIGIB.ttf', 40) 
kphText = kphFont.render('KPH', True, white) 
kphRect = kphText.get_rect()  
# textRect.center = (monitor.current_w // 2, monitor.current_h // 2) 


while True: 
    
    if options.mockMode:
        speed = str(random.randint(1,99))
    else:
        response = program.connection.query(obd.commands['SPEED'])
        speed = str(response.value).replace('kph', '')


    speedoText = speedoFont.render(speed, True, white) 
    speedoRect = speedoText.get_rect()  

    speedoRect.right = 350
    kphRect.right = 410
    speedoRect.top = 70
    kphRect.top = 200

    # completely fill the surface object 
    # with white color 
    display_surface.fill(black) 
  
    # copying the text surface object 
    # to the display surface object  
    # at the center coordinate. 
    display_surface.blit(speedoText, speedoRect) 
    display_surface.blit(kphText, kphRect) 
  
    # iterate over the list of Event objects 
    # that was returned by pygame.event.get() method. 
    for event in pygame.event.get() : 
  
        # if event object type is QUIT 
        # then quitting the pygame 
        # and program both. 
        if event.type == pygame.QUIT : 
  
            # deactivates the pygame library 
            pygame.quit() 
  
            # quit the program. 
            quit() 
  
        # Draws the surface object to the screen.   
        pygame.display.update()  