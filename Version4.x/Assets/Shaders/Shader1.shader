// 注意：Shader不区分大小写
/* 
	Unity默认创建的Shader结构
	1、表面着色器
	2、渲染类型：不透明物体
	3、支持一张纹理贴图
	4、采用Unity内置兰伯特光照模型Lighting.cginc	
*/
Shader "ShaderTutorial/Shader1" {
	// Properties属性可选：用于Inspector可视化编辑
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		// CGPROGRAM...ENDCG之间是着色器处理
		CGPROGRAM
		// 编译指定：这是一个表面着色器，着色器处理函数surf，采用兰伯特光照模型(这个编译器指令指明了这是一个表面着色器，surface着色器是Unity自己的一种Shader编写方式，将会被编译为定点/片段着色器)
		#pragma surface surf Lambert
		// 定义对应Properties中的2DTexture的变量，取样数据，在surf着色器处理函数中使用
		sampler2D _MainTex;
		// 着色器处理函数输入结构体定义
		struct Input {
			// 纹理UV值
			float2 uv_MainTex;
		};

		#pragma debug "----------------------------"
		// 着色器处理函数surf：IN--输入值，SurfaceOutput o--输出
		void surf (Input IN, inout SurfaceOutput o) {
			// tex2D(纹理数据，纹理的UV)
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			// 
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 

	// 如果没有在SubShader中找到可用的渲染方式，就使用这个“低配的”
	FallBack "Diffuse"
}
