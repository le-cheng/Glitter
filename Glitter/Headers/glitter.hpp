// Preprocessor Directives
#ifndef GLITTER
#define GLITTER
#pragma once

// System Headers
#include <assimp/Importer.hpp>
#include <assimp/postprocess.h>
#include <assimp/scene.h>
#include <btBulletDynamicsCommon.h>
#include <glad/glad.h>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>

// Shaders Class
// Reference: https://learnopengl.com/code_viewer_gh.php?code=includes/learnopengl/shader_s.h
#include "shader_s.h"

// Camera Class
// Reference: https://learnopengl.com/code_viewer_gh.php?code=includes/learnopengl/camera.h
#include "camera.h"

// Reference: https://github.com/nothings/stb/blob/master/stb_image.h#L4
// To use stb_image, add this in *one* C++ source file.
// #define STB_IMAGE_IMPLEMENTATION
// #include <stb_image.h>

// Define Some Constants
const int mWidth = 1280;
const int mHeight = 800;

#endif //~ Glitter Header
