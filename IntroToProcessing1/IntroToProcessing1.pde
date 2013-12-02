int borderSpacing = 40;
color backgroundColor = color(256, 256, 256);

int coffeeWidth = 60;
int coffeeHeight = 80;
int coffeeSpacing = 20;
color coffeeColor = color(22, 13, 16);
color milkCoffeeColor = color(168, 136, 100);

int sugarWidth = (coffeeWidth - coffeeSpacing) / 2;
int sugarHeight = (coffeeWidth - coffeeSpacing) / 2;
int sugarXOffset = (coffeeWidth - coffeeSpacing) / 4;
int sugarYOffset = (coffeeHeight - coffeeSpacing) - sugarHeight - (coffeeWidth - coffeeSpacing) / 4;
color sugarColor = color(256);

int coffeeHandleWidth = 14;
int coffeeHandleHeight = 45;

Table table;
int maxDisplayColumns;

void setup() {
  noStroke();
  smooth();
  size(500, 400);
  background(backgroundColor);

  // Get the data...
  table = loadTable("/Users/jmday/Downloads/wwc_survey.csv", "header");
  
  maxDisplayColumns = (width - 2 * borderSpacing) / coffeeWidth;
}

void draw() {
  // Look through all rows of the data. Display left to right, top to bottom.
  int columnNumber = 0;
  int rowNumber = 0;
  boolean takesSugar = false;
  boolean takesMilk = false;


  for (TableRow row : table.rows()) {
    String thingsInCoffee = (row.getString(4));
    takesSugar = (thingsInCoffee.indexOf("Sugar") >= 0);
    takesMilk = (thingsInCoffee.indexOf("Milk") >= 0);
    
    drawCoffee(columnNumber, rowNumber, takesMilk, takesSugar);

    columnNumber = (columnNumber + 1) % maxDisplayColumns;
    if(columnNumber == 0) { rowNumber++; }
  }
}

void drawCoffee(int col, int row, boolean withMilk, boolean withSugar) {
  int x = borderSpacing + col * coffeeWidth;
  int y = borderSpacing + row * coffeeHeight;
  color fillColor = withMilk ? milkCoffeeColor : coffeeColor;

  drawHandle(x, y, fillColor);
  
  fill(fillColor);
  rect(x, y, coffeeWidth - coffeeSpacing, coffeeHeight - coffeeSpacing);

  if (withSugar) {
     drawSugar(x + sugarXOffset, y + sugarYOffset);
  }
}

void drawSugar(int x, int y) {
  fill(sugarColor);
  rect(x, y, sugarWidth, sugarHeight);
}

void drawHandle(int x, int y, color fillColor) {
  // Draw handle
  fill(fillColor);
  ellipse(x + coffeeWidth - coffeeSpacing, y + (coffeeHeight - coffeeSpacing) / 2, coffeeHandleWidth * 2, coffeeHandleHeight);
  fill(backgroundColor);
  ellipse(x + coffeeWidth - coffeeSpacing, y + (coffeeHeight - coffeeSpacing) / 2, coffeeHandleWidth * 2 - 4, coffeeHandleHeight - 4);
}
