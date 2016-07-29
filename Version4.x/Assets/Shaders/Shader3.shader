Shader "ShaderTutorial/Shader3" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// 自定义光照模型
		#pragma surface surf CustomDiffuse

		sampler2D _MainTex;
		
		struct Input {
			float2 uv_MainTex;
		};

		// 表面着色器处理函数（输入纹理数据，输出处理后的像素数据）
		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}

		// 自定义Lambert光照模型（经过表面着色器处理后的输出结果作为输入，进行光照模型的处理）
		inline float4 LightingCustomDiffuse (SurfaceOutput s, fixed3 lightDir, fixed atten)
		{
			float difLight = max(0, dot(s.Normal, lightDir));
			float hLambert = difLight * 0.5 + 0.5;
			float4 col;
			col.rgb = s.Albedo * _LightColor0.rgb * (difLight * atten * 2);
			col.a = s.Alpha;

			return col;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
