#version 450

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec3 inNormal;

layout (binding = 0) uniform UBO 
{
	mat4 projection;
	mat4 model;
	float lodBias;
} ubo;

layout (location = 0) out vec3 outPos;
layout (location = 1) out vec3 outNormal;
layout (location = 2) out float outLodBias;
layout (location = 3) out vec3 outViewVec;
layout (location = 4) out vec3 outLightVec;
layout (location = 5) out mat4 outInvModelView;

out gl_PerVertex 
{
	vec4 gl_Position;
};

void main() 
{
	gl_Position = ubo.projection * ubo.model * vec4(inPos.xyz, 1.0);
	
	outPos = vec3(ubo.model * vec4(inPos, 1.0));
	outNormal = mat3(ubo.model) * inNormal;	
	outLodBias = ubo.lodBias;
	
	outInvModelView = inverse(ubo.model);

	vec3 lightPos = vec3(0.0f, -5.0f, 5.0f);
	outLightVec = lightPos.xyz - outPos.xyz;
	outViewVec = -outPos.xyz;		
}
