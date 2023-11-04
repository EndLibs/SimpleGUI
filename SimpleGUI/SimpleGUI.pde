/*
  Простой GUI для Processing.
 Имеется:
 - Функция-кнопка(прямоугольная, круглая)
 - Класс-слайдер(вертикальный, горизонтальный)
 - Класс-джойстик
 - Класс-список
 by EndPortal
 02.11.2023
 */
boolean flr, flc, fn, fn1;    //Переменные для кнопок
float cx, cy, jx1, jx2, jy1, jy2;    //Переменные для слайдеров и джойстиков
int cbg;    //Переменная выбора списка

SliderX sldx = new SliderX();    //Горизонтальный слайдер

SliderY sldy = new SliderY();    //Вертикальный слайдер

JoyStick js1 = new JoyStick();    //Джойстик

JoyStick js2 = new JoyStick();    //Джойстик

List ls = new List();    //Список

void setup() {
  size(1000, 1000);    //Размер окна
}

void draw() {
  color bg = 0;
  switch(cbg) {    //Выбор цвета фона
  case 0: 
    bg = 255; 
    break;
  case 1: 
    bg = 127; 
    break;
  case 2: 
    bg = #00FF00; 
    break;
  }
  background(fn ? #00FFFF : bg);    //Цвет фона зависит от переменной fn, если она 0, то фон это цвет bg

  String ar[] = new String[3];    //Массив строк для списка
  ar[0] = "Белый";
  ar[1] = "Серый";
  ar[2] = "Лайм";

  //Список(номер строки записывается в cbg); координаты(x, y), размеры(ширина, высота), список значений(массив строк), титульный текст, будет ли титульный текст после первого выбора заменен на выбранное значение, размер титульного текста, размер текста значений, цвет списка, цвет текста;
  cbg = ls.update(450, 100, 200, 50, ar, "Цвет фона", true, 30, 30, #0000FF, 0);

  //Джойстик; координаты x200, y200, размер 200, скругление углов 25, размер стика 50, значения для x -50.. 50, значения для y -50.. 50, работа стика бесступенчато, возврат в центр отключен, цвет фона, цвет стика,  текст - положение этого стика, размер текста 20, цвет 255 - белый;
  String str2[] = js2.update(200, 200, 200, 25, 50, -50, 50, -50, 50, false, false, #0000FF, #594BFF, str(jx2) + "," + str(jy2), 20, 255).split(",");
  jx2 = float(str2[0]);
  jy2 = float(str2[1]);

  //Джойстик; координаты зависят от положения второго джойстика, размер 200, скругление 20, стик 50, значения для x -50.. 50, для y -50.. 50, стик работает ступенчато, возврат в центр включен, цвет фона, цвет стика, текст - положение этого стика, размер текста 20, цвет 0 - черный;
  String str1[] = js1.update(width - 200 + jx2, height - 200 + jy2, 200, 20, 50, -50, 50, -50, 50, true, true, #0000FF, #594BFF, str(jx1) + "," + str(jy1), 20, 0).split(",");
  jx1 = float(str1[0]);
  jy1 = float(str1[1]);

  //Горизонтальный слайдер; координаты x, y, ширина, высота, скругление, значение -50.. 50, работает ступенчато, цвет фона, цвет слайдера, текст - положение этого слайдера, размер текста 20, цвет 0 - черный;
  cx = sldx.update(width - 220, 50, 400, 50, 10, 50, -50, 50, true, #0000FF, #594BFF, str(cx), 20, 0);

  //Вертикальный слайдер; координаты x, y, ширина, высота, скругление, размер слайдера, значения -50.. 50, работает бесступенчато, цвет фона, цвет слайдера, текст - значение этого слайдера во float(ограничено 3 знаками после запятой с помощью nfc()), размер текста 20, цвет текста - красный;
  cy = sldy.update(width - 50, 300, 50, 400, 10, 50, -50, 50, false, #0000FF, #594BFF, nfc(cy, 3), 20, #FF0000);

  //Прямоугольная кнопка; координаты зависят от положения первого джойстика, шиирина, высота, скругление, цвет зависит от fn1, ширина обводки 10, цвет обводки красный, текст Фон, размер текста 160, цвет текста синий;
  if (rectButton(width / 2 - 200 + jx1, height / 2 + jy1, 400, 200, 20, fn1 ? #FFFF00 : #00FFFF, 10, #FF0000, "Фон", 160, #0000FF) && !flr) {
    flr = true;
    fn = !fn;    //Меняет переменную fn
  }

  //Круглая кнопка; координаты зависят от положения двух слайдеров, диаметр 200, цвет, ширина обводки 10, цвет обводки, текст Цвет, размер текста 70, цвет текста;
  if (circleButton(width / 2 + 200 + cx, height / 2 + cy, 200, #00FFFF, 10, #FF0000, "Цвет", 70, #0000FF) && !flc) {
    flc = true;
    fn1 = !fn1;    //Меняет переменную fn1
  }
}

void mouseReleased() {    //Обнуление переменных при отпускании мыши
  flr = false;
  flc = false;
}

//Прямоугольная кнопка
boolean rectButton(float x, float y, float w, float h, float r, color colrect, float ws, color colstrok, String text, float textsz, color coltext) {
  pushStyle();
  colorMode(HSB, 255);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  boolean nav = false, prs = false;
  if (abs(mouseX - x) <= w / 2 && abs(mouseY - y) <= h / 2) nav = true;
  if (nav && mousePressed && mouseButton == LEFT) prs = true;
  strokeWeight(ws);
  stroke(!prs ? nav ? color(hue(colstrok), saturation(colstrok) - 100, brightness(colstrok)) : colstrok : color(hue(colstrok), saturation(colstrok) - 150, brightness(colstrok)));
  fill(!prs ? nav ? color(hue(colrect), saturation(colrect) - 100, brightness(colrect)) : colrect : color(hue(colrect), saturation(colrect) - 150, brightness(colrect)));
  rect(x, y, w, h, r);
  fill(!prs ? nav ? color(hue(coltext), saturation(coltext) - 80, brightness(coltext)) : coltext : color(hue(coltext), saturation(coltext) - 120, brightness(coltext)));
  textSize(textsz);
  text(text, x, y - h * 0.1);
  popStyle();
  return prs;
}

//Круглая кнопка
boolean circleButton(float x, float y, float d, color colrect, float ws, color colstrok, String text, float textsz, color coltext) {
  pushStyle();
  colorMode(HSB, 255);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  boolean nav = false, prs = false;
  if (dist(x, y, mouseX, mouseY) <= d / 2) nav = true;
  if (nav && mousePressed && mouseButton == LEFT) prs = true;
  strokeWeight(ws);
  stroke(!prs ? nav ? color(hue(colstrok), saturation(colstrok) - 100, brightness(colstrok)) : colstrok : color(hue(colstrok), saturation(colstrok) - 150, brightness(colstrok)));
  fill(!prs ? nav ? color(hue(colrect), saturation(colrect) - 100, brightness(colrect)) : colrect : color(hue(colrect), saturation(colrect) - 150, brightness(colrect)));
  circle(x, y, d);
  fill(!prs ? nav ? color(hue(coltext), saturation(coltext) - 80, brightness(coltext)) : coltext : color(hue(coltext), saturation(coltext) - 120, brightness(coltext)));
  textSize(textsz);
  text(text, x, y - d / 2 * 0.1);
  popStyle();
  return prs;
}

//Горизонтальный слайдер
class SliderX {
  float out;
  boolean ch;
  SliderX() {
  }

  float update(float x, float y, float w, float h, float r, float wp, float min, float max, boolean pr, color colrect, color colsld, String text, float textsz, color coltext) {
    pushStyle();
    colorMode(HSB, 255);
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    noStroke();
    boolean nav = false, prs = false;
    if (abs(mouseX - x) <= w / 2 && abs(mouseY - y) <= h / 2) nav = true;
    if (nav && mousePressed && mouseButton == LEFT) prs = true;
    if (prs && !ch) ch = true;
    else if (!mousePressed && ch) ch = false;
    if (ch) out = pr ? int(constrain(map(mouseX, x - w / 2 + wp / 2, x + w / 2 - wp / 2, min, max), min, max)) : constrain(map(mouseX, x - w / 2 + wp / 2, x + w / 2 - wp / 2, min, max), min, max);
    fill(colrect);
    rect(x, y, w, h, r);
    fill(!ch ? nav ? color(hue(colsld), saturation(colsld) - 90, brightness(colsld)) : colsld : color(hue(colsld), saturation(colsld) - 140, brightness(colsld)));
    rect(map(out, min, max, x - w / 2 + wp / 2, x + w / 2 - wp / 2), y, wp, h, r);
    fill(coltext);
    textSize(textsz);
    text(text, map(out, min, max, x - w / 2 + wp / 2, x + w / 2 - wp / 2), y);
    popStyle();
    return out;
  }
}

//Вертикальный слайдер
class SliderY {
  float out;
  boolean ch;
  SliderY() {
  }

  float update(float x, float y, float w, float h, float r, float hp, float min, float max, boolean pr, color colrect, color colsld, String text, float textsz, color coltext) {
    pushStyle();
    colorMode(HSB, 255);
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    noStroke();
    boolean nav = false, prs = false;
    if (abs(mouseX - x) <= w / 2 && abs(mouseY - y) <= h / 2) nav = true;
    if (nav && mousePressed && mouseButton == LEFT) prs = true;
    if (prs && !ch) ch = true;
    else if (!mousePressed && ch) ch = false;
    if (ch) out = pr ? int(constrain(map(mouseY, y - h / 2 + hp / 2, y + h / 2 - hp / 2, min, max), min, max)) : constrain(map(mouseY, y - h / 2 + hp / 2, y + h / 2 - hp / 2, min, max), min, max);
    fill(colrect);
    rect(x, y, w, h, r);
    fill(!ch ? nav ? color(hue(colsld), saturation(colsld) - 90, brightness(colsld)) : colsld : color(hue(colsld), saturation(colsld) - 140, brightness(colsld)));
    rect(x, map(out, min, max, y - h / 2 + hp / 2, y + h / 2 - hp / 2), w, hp, r);
    fill(coltext);
    textSize(textsz);
    text(text, x, map(out, min, max, y - h / 2 + hp / 2, y + h / 2 - hp / 2));
    popStyle();
    return out;
  }
}

//Джойстик
class JoyStick {
  float outx, outy;
  boolean ch;
  JoyStick() {
  }

  String update(float x, float y, float w, float r, float wp, float xmin, float xmax, float ymin, float ymax, boolean pr, boolean rtc, color colrect, color coljs, String text, float textsz, color coltext) {
    pushStyle();
    colorMode(HSB, 255);
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    noStroke();
    boolean nav = false, prs = false;
    if (abs(mouseX - x) <= w / 2 && abs(mouseY - y) <= w / 2) nav = true;
    if (nav && mousePressed && mouseButton == LEFT) prs = true;
    if (prs && !ch) ch = true;
    else if (!mousePressed && ch) ch = false;
    if (ch) {
      outx = pr ? int(constrain(map(mouseX, x - w / 2 + wp / 2, x + w / 2 - wp / 2, xmin, xmax), xmin, xmax)) : constrain(map(mouseX, x - w / 2 + wp / 2, x + w / 2 - wp / 2, xmin, xmax), xmin, xmax);
      outy = pr ? int(constrain(map(mouseY, y - w / 2 + wp / 2, y + w / 2 - wp / 2, ymin, ymax), ymin, ymax)) : constrain(map(mouseY, y - w / 2 + wp / 2, y + w / 2 - wp / 2, ymin, ymax), ymin, ymax);
    } else if (rtc) {
      outx = 0;
      outy = 0;
    }
    fill(colrect);
    rect(x, y, w, w, r);
    fill(!ch ? nav ? color(hue(coljs), saturation(coljs) - 90, brightness(coljs)) : coljs : color(hue(coljs), saturation(coljs) - 140, brightness(coljs)));
    rect(map(outx, xmin, xmax, x - w / 2 + wp / 2, x + w / 2 - wp / 2), map(outy, ymin, ymax, y - w / 2 + wp / 2, y + w / 2 - wp / 2), wp, wp, r);
    fill(coltext);
    textSize(textsz);
    text(text, map(outx, xmin, xmax, x - w / 2 + wp / 2, x + w / 2 - wp / 2), map(outy, ymin, ymax, y - w / 2 + wp / 2, y + w / 2 - wp / 2));
    popStyle();
    return str(outx) + "," + str(outy);
  }
}

//Список
class List {
  int out = -1;
  boolean ch, op;
  String lc;
  List() {
  }

  int update(float x, float y, float w, float h, String arr[], String text, boolean dlc, float ts, float ts2, color colrect, color coltext) {
    pushStyle();
    colorMode(HSB, 255);
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    noStroke();
    boolean nav = false, prs = false;
    if (abs(mouseX - x) <= w / 2 && abs(mouseY - y) <= h / 2) nav = true;
    if (nav && mousePressed && mouseButton == LEFT) prs = true;
    if (prs && !ch) {
      ch = true;
      op = !op;
    } else if (!mousePressed && ch) ch = false;
    fill(!prs ? nav ? color(hue(colrect), saturation(colrect) - 100, brightness(colrect)) : colrect : color(hue(colrect), saturation(colrect) - 150, brightness(colrect)));
    rect(x, y, w, h);
    fill(coltext);
    textSize(ts);
    if (out == -1) lc = text;
    text(dlc ? lc : text, x, y - h * 0.1);
    if (op) {
      textSize(ts2);
      for (int i = 0; i < arr.length; i++) {
        boolean navl = false, prsl = false;
        if (abs(mouseX - x) <= w / 2 && abs(mouseY - (y + h * (i + 1))) < h / 2 + (i % 2 == 1 ? 1 : 0)) navl = true;
        if (navl && mousePressed && mouseButton == LEFT) prsl = true;
        fill(navl ? color(hue(colrect), saturation(colrect) - 100, brightness(colrect)) : colrect);
        rect(x, y + h * (i + 1), w, h);
        fill(coltext);
        text(arr[i], x, y + h * (i + 1) - h * 0.1);
        if (prsl) {
          out = i;
          lc = arr[i];
          op = false;
          break;
        }
      }
    }
    popStyle();
    return out;
  }
}
