//https://iquilezles.org/articles/palettes/
vec3 palette( float t ) {
    vec3 a = vec3(.667,0.500,0.500);
    vec3 b = vec3(-0.132,0.718,0.500);
    vec3 c = vec3(0.667,0.666,-1.192);
    vec3 d = vec3(0.667,0.666,-1.192);

    return a + b*cos( 6.28318*(c*t+d) );
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Constants
    float pi = 3.1459;
    float zoom = 8.; // bigger is further
    float zoom2 = 1.5; // bigger is further
    float colorSpeed = 0.1;
    float colorSpeed2 = 1.2;
    float shapeSpeed = 1.;
    float offset = 0.5;
    float lineThickness = 0.03;
    float sharpness = 1.2;

    // Normalized pixel coordinates
    // From -1 to 1, with origin at the center
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;
    vec2 uv0 = uv;
    float d0 = length(uv0);
    vec3 finalColor = vec3(0.);
    
    for (float i = 1.; i <= 3.; i++) {
    
        uv = fract(uv * zoom2) - offset;
        float d = length(uv) * exp(-d0);
        vec3 col = vec3(0.);
        
        col += palette(d + iTime * colorSpeed);
        col += palette(d0 / 2. + i * 10. - iTime * colorSpeed2);
        //col += uv.xyx + 0.5;

        d = sin(d * zoom + iTime * shapeSpeed);
        d = abs(d);

        d = pow(lineThickness / d, sharpness);

        col *= d;
        
        finalColor += col;
    }
    
    // Tracking lines
    //float lineThickness = 0.04;
    //float threshold = 0.;
    //vec3 col2 = vec3(cos(iTime + uv0.y * 2.));
    //col2 = smoothstep(threshold - lineThickness, threshold, col2) - 
     //   smoothstep(threshold, threshold + lineThickness, col2);
    //col2 = vec3(0.);
    
    // Output to screen
    fragColor = vec4(finalColor,1.0);
}