#version 450

layout(location = 0) in vec2 position;

layout(location = 0) out vec4 texPosition;
layout(location = 1) out ivec2 screenResolution;
layout(location = 2) out vec4 cursorInfo;
layout(location = 3) out float time_ms;

layout(set = 0, binding = 0) uniform Data {
    ivec4 screenResolution;
    // (x, y, clicked: {0.0, 1.0}, which: {0.0: left, 1.0: right, 2.0: middle})
    vec4 cursorInfo;
    float time_ms;
    //mat4 world;
    //mat4 view;
    //mat4 proj;
} uniforms;

void main() {
    gl_Position = vec4(position, 0.0, 1.0);

    screenResolution = ivec2(uniforms.screenResolution);
    cursorInfo = uniforms.cursorInfo;
    time_ms = uniforms.time_ms;
}