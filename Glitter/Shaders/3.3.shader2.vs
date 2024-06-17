#version 330 core
layout (location = 0) in vec3 aPos;   // 位置变量的属性位置值为 0 
layout (location = 1) in vec3 aColor; // 颜色变量的属性位置值为 1

out vec3 ourColor; // 向片段着色器输出一个颜色

uniform float xpos;
uniform float offsetColor;
float pi = 3.141592;

void main()
{
    gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);

    vec3 color;
    color.x = aColor.x*pi/2+offsetColor; // 红色通道
    color.y = aColor.y*pi/2+offsetColor; // 绿色通道
    color.z = aColor.z*pi/2+offsetColor; // 蓝色通道

    ourColor.x = (sin(color.x) + 1.0) / 2.0; // 红色通道
    ourColor.y = (sin(color.y) + 1.0) / 2.0; // 绿色通道
    ourColor.z = (sin(color.z) + 1.0) / 2.0; // 蓝色通道

}