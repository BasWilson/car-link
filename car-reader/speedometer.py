import pygame 
import obd
import options

class Speedometer:
    def __init__(self):
        pygame.init()

        self.black = (0, 0, 0) 
        self.white = (255, 255, 255) 
        self.green = (0, 255, 0) 
        self.blue = (0, 0, 128) 

        self.monitor = pygame.display.Info()

        # create the display surface object 
        # of specific dimension..e(X, Y). 
        
        if options.mockMode:
            self.display_surface = pygame.display.set_mode((480, 320))
        else:
            self.display_surface = pygame.display.set_mode((0, 0), pygame.FULLSCREEN)

        # textRect.center = (monitor.current_w // 2, monitor.current_h // 2) 

        # set the pygame window name 
        pygame.display.set_caption('car-link') 

        # Speed
        self.speed = '0'
        self.rpm = '0'
        self.lastRpm = 100

        self.speedoFont = pygame.font.Font('DS-DIGIB.ttf', 200) 
        self.rpmFont = pygame.font.Font('DS-DIGIB.ttf', 25) 
        self.HEAT_BAR_IMAGE = pygame.Surface((300, 10))

        self.color = pygame.Color(0, 255, 0)

        for x in range(self.HEAT_BAR_IMAGE.get_width()):
            for y in range(self.HEAT_BAR_IMAGE.get_height()):
                self.HEAT_BAR_IMAGE.set_at((x, y), self.color)
            if self.color.r < 254:
                self.color.r += 2
            if self.color.g > 1:
                self.color.g -= 1

        self.heat = 100  # 5% of the image are already visible.

    def speedoLoop(self, connection):
        if not options.mockMode:
            speedResponse = connection.query(obd.commands['SPEED'])
            rpmResponse = connection.query(obd.commands['RPM'])
            self.speed = str(speedResponse.value).replace('kph', '')
            self.rpm = str(rpmResponse.value).replace('revolutions_per_minute', '')


        speedoText = self.speedoFont.render(self.speed, True, self.white) 
        speedoRect = speedoText.get_rect()  

        rpmText = self.rpmFont.render(self.rpm + " RPM", True, self.white) 
        rpmRect = rpmText.get_rect()  

        clock = pygame.time.Clock()
        heat_rect = self.HEAT_BAR_IMAGE.get_rect()
        
        heat = 100 / options.maxRPM * (float(self.rpm))  # Set the bar according to RPM
        heat = max(1, min(heat, 100))  # Clamp the value between 1 and 100.

        pygame.display.flip()
        clock.tick(30)

        speedoRect.center = (480 // 2, 120) 
        rpmRect.center = (480 // 2, 240) 
        heat_rect.center = (480 // 2, 210) 

        # completely fill the surface object 
        # with white color 
        self.display_surface.fill(self.black) 

        # copying the text surface object 
        # to the display surface object  
        # at the center coordinate. 
        self.display_surface.blit(speedoText, speedoRect) 
        self.display_surface.blit(rpmText, rpmRect) 
        self.display_surface.blit(self.HEAT_BAR_IMAGE, heat_rect, (0, 0, heat_rect.w/100*heat, heat_rect.h)) 

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
