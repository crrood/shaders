// Normalized pixel coordinates (from -1 to 1)
vec2 normalize()
{
  return (fragCoord * 2.0 - iResolution.xy) / iResolution.y;
}

// generate a random number
float random (vec2 st) {
  return fract(sin(dot(st.xy, 
    vec2(12.9898,78.233)))*43758.5453123);
}

// generate a palette of colors over a single axis t
// https://iquilezles.org/articles/palettes/
vec3 palette( float t ) {
  vec3 a = vec3(1.338,0.270,0.270);
  vec3 b = vec3(-1.715,0.277,0.351);
  vec3 c = vec3(0.930,1.710,0.930);
  vec3 d = vec3(0.200,0.138,0.048);

  return a + b*cos( 6.28318*(c*t+d) );
}

// signed distance of point p from a box with sides b
float sdBox( in vec2 p, in vec2 b )
{
  vec2 d = abs(p)-b;
  return length(max(d,0.0)) + min(max(d.x,d.y),0.0);
}

// rotates a coordinate uv by degree theta
vec2 rotate( in vec2 uv, in float theta )
{
  return vec2(uv.x * cos(theta) - uv.y * sin(theta),
    uv.x * sin(theta) + uv.y * cos(theta));
}

// translation functions
// https://iquilezles.org/articles/functions/
float cubicPulse( float c, float w, float x )
{
    x = abs(x - c);
    if( x>w ) return 0.0;
    x /= w;
    return 1.0 - x*x*(3.0-2.0*x);
}

const float PI = 3.1459;