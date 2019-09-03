PImage background; //danner variabel af typen PImage
PImage sprite; //danner variabel af typen PImage

float posx = random(100,590); //sætter tilfældig startposition
float posy = random(100,590); //sætter tilfældig startposition
float speedx = 3; //sætter starthastighed i x
float speedy = 3; //sætter starthastighed i y

float border = 690; //størrelse af vinduet, som skal bruges til beregninger

float scale_ = 1; //sætter startstørrelsesmultiplikationfaktor til 1

float borderpush = 0.0005; //mængden scale_ bliver forøget med, når spriten rammer grænsen
float borderpushadd = 0.002; //mængden borderpush bliver forøget med, når buttonPressed == true
float natborderpush = 0.005; //startværdi for hvor meget "bolden" naturligt skubber tilbage på grænsen
float natborderpushdecay = 0.00005; //mængden den naturligeborderpush henfalder med pr. push
boolean buttonPressed = false; //boolean, der fortæller programmet, om en knap er trykket.

int x=0; //en variabel, som bliver brugt til en workarround af javas mærkelighed, som bliver brugt i gameover funktionen

void setup(){
  size(690,690); //sætter størrelsen af vinduet
  background = loadImage("PIG.jpg"); //fortæller at når  variablen background bliver kaldt, skal programmet loade billedet "PIG.jpg"
  sprite = loadImage("dvd.png"); //fortæller at når  variablen sprite bliver kaldt, skal programmet loade billedet "dvd.png"
}

void draw(){
  clear(); //fjerner al tidligere grafik
  scale(scale_); //skalerer koordinatsystemet med scale_ variablen
  imageMode(CENTER); //sætter alle billeders input koordinater til at være billedets midte
  image(background,345*pow(scale_,-1),345*pow(scale_,-1)); //tegner baggrundsbilledet. Bemærk at scale komandoen to linjer før kun bliver brugt til billedstørrelse, og billedets koordinater er bare i midten
  imageMode(CORNER); //sætter alle billeders input koordinater til at være billedets øverst-venstre hjørne
  scale(pow(scale_,-1)); //fjerner virkningen fra scale kommandoen fire linjer tidligere
  
  sprite(); //udførrer sprite funktionen
  border(); //udførrer border funktionen
  borderpush(); //udførrer borderpush funktionen
  gameover(); //udførrer gameover funktionen
}

void sprite(){
  posx += speedx; //opdaterer spritens position i x med dens nuværende hastighed i x
  posy += speedy; //opdaterer spritens position i y med dens nuværende hastighed i y
  image(sprite,posx,posy); //tegner "bolden" i de nye x/y psoitioner
}

void border(){ //funktion for al hitbox detection og lidt andet
  if(posx+50>border/2+scale_*border/2){ //hvis billedets position + dens bredde i x er ud over borderens højre sidde
    speedx = -abs(speedx); //sætter den x hastighed til et negativt tal
    borderpushing(); //udførrer borderpushing funktionen
  }
  if(posy+31>border/2+scale_*border/2){ //hvis billedets position + dens bredde i y er ud over borderens højre sidde
    speedy = -abs(speedy); //sætter den x hastighed til et negativt tal
    borderpushing(); //udførrer borderpushing funktionen
  }
  if(posx<690-(border/2+scale_*border/2)){ //hvis billedets position i x er ud over borderens venstre sidde
    speedx = abs(speedx); //sætter den y hastighed til et positivt tal
    borderpushing(); //udførrer borderpushing funktionen
  }
  if(posy<690-(border/2+scale_*border/2)){ //hvis billedets position i y er ud over borderens venstre sidde
    speedy = abs(speedy); //sætter den y hastighed til et positivt tal
    borderpushing(); //udførrer borderpushing funktionen
  }
  
  scale_*=0.998; //sætter scale_ variablen til 0,999 gange scale_
}

void borderpush(){ //funktion til at skubbe grænsen ud hver gang "bolden" rammer
  if(buttonPressed){ //hvis buttonPressed == true
    buttonPressed = false; //sætter buttonPressed = false
    borderpush += borderpushadd; //tilføjer borderpushadd til borderpush
  }
}

void borderpushing(){ 
  scale_ += borderpush; //tilføjer borderpush til scale_
  borderpush = natborderpush; //sætter borderpush = natbordepush
  natborderpush -= natborderpushdecay; //får natbordepush til at henfalde
  if(natborderpush < 0) //sørger for at natborderpush ikke bliver negativt
    natborderpush = 0;
}

void gameover(){ //funktion til at afslutte spillet, når grænsen er blevet for lille
  if(scale_*border<30){ //hvis kassen er mindre end 30 pixels bred
    textSize(300); //skriftstørrelse = 300
    text("F",345-80,345+300); // skriver "F" nederst i midten af vinduet
    
    x++;//tilføjer 1 til x
    if(x>1){ //når x>1 (dvs. når programmet har kørt igennem en ekstra gang, fordi ellers ser man ikke f'et
      delay(2000); //venter to sekunder med at lukke programmet, så man kan se f'et
      exit(); //lukker programmet
    }
  } 
}

void keyReleased(){ //når man slipper en knap, udførrer programmet denne interrupt (er ikke helt sikker på om det er en interrupt). det er ikke keyPressed, da man så vil kunne holde knappen nede.
  buttonPressed = true; //sætter denne boolean til at være true
}
