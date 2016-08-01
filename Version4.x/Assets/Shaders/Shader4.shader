// shader实现遮罩效果
Shader "ShaderTutorial/Shader4" {
	Properties {
		// 被遮罩的图片
		_MainTex ("Base (RGB)", 2D) = "white" {}
		// 混合图片
		_MaskLayer ("Culling Mask", 2D) = "white" {}
		//
		_CullOff ("Alpha CullOff", Range(0, 1)) = 0
	}
	SubShader {
		Tags { "RenderType"="Transparent" }
		// 关闭光照
		Lighting Off
		// 关闭深度缓存
		ZWrite Off
		// 关闭混合
		Blend Off
		// 启用AlphaTest
		AlphaTest GEqual[_CullOff]
		
		Pass {
			// 混合贴图
			SetTexture[_MaskLayer]
			{
				Combine texture
			}

			SetTexture[_MainTex]
			{
				Combine texture, previous
			}
		}
	} 
	FallBack "Diffuse"
}
