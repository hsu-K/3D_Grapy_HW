void CGLine(float x1, float y1, float x2, float y2) {
  boolean steep = abs(y2 - y1) > abs(x2 - x1);
  if (steep) {
    float tmp = x1; x1 = y1; y1 = tmp;
    tmp = x2; x2 = y2; y2 = tmp;
  }

  if (x1 > x2) {
    float tmp = x1; x1 = x2; x2 = tmp;
    tmp = y1; y1 = y2; y2 = tmp;
  }

  float dx = x2 - x1;
  float dy = abs(y2 - y1);
  float d = 2 * dy - dx;
  float y = y1;
  int ystep = (y1 < y2) ? 1 : -1;

  for (float x = x1; x <= x2; x++) {
    if (steep) {
      drawPoint(y, x, color(0, 0, 0));
    } else {
      drawPoint(x, y, color(0, 0, 0));
    }

    if (d > 0) {
      y += ystep;
      d -= 2 * dx;
    }
    d += 2 * dy;
  }
}

public void CGCircle(float x, float y, float r) {
    // TODO HW1
    // You need to implement the "circle algorithm" in this section.
    // You can use the function circle(x, y, r); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    //println("x =", x, " y =", y, "r =", r);
    float P, xk, yk;
    P = 1 - r;
    xk = r; yk = 0;
    drawPoint(x + r, y, color(0, 0, 0));
    drawPoint(x, y + r, color(0, 0, 0));
    drawPoint(x - r, y, color(0, 0, 0));
    drawPoint(x, y - r, color(0, 0, 0));
    while(xk >= yk){
        yk += 1;
        if(P <= 0){
            P = P + 2 * yk + 1;
        }
        else{
            xk -= 1;
            P = P + 2 * yk - 2 * xk + 1;
        }
        
        if (xk < yk){
            break;
        }
        drawPoint(x + xk, y - yk, color(0, 0, 0));
        drawPoint(x + yk, y - xk, color(0, 0, 0));
        
        drawPoint(x - xk, y - yk, color(0, 0, 0));
        drawPoint(x - yk, y - xk, color(0, 0, 0));
 
        drawPoint(x - xk, y + yk, color(0, 0, 0));
        drawPoint(x - yk, y + xk, color(0, 0, 0));
        
        drawPoint(x + xk, y + yk, color(0, 0, 0));
        drawPoint(x + yk, y + xk, color(0, 0, 0));
        
    }
    
    /*
    stroke(0);
    noFill();
    circle(x,y,r*2);
    */
}

public void CGEllipse(float x, float y, float r1, float r2) {
    // TODO HW1
    // You need to implement the "ellipse algorithm" in this section.
    // You can use the function ellipse(x, y, r1,r2); to verify the correct answer.
    // However, remember to comment out the function before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    
    //println("r1 =", r1, "r2 =", r2);
    float dx, dy, d1, d2, xk, yk;
    xk = 0;
    yk = r2;
    
    d1 = (r2 * r2) - (r1 * r1 * r2) + (0.25 * r1 * r1);
    dx = 2 * r2 * r2 * xk;
    dy = 2 * r1 * r1 * yk;
    
    
    // For region 1
    drawPoint(x, y + yk, color(0, 0, 0));
    drawPoint(x + r1, y, color(0, 0, 0));
    drawPoint(x, y - yk, color(0, 0, 0));
    drawPoint(x - r1, y, color(0, 0, 0));
    
    while(dx < dy){
        drawPoint(x + xk, y + yk, color(0, 0, 0));
        drawPoint(x - xk, y + yk, color(0, 0, 0));
        drawPoint(x + xk, y - yk, color(0, 0, 0));
        drawPoint(x - xk, y - yk, color(0, 0, 0));
        if(d1 < 0){
            xk += 1;
            dx = dx + (2 * r2 * r2);
            d1 = d1 + dx + (r2 * r2);
        }
        else{
            xk += 1;
            yk -= 1;
            dx = dx + (2 * r2 * r2);
            dy = dy - (2 * r1 * r1);
            d1 = d1 + dx - dy + (r2 * r2);
        }
    }
    
    d2 = ((r2 * r2) * ((xk + 0.5) * (xk + 0.5))) + ((r1 * r1) * ((yk - 1) * (yk - 1))) - (r1 * r1 * r2 * r2);
    
    while(yk >= 0){
        drawPoint(x + xk, y + yk, color(0, 0, 0));
        drawPoint(x - xk, y + yk, color(0, 0, 0));
        drawPoint(x + xk, y - yk, color(0, 0, 0));
        drawPoint(x - xk, y - yk, color(0, 0, 0));
        
        if(d2 > 0){
            yk -= 1;
            dy = dy - (2 * r1 * r1);
            d2 = d2 + (r1 * r1) - dy;
        }
        else{
            yk -= 1;
            xk += 1;
            dx = dx + (2 * r2 * r2);
            dy = dy - (2 * r1 * r1);
            d2 = d2 + dx - dy + (r1 * r1);
        }
    }
   

    /*
    stroke(0);
    noFill();
    ellipse(x,y,r1*2,r2*2);
    */

}

public void CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) {
    // TODO HW1
    // You need to implement the "bezier curve algorithm" in this section.
    // You can use the function bezier(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x,
    // p4.y); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    
    float x, y;
    
    float t = 0;
    while(t <= 1){
        x = pow((1 - t), 3) * p1.x + 3 * pow((1-t), 2) * t * p2.x + 3 * (1 - t) * pow(t, 2) * p3.x + pow(t, 3) * p4.x;
        y = pow((1 - t), 3) * p1.y + 3 * pow((1-t), 2) * t * p2.y + 3 * (1 - t) * pow(t, 2) * p3.y + pow(t, 3) * p4.y;
        drawPoint(x, y, color(0, 0, 0));
        t += 0.0001;
    }
    
    //println(p1, p2, p3, p4);
    /*
    stroke(0);
    noFill();
    bezier(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y);
    */
}

public void CGEraser(Vector3 p1, Vector3 p2) {
    // TODO HW1
    // You need to erase the scene in the area defined by points p1 and p2 in this
    // section.
    // p1 ------
    // |       |
    // |       |
    // ------ p2
    // The background color is color(250);
    // You can use the mouse wheel to change the eraser range.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    float xk, yk;
    xk = p1.x;
    yk = p1.y;
    ArrayList<PVector> erasePoints = new ArrayList<PVector>();
    while(xk <= p2.x){
        while(yk <= p2.y){
            erasePoints.add(new PVector(xk, yk));
            yk += 1;
        }
        for (PVector p : erasePoints) {
            drawPoint((int)p.x, (int)p.y, color(250));
        }
        erasePoints.clear();
        yk = p1.y;
        xk += 1;
    }

}

public void drawPoint(float x, float y, color c) {
    stroke(c);
    point(x, y);
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}
