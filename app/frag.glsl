#version 450

layout(location=0)in vec4 texPosition;
layout(location=1)flat in ivec2 screenResolution;
layout(location=2)in vec4 cursorInfo;
layout(location=3)in float time_ms;

layout(location=0)out vec4 f_color;

const float BORDER_EPSILON=.005;
const float PI=3.14159265;

// Transparent black
const vec4 COLOR_EMPTY=vec4(0.,0.,0.,.1);
// Red
const vec4 COLOR_INNER=vec4(1.,0.,0.,.9);
// Green
const vec4 COLOR_BORDER=vec4(0.,1.,0.,.5);
// Green
const vec4 COLOR_CLICKED=vec4(0.,1.,0.,.5);

// Distance of a point to the border of a circle around the origin
float circleDist(vec2 p,float radius)
{
    return length(p)-radius;
}

float sinDist(vec2 p,float radius)
{
    return sin(2.*PI*length(p))*circleDist(p,radius);
}

float max2(vec2 p)
{
    return max(p.x,p.y);
}

// Distance of a point and a rectangle around origin
// @param p Point
// @param size (width, height) of rectangle around origin
float rectangleDist(vec2 p,vec2 size)
{
    // Use double symmetry
    vec2 d=abs(p)-size/2.;
    return max2(d);
}

// is (point) distance outside an object
bool isOutside(float dist)
{
    return dist>0.;
}
// is (point) distance inside an object
bool isInside(float dist)
{
    return dist<0.;
}
// is (point) on the border of an object
bool isBorder(float dist)
{
    return abs(dist)<BORDER_EPSILON;
}

void main(){
    // Origin in top left: (0, 0)
    const vec2 p=gl_FragCoord.xy;
    const float aspectRatio=float(screenResolution.x)/screenResolution.y;
    // Normalize coordinates
    const vec2 p_n=(p/screenResolution*2.-1.)*vec2(aspectRatio,1.);
    
    // TODO: Pass element list via uniform buffers:
    // {
        //       num_elements,
        //       [(type, color, pos, data)] where data:      (param0, param1, param2)
        //                                              e.g. (width,  height, 0.0F)
    // }
    // and iterate all elements
    const vec2 cursorPosition=vec2(cursorInfo);
    const float cursorClicked=cursorInfo.z;
    
    const vec2 cursorCenter_n=(cursorPosition*2.-1.)*vec2(aspectRatio,1.);
    const float cursorFreq_Hz=.5;
    const float cursorRadiusMax_n=.3;
    const float cursorRadius_n=cursorRadiusMax_n*(sin(2.*PI*cursorFreq_Hz*time_ms/1000.)+1.)*.5;
    const float distCursor=circleDist(p_n-cursorCenter_n,cursorRadius_n);
    
    const float dist=distCursor;
    
    vec4 color=COLOR_INNER;
    if(cursorClicked>0.){
        color=COLOR_CLICKED;
    }
    // Mask out pixels outside the cursor shape: step(0, dist) is 0 inside, 1 outside
    f_color=(1.-step(0,dist))*color;
}
