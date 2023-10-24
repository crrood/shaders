// Normalized pixel coordinates (from -1 to 1)
vec2 normalizeCoords( vec2 coords )
{
  return (coords * 2.0 - iResolution.xy) / iResolution.y;
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

float cubicPulse( float c, float w, float x )
{
    x = abs(x - c);
    if( x>w ) return 0.0;
    x /= w;
    return 1.0 - x*x*(3.0-2.0*x);
}

  ////////////////////////////////////////////////////////////////////////////
 ////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  const float WIDTH = 0.01;
  const float SPEED = 0.5;
  
  vec2 uv = normalizeCoords( fragCoord );
  vec2 uv0 = uv;

  vec3 brightness = 0.5 - vec3(smoothstep(0., WIDTH, abs(uv.y))) / 2.;

  float fractTime = - (fract(iTime * SPEED) * 2. - 1.);
  brightness += cubicPulse(0., WIDTH, uv.x + fractTime) / 2.;

  brightness -= 0.5;
  brightness *= 2.;

  vec3 color = vec3(1.0, 0.9, 0.4);

  fragColor = vec4(brightness * color, 1.0f);
}