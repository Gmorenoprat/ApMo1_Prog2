// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TextureBlending"
{
	Properties
	{
		[Header(mud)][SingleLineTexture]_mud("mud", 2D) = "white" {}
		_mudintensity("mud intensity", Float) = 2
		_mudhigh("mud high", Float) = 0
		_heighmapcolor("heigh map color", Color) = (1,1,1,0)
		[Header(heighmap)][NoScaleOffset][SingleLineTexture]_heighmap("heigh map", 2D) = "white" {}
		_Vector0("Vector 0", Vector) = (0,1,0,0)
		[IntRange]_tilingx("tiling x", Range( 0 , 0.5)) = 0
		[IntRange]_tilingy("tiling y", Range( 0 , 0.5)) = 0
		_intensity("intensity", Float) = 0
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 2
		_Float1("Float 1", Float) = 0
		_TextureSample0("Texture Sample 0", 2D) = "bump" {}
		_Color0("Color 0", Color) = (0,0,0,0)
		_Float0("Float 0", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _heighmap;
		uniform float _tilingx;
		uniform float _tilingy;
		uniform float3 _Vector0;
		uniform float _intensity;
		uniform sampler2D _TextureSample0;
		uniform float _Float1;
		uniform float4 _heighmapcolor;
		uniform float _mudhigh;
		uniform float _mudintensity;
		uniform float _Float0;
		uniform sampler2D _mud;
		uniform float4 _mud_ST;
		uniform float4 _Color0;
		uniform float _EdgeLength;

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float4 appendResult8 = (float4(_tilingx , _tilingy , 0.0 , 0.0));
			float2 uv_TexCoord4 = v.texcoord.xy * appendResult8.xy;
			float4 tex2DNode2 = tex2Dlod( _heighmap, float4( uv_TexCoord4, 0, 0.0) );
			v.vertex.xyz += ( saturate( ( tex2DNode2.r + 0.0 ) ) * _Vector0 * _intensity );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 appendResult8 = (float4(_tilingx , _tilingy , 0.0 , 0.0));
			float2 uv_TexCoord4 = i.uv_texcoord * appendResult8.xy;
			o.Normal = ( UnpackNormal( tex2D( _TextureSample0, uv_TexCoord4 ) ) + _Float1 );
			float4 tex2DNode2 = tex2D( _heighmap, uv_TexCoord4 );
			float4 temp_cast_1 = (_mudhigh).xxxx;
			float4 temp_output_29_0 = saturate( ( pow( ( 1.0 - tex2DNode2 ) , temp_cast_1 ) * _mudintensity ) );
			float2 uv_mud = i.uv_texcoord * _mud_ST.xy + _mud_ST.zw;
			o.Albedo = ( ( _heighmapcolor * saturate( ( tex2DNode2 - temp_output_29_0 ) ) ) + ( saturate( ( temp_output_29_0 + _Float0 ) ) * tex2D( _mud, uv_mud ) * _Color0 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;533;1607;468;-349.7854;907.588;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;36;-1218.865,-642.1482;Inherit;False;1262.434;467.717;Comment;9;9;10;8;4;2;11;12;47;46;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1167.161,-404.8368;Inherit;False;Property;_tilingy;tiling y;8;1;[IntRange];Create;True;0;0;0;False;0;False;0;0.1;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1168.865,-491.7149;Inherit;False;Property;_tilingx;tiling x;7;1;[IntRange];Create;True;0;0;0;False;0;False;0;0.1;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;-874.1609,-454.238;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-721.7845,-477.0483;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;45;-567.1157,35.68758;Inherit;False;1355.028;544.5323;Comment;11;20;27;26;30;28;29;43;44;25;23;48;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;2;-457.9131,-404.4314;Inherit;True;Property;_heighmap;heigh map;5;3;[Header];[NoScaleOffset];[SingleLineTexture];Create;True;1;heighmap;0;0;False;0;False;-1;a218f35bc157c1146a53fbabaeabea1d;a218f35bc157c1146a53fbabaeabea1d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;20;-527.1225,86.93309;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-524.6551,310.475;Inherit;False;Property;_mudhigh;mud high;2;0;Create;True;0;0;0;False;0;False;0;6.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;26;-331.5613,85.68758;Inherit;False;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-347.1406,200.0659;Inherit;False;Property;_mudintensity;mud intensity;1;0;Create;True;0;0;0;False;0;False;2;1.49;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-158.6476,87.86539;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;29;-4.529672,88.71329;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-28.26172,360.0969;Inherit;False;Property;_Float0;Float 0;18;0;Create;True;0;0;0;False;0;False;0;-0.03;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;47;-112.0111,-378.8302;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;43;227.2875,225.9324;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;38;89.75072,-304.423;Inherit;False;752.5421;265.2556;Comment;4;33;32;31;34;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;23;234.8435,367.3801;Inherit;True;Property;_mud;mud;0;2;[Header];[SingleLineTexture];Create;True;1;mud;0;0;False;0;False;-1;55fde775b171a134fa159be016d84751;55fde775b171a134fa159be016d84751;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;49;316.1261,576.7313;Inherit;False;Property;_Color0;Color 0;17;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.3679245,0.3510841,0.3314792,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;31;561.0012,-236.9114;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;46;-112.4409,-464.1598;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;11;-375.6112,-593.1482;Inherit;False;Property;_heighmapcolor;heigh map color;4;0;Create;True;0;0;0;False;0;False;1,1,1,0;0.3679245,0.418424,0.490566,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;51;-444.7125,-719.2115;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;37;908.9855,-630.5786;Inherit;False;455.1362;591.2354;Comment;4;14;16;15;24;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;44;359.8764,225.9324;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;557.916,349.735;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;34;692.3116,-234.5864;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;968.3292,-161.8485;Inherit;False;Property;_intensity;intensity;9;0;Create;True;0;0;0;False;0;False;0;4.9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;14;958.9855,-354.3509;Inherit;False;Property;_Vector0;Vector 0;6;0;Create;True;0;0;0;False;0;False;0,1,0;0,0.03,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-125.4308,-588.8661;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;53;1037.235,-709.75;Inherit;False;Property;_Float1;Float 1;15;0;Create;True;0;0;0;False;0;False;0;0.41;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;50;740.0753,-864.1597;Inherit;True;Property;_TextureSample0;Texture Sample 0;16;0;Create;True;0;0;0;False;0;False;-1;None;06d2ddc2da89e4d4988e9aacc13a6949;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;378.736,-169.6658;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;127.2424,-174.117;Inherit;False;Property;_mudhighadjustable;mud high adjustable;3;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;54;1237.785,-859.588;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;1195.121,-232.9768;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;961.9597,-580.5786;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1471.224,-579.3421;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;TextureBlending;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;2;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;10;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;0;9;0
WireConnection;8;1;10;0
WireConnection;4;0;8;0
WireConnection;2;1;4;0
WireConnection;20;0;2;0
WireConnection;26;0;20;0
WireConnection;26;1;27;0
WireConnection;28;0;26;0
WireConnection;28;1;30;0
WireConnection;29;0;28;0
WireConnection;47;0;2;0
WireConnection;47;1;29;0
WireConnection;43;0;29;0
WireConnection;43;1;48;0
WireConnection;31;0;2;1
WireConnection;46;0;47;0
WireConnection;51;0;4;0
WireConnection;44;0;43;0
WireConnection;25;0;44;0
WireConnection;25;1;23;0
WireConnection;25;2;49;0
WireConnection;34;0;31;0
WireConnection;12;0;11;0
WireConnection;12;1;46;0
WireConnection;50;1;51;0
WireConnection;32;0;33;0
WireConnection;54;0;50;0
WireConnection;54;1;53;0
WireConnection;15;0;34;0
WireConnection;15;1;14;0
WireConnection;15;2;16;0
WireConnection;24;0;12;0
WireConnection;24;1;25;0
WireConnection;0;0;24;0
WireConnection;0;1;54;0
WireConnection;0;11;15;0
ASEEND*/
//CHKSM=51956E283D51B019682BF134507327306B903EE8