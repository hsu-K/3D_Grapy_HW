public void CGLine(float x1, float y1, float x2, float y2) {
    stroke(0);
    line(x1, y1, x2, y2);
}

public boolean outOfBoundary(float x, float y) {
    if (x < 0 || x >= width || y < 0 || y >= height)
        return true;
    return false;
}

public void drawPoint(float x, float y, color c) {
    int index = (int) y * width + (int) x;
    if (outOfBoundary(x, y))
        return;
    pixels[index] = c;
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}

boolean pnpoly(float x, float y, Vector3[] vertexes) {
    // TODO HW2
    // You need to check the coordinate p(x,v) if inside the vertexes.
    boolean inside = false;
    int vertexnum = vertexes.length;
    int j = vertexnum - 1;
    for(int i = 0 ; i < vertexnum ; i++){
        float xi = vertexes[i].x;
        float yi = vertexes[i].y;
        float xj = vertexes[j].x;
        float yj = vertexes[j].y;
        
        if(((yi > y) != (yj > y)) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi)) {
            inside = !inside;
        }
        j = i;
    }
    return inside;
}

public Vector3[] findBoundBox(Vector3[] v) {    
    // TODO HW2
    // You need to find the bounding box of the vertexes v.

    Vector3 recordminV = new Vector3(1.0 / 0.0);
    Vector3 recordmaxV = new Vector3(-1.0 / 0.0);
    Vector3[] result = { recordminV, recordmaxV };
    for(Vector3 p: v){
        if(p.x < result[1].x) result[1].x = p.x;
        if(p.y < result[1].y) result[1].y = p.y;
        if(p.z < result[1].z) result[1].z = p.z;
        
        if(p.x > result[0].x) result[0].x = p.x;
        if(p.y > result[0].y) result[0].y = p.y;
        if(p.z > result[0].z) result[0].z = p.z;
    }
    Vector3 temp = result[0];
    result[0] = result[1];
    result[1] = temp;
    return result;
}

public Vector3[] Sutherland_Hodgman_algorithm(Vector3[] points, Vector3[] boundary) {
    ArrayList<Vector3> input = new ArrayList<Vector3>();
    ArrayList<Vector3> output = new ArrayList<Vector3>();
    for (int i = 0; i < points.length; i += 1) {
        input.add(points[i]);
    }

    // TODO HW2
    // You need to implement the Sutherland Hodgman Algorithm in this section.
    // The function you pass 2 parameter. One is the vertexes of the shape "points".
    // And the other is the vertexes of the "boundary".
    // The output is the vertexes of the polygon.

    for(int i = 0; i < boundary.length ; i++){
        Vector3 A = boundary[i];
        Vector3 B = boundary[( i + 1) % boundary.length];
        output.clear();  
        int pre = input.size() - 1;

        for(int j = 0; j < input.size() ; j++){
            Vector3 S = input.get(pre);
            Vector3 E = input.get(j);
          
            boolean S_inside = isInside(S, A, B);
            boolean E_inside = isInside(E, A, B);
            
            println(S_inside, E_inside);
            if(S_inside == true && E_inside == true){
                output.add(E);
            }
            else if(S_inside == true && E_inside == false){
                output.add(intersection(S, E, A, B));
            }
            else if(S_inside == false && E_inside == true){
                output.add(intersection(S, E, A, B));
                output.add(E);  
           }
           pre = j;
        }
        input = new ArrayList<>(output);
    }
    
    Vector3[] result = new Vector3[output.size()];
    for (int i = 0; i < result.length; i += 1) {
        result[i] = output.get(i);
    }
    return result;
}

boolean isInside(Vector3 P, Vector3 A, Vector3 B) {
    return (B.x - A.x)*(P.y - A.y) - (B.y - A.y)*(P.x - A.x) <= 0;
}

public Vector3 intersection(Vector3 S, Vector3 E, Vector3 A, Vector3 B){
    float dx1 = E.x - S.x;
    float dy1 = E.y - S.y;
    float dx2 = B.x - A.x;
    float dy2 = B.y - A.y;

    float t = ((A.x - S.x) * dy2 - (A.y - S.y) * dx2) / (dx1 * dy2 - dy1 * dx2);
    return new Vector3(S.x + t * dx1, S.y + t * dy1, 0);
}

public float getDepth(float x, float y, Vector3[] vertex) {
    // TODO HW3
    // You need to calculate the depth (z) in the triangle (vertex) based on the
    // positions x and y. and return the z value;

    return 0.0;
}

float[] barycentric(Vector3 P, Vector4[] verts) {

    Vector3 A = verts[0].homogenized();
    Vector3 B = verts[1].homogenized();
    Vector3 C = verts[2].homogenized();

    // TODO HW4
    // Calculate the barycentric coordinates of point P in the triangle verts using
    // the barycentric coordinate system.

    float[] result = { 0.0, 0.0, 0.0 };

    return result;
}
