// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "collumn shader"
{
	Properties
	{
		_heighmapcolor("heigh map color", Color) = (1,1,1,0)
		[Header(heighmap)][NoScaleOffset][SingleLineTexture]_heighmap("heigh map", 2D) = "white" {}
		[IntRange]_tilingx("tiling x", Range( 0 , 1)) = 0.2
		[IntRange]_tilingy("tiling y", Range( 0 , 1)) = 0.2
		_Float1("Float 1", Float) = 0
		_TextureSample0("Texture Sample 0", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample0;
		uniform float _tilingx;
		uniform float _tilingy;
		uniform float _Float1;
		uniform float4 _heighmapcolor;
		uniform sampler2D _heighmap;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 appendResult4 = (float4(_tilingx , _tilingy , 0.0 , 0.0));
			float2 uv_TexCoord5 = i.uv_texcoord * appendResult4.xy;
			o.Normal = ( UnpackNormal( tex2D( _TextureSample0, uv_TexCoord5 ) ) + _Float1 );
			o.Albedo = ( _heighmapcolor * saturate( tex2D( _heighmap, uv_TexCoord5 ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;439;1434;562;1812.799;598.4915;1.678895;True;False
Node;AmplifyShaderEditor.CommentaryNode;1;-1764.865,-314.5638;Inherit;False;1262.434;467.717;Comment;8;30;22;21;7;5;4;3;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1714.865,-164.1306;Inherit;False;Property;_tilingx;tiling x;2;1;[IntRange];Create;True;0;0;0;False;0;False;0.2;0.7024563;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-1713.161,-77.25246;Inherit;False;Property;_tilingy;tiling y;3;1;[IntRange];Create;True;0;0;0;False;0;False;0.2;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;4;-1420.16,-126.6537;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;-1267.783,-149.464;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-1003.912,-76.84706;Inherit;True;Property;_heighmap;heigh map;1;3;[Header];[NoScaleOffset];[SingleLineTexture];Create;True;1;heighmap;0;0;False;0;False;-1;a218f35bc157c1146a53fbabaeabea1d;a218f35bc157c1146a53fbabaeabea1d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;21;-704.4398,-116.5754;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;22;-921.6101,-265.5638;Inherit;False;Property;_heighmapcolor;heigh map color;0;0;Create;True;0;0;0;False;0;False;1,1,1,0;0.3037113,0.6132076,0.5100422,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;32;-995.3932,-521.306;Inherit;True;Property;_TextureSample0;Texture Sample 0;5;0;Create;True;0;0;0;False;0;False;-1;06d2ddc2da89e4d4988e9aacc13a6949;06d2ddc2da89e4d4988e9aacc13a6949;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;31;-676.3799,-422.8206;Inherit;False;Property;_Float1;Float 1;4;0;Create;True;0;0;0;False;0;False;0;0.16;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-671.4297,-261.2817;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;-474.7707,-515.4116;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-209.2315,-260.2952;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;collumn shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;3;0
WireConnection;4;1;2;0
WireConnection;5;0;4;0
WireConnection;7;1;5;0
WireConnection;21;0;7;0
WireConnection;32;1;5;0
WireConnection;30;0;22;0
WireConnection;30;1;21;0
WireConnection;35;0;32;0
WireConnection;35;1;31;0
WireConnection;0;0;30;0
WireConnection;0;1;35;0
ASEEND*/
//CHKSM=4B4703F3C0B0779CCCAAACFED0EBD3991AB52BF9