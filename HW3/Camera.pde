public class Camera {
    Matrix4 projection = new Matrix4();
    Matrix4 worldView = new Matrix4();
    int wid;
    int hei;
    float near;
    float far;
    Transform transform;

    Camera() {
        wid = 256;
        hei = 256;
        worldView.makeIdentity();
        projection.makeIdentity();
        transform = new Transform();
    }

    Matrix4 inverseProjection() {
        Matrix4 invProjection = Matrix4.Zero();
        float a = projection.m[0];
        float b = projection.m[5];
        float c = projection.m[10];
        float d = projection.m[11];
        float e = projection.m[14];
        invProjection.m[0] = 1.0f / a;
        invProjection.m[5] = 1.0f / b;
        invProjection.m[11] = 1.0f / e;
        invProjection.m[14] = 1.0f / d;
        invProjection.m[15] = -c / (d * e);
        return invProjection;
    }

    Matrix4 Matrix() {
        return projection.mult(worldView);
    }

    void setSize(int w, int h, float n, float f) {
        wid = w;
        hei = h;
        near = n;
        far = f;
        
        // TODO HW3
        // This function takes four parameters, which are 
        // the width of the screen, the height of the screen
        // the near plane and the far plane of the camera.
        // Where GH_FOV has been declared as a global variable.
        // Finally, pass the result into projection matrix.

        float aspect = (float)wid / (float)hei;
        float fovRad = radians(GH_FOV);

        projection = Matrix4.Identity();
        projection.m[0] = 1.0f / (tan(fovRad * 0.5f) * aspect);
        projection.m[5]  = 1.0f / (tan(fovRad * 0.5f));
        projection.m[10] = -(far + near) / (far - near);
        projection.m[11] = -(2.0f * far * near) / (far - near);
        projection.m[14] = -1.0f;
        projection.m[15] = 0.0f;
        // projection = Matrix4.Identity();

    }

    void setPositionOrientation(Vector3 pos, float rotX, float rotY) {

    }

    void setPositionOrientation(Vector3 pos, Vector3 lookat) {
        // TODO HW3
        // This function takes two parameters, which are the position of the camera and
        // the point the camera is looking at.
        // We uses topVector = (0,1,0) to calculate the eye matrix.
        // Finally, pass the result into worldView matrix.
        // println(pos);
        // println(lookat);
        Vector3 up = new Vector3(0, 1, 0);

        // forward vector
        float fx = lookat.x - pos.x;
        float fy = lookat.y - pos.y;
        float fz = lookat.z - pos.z;
        float f_len = sqrt(fx * fx + fy * fy + fz * fz);
        Vector3 vecF = new Vector3(fx / f_len, fy / f_len, fz / f_len);

        // right vector
        float rx = vecF.y * up.z - vecF.z * up.y;
        float ry = vecF.z * up.x - vecF.x * up.z;
        float rz = vecF.x * up.y - vecF.y * up.x;
        float r_len = sqrt(rx * rx + ry * ry + rz * rz);
        Vector3 vecR = new Vector3(rx / r_len, ry / r_len, rz / r_len);

        // up vector
        float ux = vecR.y * vecF.z - vecR.z * vecF.y;
        float uy = vecR.z * vecF.x - vecR.x * vecF.z;
        float uz = vecR.x * vecF.y - vecR.y * vecF.x;
        Vector3 vecU = new Vector3(ux, uy, uz);
        
        worldView = Matrix4.Identity();
        worldView.m[0] = vecR.x; worldView.m[1] = vecR.y; worldView.m[2] = vecR.z; worldView.m[3] = 0;
        worldView.m[4] = vecU.x; worldView.m[5] = vecU.y; worldView.m[6] = vecU.z; worldView.m[7] = 0;
        worldView.m[8]  = -vecF.x; worldView.m[9]  = -vecF.y; worldView.m[10] = -vecF.z; worldView.m[11] = 0;
        worldView.m[12] = -(vecR.x*pos.x + vecR.y*pos.y + vecR.z*pos.z);
        worldView.m[13] = -(vecU.x*pos.x + vecU.y*pos.y + vecU.z*pos.z);
        worldView.m[14] =  (vecF.x*pos.x + vecF.y*pos.y + vecF.z*pos.z);
        worldView.m[15] = 1;
    }
}
