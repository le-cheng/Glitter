#version 330 core
out vec4 FragColor;

in vec3 ourColor;
in vec2 TexCoord;

uniform sampler2D texture1;
uniform sampler2D texture2;
uniform float mixValue; // The value coming from the slider in the GUI

void main()
{
    FragColor = mix(texture(texture1, TexCoord), texture(texture2, TexCoord), mixValue);
}