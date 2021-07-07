// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Boulder Shader"
{
	Properties
	{
		[IntRange]_tilingx1("tiling x", Range( 0 , 0.5)) = 0
		[IntRange]_tilingy1("tiling y", Range( 0 , 0.5)) = 0
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "bump" {}
		_Float0("Float 0", Float) = 0
		_Color0("Color 0", Color) = (0,0,0,0)
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
		uniform float _tilingx1;
		uniform float _tilingy1;
		uniform float _Float0;
		uniform sampler2D _TextureSample1;
		uniform float4 _Color0;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 appendResult4 = (float4(_tilingx1 , _tilingy1 , 0.0 , 0.0));
			float2 uv_TexCoord5 = i.uv_texcoord * appendResult4.xy;
			o.Normal = ( UnpackNormal( tex2D( _TextureSample0, uv_TexCoord5 ) ) + _Float0 );
			o.Albedo = ( saturate( tex2D( _TextureSample1, uv_TexCoord5 ) ) * _Color0 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;430;1613;571;1263.967;-26.70866;1.054157;True;False
Node;AmplifyShaderEditor.RangedFloatNode;2;-1584.19,94.85007;Inherit;False;Property;_tilingy1;tiling y;1;1;[IntRange];Create;True;0;0;0;False;0;False;0;0.2819411;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1585.894,7.971942;Inherit;False;Property;_tilingx1;tiling x;0;1;[IntRange];Create;True;0;0;0;False;0;False;0;0.1415372;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;4;-1291.19,45.44884;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;5;-1138.813,22.63854;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;-873.3182,-6.164304;Inherit;True;Property;_TextureSample1;Texture Sample 1;2;0;Create;True;0;0;0;False;0;False;-1;None;85a39e2badaa4454fab3ddd20c631fd8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-871.2623,-240.1307;Inherit;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;0;False;0;False;-1;None;13256d1d808bc6c4aab4c6f356e96b04;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-578.4577,-131.4895;Inherit;False;Property;_Float0;Float 0;4;0;Create;True;0;0;0;False;0;False;0;-0.09;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;11;-561.7642,84.07292;Inherit;False;Property;_Color0;Color 0;5;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.492613,0.6190504,0.7735849,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;14;-550.3051,-0.6989214;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;10;-386.8889,-234.9;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-319.7368,-1.26635;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-137.1024,-1.399004;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Boulder Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;3;0
WireConnection;4;1;2;0
WireConnection;5;0;4;0
WireConnection;6;1;5;0
WireConnection;7;1;5;0
WireConnection;14;0;6;0
WireConnection;10;0;7;0
WireConnection;10;1;9;0
WireConnection;12;0;14;0
WireConnection;12;1;11;0
WireConnection;0;0;12;0
WireConnection;0;1;10;0
ASEEND*/
//CHKSM=01CE2BF2259657695132CC96EE7E479BB4FBD077