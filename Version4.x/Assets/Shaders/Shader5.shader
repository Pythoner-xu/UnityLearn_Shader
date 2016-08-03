Shader "ShaderTutorial/Shader5" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_RampTex ("Ramp Tex", 2D) = "" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf CustomDiffuse

		sampler2D _MainTex;
		sampler2D _RampTex;

		struct Input {
			float2 uv_MainTex;
		};

		// 表面着色器处理函数
		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}

		// 自定义光照模型
		inline float4 LightingCustomDiffuse(SurfaceOutput s, fixed3 lightDir, fixed atten)
		{
			float difLight = max(0, dot(s.Normal, lightDir));
			float hLambert = difLight * 0.5 + 0.5;
			float3 ramp = tex2D(_RampTex, float2(0, hLambert)).rgb;

			float4 col;
			col.rgb = s.Albedo * _LightColor0.rgb * ramp;
			col.a = s.Alpha;

			return col;

		}
		ENDCG
	} 
	FallBack "Diffuse"
}
