Shader "ShaderTutorial/Shader2" {
	Properties {
		// 自发光
		_EmissiveColor ("Emissive Color", Color) = (1, 1, 1, 1)
		// 环境光
		_AmbientColor ("Ambient Color", Color) = (1, 1, 1, 1)
		// 滑块
		_SliderValue ("Slider Value", Range(0, 10)) = 1
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert
		
		// 定义变量接收UI输入(必须与Properties中的属性名字对应) Unity会自动关联两者
		float4 _EmissiveColor;
		float4 _AmbientColor;
		float _SliderValue;

		struct Input {
			float2 ui_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			float4 c;
			// （自发光+环境光）求幂操作 pow(底数，指数)
			c = pow((_EmissiveColor + _AmbientColor), _SliderValue);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
